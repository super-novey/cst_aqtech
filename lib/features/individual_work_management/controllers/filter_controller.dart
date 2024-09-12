import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  static FilterController get instance => Get.find();

  RxInt year = DateTime.now().year.obs;

  var selectedEmployee = Rxn<String>();

  var isFilterDataReady = false.obs;

  @override
  onInit() {
    super.onInit();
  }

  void updateYear(int newYear) {
    year.value = newYear;
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
              selectedDate: DateTime(year.value),
              onChanged: (DateTime dateTime) {
                updateYear(dateTime.year); // Corrected method call
                Get.back(); // Close the dialog
              },
            ),
          ),
        );
      },
    );
  }
}
