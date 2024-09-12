import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hrm_aqtech/features/home/home_screen.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';


class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        // Username
        TextFormField(
          obscureText: false,
          decoration: const InputDecoration(
              hintText: "Tên đăng nhập", prefixIcon: Icon(Icons.person)),
        ),
        const SizedBox(
          height: MySizes.spaceBtwItems,
        ),
        TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
              hintText: "Mật khẩu",
              prefixIcon: Icon(Icons.lock),
              suffix: Icon(Icons.remove_red_eye)),
        ),
        const SizedBox(
          height: MySizes.spaceBtwSections,
        ),

        SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () => Get.to(() => const HomeScreen()),
                child: const Text("Đăng nhập")))
      ],
    ));
  }
}
