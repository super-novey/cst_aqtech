import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/data/statistic/commissionday_statistic_repository.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/network_manager.dart';
import 'package:hrm_aqtech/features/statistic/controllers/CommissionDayControllers/commissionday_filter_date_controller.dart';
import 'package:hrm_aqtech/features/statistic/controllers/CommissionDayControllers/quarter_dropdown_controller.dart';
import 'package:hrm_aqtech/features/statistic/models/commissionday_statistic.dart';

class CommissiondayStatisticController extends GetxController {
  static CommissiondayStatisticController get instance => Get.find();

  final _commissionStatisticRepository =
      Get.put(CommissiondayStatisticRepository());
  var isLoading = false.obs;

  var totalCommissionDay = 0;
  var totalCommissionPayment = 0;

  List<CommissionDay> commissionStatisticList = <CommissionDay>[].obs;

  @override
  void onInit() {
    fetchCommissionStatistics();
    super.onInit();
  }

  Future<void> fetchCommissionStatistics() async {
    try {
      isLoading.value = true;
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }
      commissionStatisticList.assignAll(
          await _commissionStatisticRepository.getCommissionDayStatistic(
              getQuarterRange(
                  CommissiondayFilterDateController.instance.selectedYear.value,
                  QuarterDropdownController.instance.selectedQuarter.value),
              CommissiondayFilterDateController.instance.selectedYear.value));
    } finally {
      isLoading.value = false;
      totalCommissionDay = 0;
      totalCommissionPayment = 0;
      calculateTotal();
    }
  }

  void calculateTotal() {
    for (var x in commissionStatisticList) {
      totalCommissionPayment += x.totalCommissionPayment;
      totalCommissionDay += x.totalCommissionDay;
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
