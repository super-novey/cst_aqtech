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
          // Password
          TextFormField(
            controller: controller.passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: "Mật khẩu",
              prefixIcon: Icon(Icons.lock),
              suffix: Icon(Icons.remove_red_eye),
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
