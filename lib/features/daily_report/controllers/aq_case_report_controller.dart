import 'package:get/get.dart';
import 'package:hrm_aqtech/data/daily_report/daily_report_repository.dart';
import 'package:hrm_aqtech/features/daily_report/models/aq_case_report_model.dart';


class AqCaseReportController extends GetxController {
  var aqCaseReportList = <AqCaseReport>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  final DailyReportRepository _repository = DailyReportRepository();

  @override
  void onInit() {
    fetchAqCaseReport();
    super.onInit();
  }

  void fetchAqCaseReport() async {
    try {
      isLoading(true);
      final data = await _repository.fetchAQCaseReport();
      aqCaseReportList.value = data;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
}
