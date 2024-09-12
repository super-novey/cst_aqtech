import 'package:get/get.dart';
import 'package:hrm_aqtech/data/daily_report/daily_report_repository.dart';
import 'package:hrm_aqtech/features/daily_report/models/sup_case_report_model.dart';


class SupCaseReportController extends GetxController {
  var supCaseReportList = <SupCaseReport>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  final DailyReportRepository _repository = DailyReportRepository();

  @override
  void onInit() {
    fetchSupCaseReport();
    super.onInit();
  }

  void fetchSupCaseReport() async {
  try {
    isLoading(true);
    final data = await _repository.fetchSupCaseReport();
    supCaseReportList.value = data;
  } catch (e) {
    errorMessage.value = e.toString();
  } finally {
    isLoading(false);
  }
}

}
