import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OvertimeFilterDateController extends GetxController {
  static OvertimeFilterDateController get instance => Get.find();

  var selectedYear = DateTime.now().year.obs;
  TextEditingController yearController = TextEditingController();

  @override
  void onInit() {
    updateSelectedYear(DateTime.now().year);
    super.onInit();
  }

  void updateSelectedYear(int year) {
    selectedYear.value = year;
    yearController.text = year.toString();
  }

  void showYearPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 20),
              lastDate: DateTime(DateTime.now().year + 20),
              selectedDate: DateTime(selectedYear.value),
              onChanged: (DateTime dateTime) {
                updateSelectedYear(dateTime.year);
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }
}
