import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hrm_aqtech/navigation_menu.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

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
              hintText: "Tên đăng nhập", prefixIcon: Icon(Iconsax.user)),
        ),
        const SizedBox(
          height: MySizes.spaceBtwItems,
        ),
        TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
              hintText: "Mật khẩu",
              prefixIcon: Icon(Iconsax.lock),
              suffix: Icon(Iconsax.eye_slash)),
        ),
        const SizedBox(
          height: MySizes.spaceBtwSections,
        ),

        SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () => Get.to(() => const NavigationMenu()),
                child: const Text("Đăng nhập")))
      ],
    ));
  }
}
