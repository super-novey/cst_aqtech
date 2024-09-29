import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/account/controllers/change_password_controller.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text("Đổi mật khẩu"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Current Password Field
              Obx(
                () => TextFormField(
                  controller: controller.currentPasswordController,
                  obscureText: !controller.isCurrentPasswordVisible.value,
                  decoration: InputDecoration(
                    hintText: "Current Password",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(controller.isCurrentPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        controller.isCurrentPasswordVisible.toggle();
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // New Password Field
              Obx(
                () => TextFormField(
                  controller: controller.newPasswordController,
                  obscureText: !controller.isNewPasswordVisible.value,
                  decoration: InputDecoration(
                    hintText: "New Password",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(controller.isNewPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        controller.isNewPasswordVisible.toggle();
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Confirm Password Field
              Obx(
                () => TextFormField(
                  controller: controller.confirmPasswordController,
                  obscureText: !controller.isConfirmPasswordVisible.value,
                  decoration: InputDecoration(
                    hintText: "Confirm New Password",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(controller.isConfirmPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        controller.isConfirmPasswordVisible.toggle();
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Submit Button
              Obx(() => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: controller.changePassword,
                        child: const Text("Change Password"),
                      ),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
