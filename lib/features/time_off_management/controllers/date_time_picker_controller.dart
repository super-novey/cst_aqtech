import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/time_off_management/controllers/filter_controller.dart';

class DateTimePickerController extends GetxController {
  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();

  @override
  void onInit() {
    super.onInit();

    startDate.value = DateTime(DateTime.now().year, 1, 1);
    endDate.value = DateTime.now();
    final FilterController filterController = Get.find();
    filterController.setStartDate(startDate.value!);
    filterController.setEndDate(endDate.value!);
    filterController.filter();
  }

  void selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      startDate.value = picked;
      final FilterController filterController = Get.find();
      filterController.setStartDate(picked);
      filterController.filter();
    }
  }

  void selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      endDate.value = picked;
      final FilterController filterController = Get.find();
      filterController.setEndDate(picked);
      filterController.filter();
    }
  }

  void clearDates() {
    startDate.value = null;
    endDate.value = null;
    final FilterController filterController = Get.find();
    filterController.clearDates();
  }
}
