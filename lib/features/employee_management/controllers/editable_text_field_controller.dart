import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/data/employees/employee_repository.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/checkbox_controller.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/network_manager.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/role_controller.dart';
import 'package:hrm_aqtech/features/employee_management/models/employee_model.dart';
import 'package:hrm_aqtech/utils/constants/image_paths.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/popups/full_screen_loader.dart';
import 'package:hrm_aqtech/utils/popups/loaders.dart';
import 'package:intl/intl.dart';

class EditableTextFieldController extends GetxController {
  static EditableTextFieldController get instance => Get.find();
  RoleController roleController = Get.put(RoleController());
  var isEditting = false.obs;
  var isAdd = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController tfsController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController absenceQuotaController = TextEditingController();
  TextEditingController wfhQuotaController = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  CheckboxController checkboxController = Get.put(CheckboxController());

  @override
  void onClose() {
    emailController.dispose();
    fullNameController.dispose();
    tfsController.dispose();
    nickNameController.dispose();
    phoneController.dispose();
    absenceQuotaController.dispose();
    wfhQuotaController.dispose();
    startDate.dispose();
    birthDateController.dispose();
    checkboxController.dispose();

    super.onClose();
  }

  void toggleEditting() {
    isEditting.value = !isEditting.value;
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
        this.isAdd.value = false; // cap nhat truong idAdd
        Loaders.successSnackBar(
            title: "Thành công!", message: "Đã thêm nhân viên");
      } else {
        // xu ly luu qua api
        await EmployeeRepository.instance.updateEmployeeInfor(newEmployee);
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
              Loaders.successSnackBar(
                  title: "Thành công!", message: "Xóa nhân viên");
              Navigator.of(Get.overlayContext!).pop();
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
    newEmployee.isActive = checkboxController.isActive.value;
    newEmployee.isLunch = checkboxController.isLunch.value;
    newEmployee.isLeader = checkboxController.isLeader.value;
    newEmployee.phone = phoneController.text.toString().trim();
    newEmployee.wfhQuota = int.parse(wfhQuotaController.text);
    newEmployee.absenceQuota = int.parse(absenceQuotaController.text);
    newEmployee.birthDate =
        DateFormat("dd/MM/yyyy").parse(birthDateController.text);
    newEmployee.startDate = DateFormat("dd/MM/yyyy").parse(startDate.text);
    newEmployee.role = roleController.selectedDepartment.value;
  }
}
