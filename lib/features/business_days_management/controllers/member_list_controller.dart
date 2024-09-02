import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemberListController extends GetxController {
  var memberNameController = <String>[].obs;
  var memberExpensesController = <TextEditingController>[].obs;

  final List<String> names = [
    'Option 1',
    'Option 2',
    'Option 3'
  ]; // Danh sach ten cac nhan vien

  @override
  void onClose() {
    for (var controller in memberExpensesController) {
      controller.dispose();
    }
    super.onClose();
  }

  void add() {
    memberExpensesController.add(TextEditingController());
    memberNameController.add(names.first);
  }

  void remove(int index) {
    memberExpensesController[index].dispose();
    memberNameController.removeAt(index);
    memberExpensesController.removeAt(index);
  }
}
