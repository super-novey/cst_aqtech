import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/employee_management/models/employee_tfs_name.dart';

class FilterController extends GetxController {
  static FilterController get instance => Get.find();

  RxInt year = DateTime.now().year.obs;
  var selectedEmployee = Rxn<String>();
  var isFilterDataReady = false.obs;
  RxString searchQuery = ''.obs;

  @override
  void onClose() {
    super.onClose();
    searchQuery.value = '';
    selectedEmployee.value = '';
    year.value = DateTime.now().year;
  }

  List<String> getFilteredEmployees(List<EmployeeTFSName> employees) {
    final searchQueryLowered = searchQuery.value.toLowerCase().trim();
    return employees
        .where((employee) =>
            employee.fullName.toLowerCase().contains(searchQueryLowered))
        .map((employee) => employee.id.toString())
        .toList();
  }

  void updateSelectedEmployee(List<String> dropdownValues) {
    if (selectedEmployee.value != null &&
        !dropdownValues.contains(selectedEmployee.value)) {
      selectedEmployee.value =
          dropdownValues.isNotEmpty ? dropdownValues.first : null;
    }
  }

  void initializeSelectedEmployee(List<String> dropdownValues) {
    if (selectedEmployee.value == null && dropdownValues.isNotEmpty) {
      selectedEmployee.value = dropdownValues.first;
    }
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
                updateYear(dateTime.year);
                Get.back();
              },
            ),
          ),
        );
      },
    );
  }
}
