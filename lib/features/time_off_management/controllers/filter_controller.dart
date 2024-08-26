import 'dart:developer';

import 'package:get/get.dart';
import 'package:hrm_aqtech/features/time_off_management/controllers/general_time_off_controller.dart';
import 'package:hrm_aqtech/features/time_off_management/models/general_time_off_model.dart';

class FilterController extends GetxController {
  DateTime? startDate;
  DateTime? endDate;

  var generalTimeOffs = <GeneralTimeOff>[].obs;
  static FilterController get instance => Get.find();

  // FilterController([this.startDate, this.endDate]);

  @override
  void onInit() {
    super.onInit();
    // setStartDate(DateTime(DateTime.now().year, 1, 1));
    // setEndDate(DateTime.now());
    // log('inited');
    // update();
    filter();
  }

  void setStartDate(DateTime date) {
    startDate = date;
    update();
  }

  void setEndDate(DateTime date) {
    endDate = date;
    update();
  }

  // void filter() {
  //   final GeneralTimeOffController timeOffController = Get.find();

  //   if (startDate == null && endDate == null) {
  //     generalTimeOffs.value = timeOffController.generalTimeOffs;
  //     log('this');
  //   } else {
  //     log('khac null');

  //     generalTimeOffs.value = timeOffController.generalTimeOffs.where((dayOff) {
  //       bool matchesDateRange = true;
  //       log('co kq');

  //       if (startDate != null && endDate != null) {
  //         DateTime dateFrom = DateTime.parse(dayOff.dateFrom.toString());
  //         DateTime dateTo = DateTime.parse(dayOff.dateTo.toString());

  //         matchesDateRange =
  //             dateFrom.isAfter(startDate!.subtract(const Duration(days: 1))) &&
  //                 dateTo.isBefore(endDate!.add(const Duration(days: 1)));
  //       }

  //       return matchesDateRange;
  //     }).toList();
  //   }
  // }
  void filter() {
    final GeneralTimeOffController timeOffController = Get.find();

    if (startDate == null && endDate == null) {
      generalTimeOffs.value = timeOffController.generalTimeOffs;
      log('startDate and endDate are both null');
    } else {
      log('startDate: $startDate, endDate: $endDate');

      generalTimeOffs.value = timeOffController.generalTimeOffs.where((dayOff) {
        bool matchesDateRange = true;

        if (startDate != null && endDate != null) {
          DateTime dateFrom = dayOff.dateFrom;
          DateTime dateTo = dayOff.dateTo;

          matchesDateRange =
              dateFrom.isAfter(startDate!.subtract(const Duration(days: 1))) &&
                  dateTo.isBefore(endDate!.add(const Duration(days: 1)));
        }

        return matchesDateRange;
      }).toList();
    }
  }

  void clearDates() {
    startDate = null;
    endDate = null;
    filter();
  }
}
