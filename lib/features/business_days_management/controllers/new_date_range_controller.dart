import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/business_days_management/controllers/update_business_day_controller.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';
import 'package:hrm_aqtech/utils/helpers/helper_function.dart';

class NewDateRangeController extends GetxController {
  //static DateRangeController get instance => Get.find();
  var dateRange = DateTimeRange(start: DateTime.now(), end: DateTime.now()).obs;
  var sumDay = 1.0.obs;

  @override
  void onInit() {
    // dateRange =
    //     DateTimeRange(start: DateTime(DateTime.now().year), end: DateTime.now())
    //         .obs;
    super.onInit();
  }

  Future<void> showRangeDatePicker() async {
    DateTimeRange? picked = await showDateRangePicker(
        fieldStartLabelText: "Lọc từ ngày",
        fieldEndLabelText: "Lọc đến ngày",
        context: Get.context!,
        firstDate: DateTime(
          DateTime.now().year - 20,
        ),
        lastDate: DateTime(
          DateTime.now().year + 20,
        ),
        initialDateRange: dateRange.value,
        initialEntryMode: DatePickerEntryMode.input);
    if (picked != null && picked != dateRange.value) {
      dateRange.value = picked;
      UpdateBusinessDayController.instance.sumDay.value.text =
          MyFormatter.formatDouble(HeplerFunction.calculateWeekdays(
              dateRange.value.start, dateRange.value.end));
    }
  }
}
