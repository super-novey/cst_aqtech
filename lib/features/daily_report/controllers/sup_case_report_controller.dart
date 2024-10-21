import 'package:get/get.dart';
import 'package:hrm_aqtech/data/daily_report/daily_report_repository.dart';
import 'package:hrm_aqtech/features/daily_report/models/sup_case_report_model.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/network_manager.dart';
import 'package:intl/intl.dart';


class SupCaseReportController extends GetxController {
  var supCaseReportList = <SupCaseReport>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var showCaseLamTrongNgay = true.obs;
  var showCanXuLy = true.obs;
  var showXuLyTre = true.obs;
  var showPhanTichTre = true.obs;
  var showTestTre = true.obs;

  final DailyReportRepository _repository = DailyReportRepository();

  @override
  void onInit() {
    final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    fetchSupCaseReport(currentDate);
    super.onInit();
  }

  void fetchSupCaseReport(String selectedDate) async {
  try {
    isLoading(true);
    final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }
    final data = await _repository.fetchSupCaseReport(selectedDate);
    supCaseReportList.value = data;
  } catch (e) {
    errorMessage.value = e.toString();
  } finally {
    isLoading(false);
  }
}

}
