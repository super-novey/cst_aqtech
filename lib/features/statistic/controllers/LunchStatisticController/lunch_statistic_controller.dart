import 'package:get/get.dart';
import 'package:hrm_aqtech/data/statistic/lunch_statistic_repository.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/network_manager.dart';
import 'package:hrm_aqtech/features/statistic/controllers/LunchStatisticController/filter_date_controller.dart';
import 'package:hrm_aqtech/features/statistic/models/lunch_statistics.dart';

class LunchStatisticController extends GetxController {
  static LunchStatisticController get instance => Get.find();

  final _lunchStatisticRepository = Get.put(LunchStatisticRepository());
  var isLoading = false.obs;
  var totalIndividualDayOff = 0;
  var totalWorkingOnline = 0;
  var totalAQDayOff = 0;
  var totalCommissionDay = 0;
  var totalDaysRemaining = 0;

  List<LunchStatistics> lunchStatisticList = <LunchStatistics>[].obs;

  @override
  void onInit() {
    fetchLunchStatistics();
    super.onInit();
  }

  Future<void> fetchLunchStatistics() async {
    try {
      isLoading.value = true;
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }
      lunchStatisticList.assignAll(
          await _lunchStatisticRepository.getLunchStatistic(
              LunchFilterDateController.instance.selectedMonth.value,
              LunchFilterDateController.instance.selectedYear.value));
    } finally {
      isLoading.value = false;
      totalIndividualDayOff = 0;
      totalWorkingOnline = 0;
      totalAQDayOff = 0;
      totalCommissionDay = 0;
      totalDaysRemaining = 0;
      calculateTotal();
    }
  }

  void calculateTotal() {
    for (var x in lunchStatisticList) {
      totalIndividualDayOff += x.totalIndividualDayOff;
      totalAQDayOff += x.totalAQDayOff;
      totalWorkingOnline += x.totalWorkingOnline;
      totalCommissionDay += x.totalCommissionDay;
      int tmp = 21 -
          x.totalAQDayOff -
          x.totalIndividualDayOff -
          x.totalWorkingOnline -
          x.totalCommissionDay;
      totalDaysRemaining += tmp;
    }
  }
}
