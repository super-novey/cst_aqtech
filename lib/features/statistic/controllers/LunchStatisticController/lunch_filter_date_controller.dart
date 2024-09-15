import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LunchFilterDateController extends GetxController {
  static LunchFilterDateController get instance => Get.find();
  var selectedYear = 0.obs;
  var selectedMonth = 0.obs;
  TextEditingController dateController = TextEditingController();

  @override
  void onInit() {
    updateDate(DateTime.now());
    super.onInit();
  }

  void updateDate(DateTime date) {
    selectedMonth.value = date.month;
    selectedYear.value = date.year;
    dateController.text = "$selectedMonth/$selectedYear";
  }
}
