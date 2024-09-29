import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/authentication/controllers/authentication_controller.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthenticationController controller = Get.find();

    return Form(
      child: Column(
        children: [
          // Username
          TextFormField(
            controller: controller.usernameController,
            obscureText: false,
            decoration: const InputDecoration(
              hintText: "Tên đăng nhập",
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(
            height: MySizes.spaceBtwItems,
          ),
          Obx(
            () => TextFormField(
              controller: controller.passwordController,
              obscureText: !controller.isPasswordVisible.value,
              decoration: InputDecoration(
                hintText: "Mật khẩu",
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    controller.isPasswordVisible.value =
                        !controller.isPasswordVisible.value;
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: MySizes.spaceBtwSections,
          ),
          // Login button
          Obx(() => controller.isLoading.value
              ? const CircularProgressIndicator()
              : SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.login,
                    child: const Text("Đăng nhập"),
                  ),
                )),
        ],
      ),
    );
  }
}
