import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/appbar/appbar.dart';
import 'package:hrm_aqtech/common/widgets/images/avatar_image.dart';
import 'package:hrm_aqtech/features/account/views/profile_screen/views/profile_screen.dart';
import 'package:hrm_aqtech/features/authentication/controllers/authentication_controller.dart';
import 'package:hrm_aqtech/utils/constants/image_paths.dart';

class MyHomeAppBar extends StatelessWidget {
  const MyHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Công ty TNHH Anh Quân",
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: Colors.white70),
          ),
          Text(
            AuthenticationController.instance.currentUser.fullName,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: Colors.white),
          ),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: () => {Get.to(ProfileScreen())},
          child: Obx(
            () => AvatarImage(
              imageUrl: AuthenticationController
                      .instance.currentAvatar.value.isNotEmpty
                  ? AuthenticationController.instance.currentAvatar.value
                  : MyImagePaths.defaultUser,
              radius: 18,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.logout_rounded),
          onPressed: () {
            AuthenticationController.instance.logout();
          },
        ),
      ],
    );
  }
}
