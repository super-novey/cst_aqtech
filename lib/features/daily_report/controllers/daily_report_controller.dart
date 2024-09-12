import 'package:get/get.dart';
import 'package:hrm_aqtech/utils/constants/enums.dart';

class DailyReportController extends GetxController {
  var selectedChart = Chart.aqcase.obs;

  void updateChart(Chart newChart) {
    selectedChart.value = newChart;
  }
}
