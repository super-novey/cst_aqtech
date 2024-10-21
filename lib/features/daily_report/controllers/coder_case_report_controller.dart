import 'package:get/get.dart';
import 'package:hrm_aqtech/data/daily_report/daily_report_repository.dart';
import 'package:hrm_aqtech/features/daily_report/models/coder_case_report_model.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/network_manager.dart';
import 'package:intl/intl.dart';


class CoderCaseReportController extends GetxController {
  var coderCaseReportList = <CoderCaseReport>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var showCanXuLy = true.obs;
  var showSoCaseTrongNgay = true.obs;
  var showXuLyTre = true.obs;
  var showTgCanXyLy = true.obs;
  var showLuongGioTrongNgay = true.obs;

  final DailyReportRepository _repository = DailyReportRepository();

  @override
  void onInit() {
    final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    fetchCoderCaseReport(currentDate);
    super.onInit();
  }

  void fetchCoderCaseReport(String selectedDate) async {
  try {
    isLoading(true);
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      return;
    }
    final data = await _repository.fetchCoderCaseReport(selectedDate);
    coderCaseReportList.value = data;
  } catch (e) {
    errorMessage.value = e.toString();
  } finally {
    isLoading(false);
  }
}


}
