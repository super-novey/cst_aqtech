import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/employee_management/models/employee_model.dart';

class MemberListController extends GetxController {
  var memberNameController = <Employee>[].obs;
  List<Employee> allEmployees = <Employee>[];
  var memberExpensesController = <TextEditingController>[].obs;

  @override
  void onClose() {
    for (var controller in memberExpensesController) {
      controller.dispose();
    }
    super.onClose();
  }

  void add() {
    memberExpensesController.add(TextEditingController(text: '0'));
    memberNameController.add(allEmployees[0]);
  }

  void remove(int index) {
    memberExpensesController[index].dispose();
    memberNameController.removeAt(index);
    memberExpensesController.removeAt(index);
  }
}
