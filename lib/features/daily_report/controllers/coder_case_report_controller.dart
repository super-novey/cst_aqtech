import 'package:get/get.dart';
import 'package:hrm_aqtech/data/daily_report/daily_report_repository.dart';
import 'package:hrm_aqtech/features/daily_report/models/coder_case_report_model.dart';


class CoderCaseReportController extends GetxController {
  var coderCaseReportList = <CoderCaseReport>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  final DailyReportRepository _repository = DailyReportRepository();

  @override
  void onInit() {
    fetchCoderCaseReport();
    super.onInit();
  }

  void fetchCoderCaseReport() async {
  try {
    isLoading(true);
    final data = await _repository.fetchCoderCaseReport();
    coderCaseReportList.value = data;
  } catch (e) {
    errorMessage.value = e.toString();
  } finally {
    isLoading(false);
  }
}

}
