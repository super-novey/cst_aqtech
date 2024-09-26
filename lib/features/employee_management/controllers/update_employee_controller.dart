import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/data/employees/employee_repository.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/network_manager.dart';
import 'package:hrm_aqtech/features/employee_management/models/employee_model.dart';
import 'package:hrm_aqtech/utils/constants/enums.dart';
import 'package:hrm_aqtech/utils/constants/image_paths.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/popups/full_screen_loader.dart';
import 'package:hrm_aqtech/utils/popups/loaders.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UpdateEmployeeController extends GetxController {
  static UpdateEmployeeController get instance => Get.find();
  var isEditting = false.obs;
  var isAdd = false.obs;
  var isActive = false.obs;
  var isLeader = false.obs;
  var isLunch = false.obs;
  var selectedDepartment = EmployeeRole.Developer.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController tfsController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController absenceQuotaController = TextEditingController();
  TextEditingController wfhQuotaController = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  var avatar = ''.obs;
  @override
  void onClose() {
    // emailController.dispose();
    // fullNameController.dispose();
    // tfsController.dispose();
    // nickNameController.dispose();
    // phoneController.dispose();
    // absenceQuotaController.dispose();
    // wfhQuotaController.dispose();
    // startDate.dispose();
    // birthDateController.dispose();
    super.onClose();
  }

  void toggleEditting() {
    isEditting.value = !isEditting.value;
  }

  void toggle(int value) {
    switch (value) {
      case 0:
        isLeader.value = !isLeader.value;
        break;
      case 1:
        isLunch.value = !isLunch.value;
        break;
      default:
        isActive.value = !isActive.value;
    }
  }

  void save(Employee newEmployee, bool isAdd) async {
    try {
      // start loading
      FullScreenLoader.openDialog("Đang xử lý...", MyImagePaths.docerAnimation);

      // // check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      // Form validator
      // ...........

      _getEmployeeFromForm(newEmployee);
      if (isAdd) {
        // Xu ly them
        await EmployeeRepository.instance.addEmployee(newEmployee);
        EmployeeController.instance.fetchEmployees();
        Get.back();
        this.isAdd.value = false; // cap nhat truong idAdd
        Loaders.successSnackBar(
            title: "Thành công!", message: "Đã thêm nhân viên");
      } else {
        // xu ly luu qua api
        await EmployeeRepository.instance.updateEmployeeInfor(newEmployee);
        EmployeeController.instance.fetchEmployees();
        Get.back();
        toggleEditting();
        Loaders.successSnackBar(
            title: "Thành công!", message: "Cập nhật nhân viên");
      }
    } catch (e) {
      Loaders.errorSnackBar(title: "Oops", message: e.toString());
    } finally {
      FullScreenLoader.stopLoading();
    }
  }

  void delete(String id) {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(MySizes.md),
        title: "Xóa nhân viên",
        middleText: "Xóa bạn này ra khỏi công ty",
        confirm: ElevatedButton(
            onPressed: () async {
              await EmployeeRepository.instance.deleteEmployee(id);
              EmployeeController.instance.fetchEmployees();
              Navigator.of(Get.overlayContext!).pop();
              Get.back();
              Loaders.successSnackBar(
                  title: "Thành công!", message: "Xóa nhân viên");
            },
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                backgroundColor: Colors.red,
                side: const BorderSide(color: Colors.red)),
            child: const Text("Xóa")),
        cancel: OutlinedButton(
            style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: MySizes.md, vertical: 0)),
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: const Text("Quay lại")));
  }

  void _getEmployeeFromForm(Employee newEmployee) {
    newEmployee.email = emailController.text.toString().trim();
    newEmployee.fullName = fullNameController.text.toString().trim();
    newEmployee.tfsName = tfsController.text.toString().trim();
    newEmployee.nickName = nickNameController.text.toString().trim();
    newEmployee.isActive = isActive.value;
    // newEmployee.isLunch = isLunch.value;
    newEmployee.isLeader = isLeader.value;
    newEmployee.phone = phoneController.text.toString().trim();
    // newEmployee.wfhQuota = int.parse(wfhQuotaController.text);
    // newEmployee.absenceQuota = int.parse(absenceQuotaController.text);
    newEmployee.birthDate =
        DateFormat("dd/MM/yyyy").parse(birthDateController.text);
    newEmployee.startDate = DateFormat("dd/MM/yyyy").parse(startDate.text);
    newEmployee.role = selectedDepartment.value;
  }

  Future<void> selectImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        final bytes = await image.readAsBytes();
        avatar.value = 'data:image/png;base64,${base64Encode(bytes)}';
      } else {
        print("No image selected.");
      }
    } catch (e) {
      Loaders.errorSnackBar(
          title: "Error", message: "Failed to pick image: $e");
      print("Error selecting image: $e");
    }
  }

  Future<void> loadAvatar(String employeeId) async {
    try {
      FullScreenLoader.openDialog(
          "Đang tải ảnh lên...", MyImagePaths.docerAnimation);

      await EmployeeRepository.instance.uploadAvatar(employeeId, avatar.value);

      Loaders.successSnackBar(
          title: "Thành công", message: "Avatar đã được cập nhật.");
    } catch (e) {
      Loaders.errorSnackBar(title: "Oops", message: e.toString());
    } finally {
      FullScreenLoader.stopLoading();
    }
  }
}
