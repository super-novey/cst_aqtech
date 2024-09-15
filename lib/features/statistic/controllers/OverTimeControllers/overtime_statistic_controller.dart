import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/data/statistic/overtime_statistic_repository.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/network_manager.dart';
import 'package:hrm_aqtech/features/statistic/controllers/OverTimeControllers/overtime_filter_date_controller.dart';
import 'package:hrm_aqtech/features/statistic/controllers/OverTimeControllers/overtime_quarter_dropdown_controller.dart';
import 'package:hrm_aqtech/features/statistic/models/overtime_statistic.dart';

class OvertimeStatisticController extends GetxController {
  static OvertimeStatisticController get instance => Get.find();

  List<OverTimeStatistic> overtimeStatisticList = <OverTimeStatistic>[].obs;
  final _overtimeStatisticRepository = Get.put(OvertimeStatisticRepository());
  var isLoading = false.obs;
  var sumHours = 0.0;

  @override
  void onInit() {
    fetchOvertimeStatistics();
    super.onInit();
  }

  Future<void> fetchOvertimeStatistics() async {
    try {
      isLoading.value = true;
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }
      overtimeStatisticList.assignAll(
          await _overtimeStatisticRepository.getOverTimeStatistic(
              getQuarterRange(
                  OvertimeFilterDateController.instance.selectedYear.value,
                  OvertimeQuarterDropdownController.instance.selectedQuarter.value),
              OvertimeFilterDateController.instance.selectedYear.value));
    } finally {
      isLoading.value = false;
      sumHours = 0.0;
      calculateSumHours();
    }
  }

  void calculateSumHours() {
    for (var x in overtimeStatisticList) {
      sumHours += x.sumHours;
      
    }
  }

  DateTimeRange getQuarterRange(int year, String quarter) {
    DateTime startDate;
    DateTime endDate;

    switch (quarter) {
      case "Q1":
        startDate = DateTime(year, 1, 1); // January 1st
        endDate = DateTime(year, 3, 31); // March 31st
        break;
      case "Q2":
        startDate = DateTime(year, 4, 1); // April 1st
        endDate = DateTime(year, 6, 30); // June 30th
        break;
      case "Q3":
        startDate = DateTime(year, 7, 1); // July 1st
        endDate = DateTime(year, 9, 30); // September 30th
        break;
      case "Q4":
        startDate = DateTime(year, 10, 1); // October 1st
        endDate = DateTime(year, 12, 31); // December 31st
        break;
      default:
        throw ArgumentError("Qúy không hợp lệ: $quarter");
    }

    return DateTimeRange(start: startDate, end: endDate);
  }
}
