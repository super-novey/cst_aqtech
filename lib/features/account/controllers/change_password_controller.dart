import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hrm_aqtech/data/account/account_repository.dart';
import 'package:hrm_aqtech/features/authentication/controllers/authentication_controller.dart';

class ChangePasswordController extends GetxController {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool isCurrentPasswordVisible = false.obs; // Added visibility toggle
  final RxBool isNewPasswordVisible = false.obs; 
  final RxBool isConfirmPasswordVisible = false.obs; 
  final repository = Get.put(AccountRepository());

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  Future<void> changePassword() async {
    if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'New password and confirm password do not match',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;

    final id = AuthenticationController.instance.currentUser.id;

    bool success = await repository.changePassword(
        id,
        currentPasswordController.text,
        newPasswordController.text,
        confirmPasswordController.text);

    if (success) {
      // Perform additional actions if needed (e.g., logging out)
    }

    isLoading.value = false;
  }
}
