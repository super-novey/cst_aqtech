import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  static FilterController get instance => Get.find();

  RxInt year = DateTime.now().year.obs; // Track the selected year
  var selectedEmployee = Rxn<String>(); // Track selected employee ID
  var isFilterDataReady = false.obs; // Track filter data readiness

  void updateYear(int newYear) {
    year.value = newYear; // Update the selected year
  }

  void selectYear(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Year"),
          content: SizedBox(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(1),
              lastDate: DateTime(2300),
              selectedDate: DateTime(year.value), // Use current year
              onChanged: (DateTime dateTime) {
                updateYear(dateTime.year); // Update year on selection
                Get.back(); // Close the dialog
              },
            ),
          ),
        );
      },
    );
  }
}
