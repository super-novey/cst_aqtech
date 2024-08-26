import 'package:flutter/material.dart';
import 'package:hrm_aqtech/features/authentication/views/login/widgets/login_form.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/image_paths.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/devices/device_utils.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(MySizes.defaultSpace),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Header
                  Image(
                      width: MyDeviceUtils.getScreenWidth(context) * 0.6,
                      image: const AssetImage(MyImagePaths.appLogo)),
                  const SizedBox(
                    height: MySizes.spaceBtwSections * 2,
                  ),

                  Text(
                    "Đăng nhập",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .apply(color: MyColors.secondaryTextColor),
                  ),
                  const SizedBox(
                    height: MySizes.spaceBtwSections,
                  ),
                  // Login form
                  const LoginForm()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
