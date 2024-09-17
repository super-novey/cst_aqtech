import 'package:get/get.dart';
import 'package:hrm_aqtech/data/daily_report/daily_report_repository.dart';
import 'package:hrm_aqtech/features/daily_report/models/case_waiting_time_model.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/network_manager.dart';


class CaseWaitingTimeController extends GetxController {
  var caseWaitingTimeList = <CaseWaitingTime>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  final DailyReportRepository _repository = DailyReportRepository();

  @override
  void onInit() {
    fetchCaseWaitingTimeData();
    super.onInit();
  }

  void fetchCaseWaitingTimeData() async {
    try {
      isLoading(true);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }
      final data = await _repository.fetchCaseWaitingTimeData();
      caseWaitingTimeList.value = data;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
   int getTotalSoCase() {
    return caseWaitingTimeList.fold(0, (sum, item) => sum + item.soCase);
  }
}
