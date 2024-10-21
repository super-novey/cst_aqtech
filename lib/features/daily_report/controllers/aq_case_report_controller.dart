import 'package:get/get.dart';
import 'package:hrm_aqtech/data/daily_report/daily_report_repository.dart';
import 'package:hrm_aqtech/features/daily_report/models/aq_case_report_model.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/network_manager.dart';
import 'package:intl/intl.dart';


class AqCaseReportController extends GetxController {
  var aqCaseReportList = <AqCaseReport>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var showTongCase = true.obs;
  var showConHan = true.obs;
  var showTreHan = true.obs;
  var showNhanSu = true.obs;

  final DailyReportRepository _repository = DailyReportRepository();

  @override
  void onInit() {
    final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    fetchAqCaseReport(currentDate);
    super.onInit();
  }

  void fetchAqCaseReport(String selectedDate) async {
    try {
      isLoading(true);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }
      final data = await _repository.fetchAQCaseReport(selectedDate);
      aqCaseReportList.value = data;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
}
