import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateTimePickerController extends GetxController {
  var startDate = DateTime(DateTime.now().year, 1, 1).obs;
  var endDate = DateTime.now().obs;

  static DateTimePickerController get instance => Get.find();

  void selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate.value,
      firstDate: DateTime(1),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      startDate.value = picked;
    }
  }

  void selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate.value,
      firstDate: DateTime(1),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      endDate.value = picked;
    }
  }

  void clearDates() {
    startDate.value = DateTime(DateTime.now().year, 1, 1);
    endDate.value = DateTime.now();
  }
}
