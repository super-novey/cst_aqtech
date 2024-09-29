import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/appbar/appbar.dart';
import 'package:hrm_aqtech/features/account/views/change_avatar_screen/change_avatar_screen.dart';
import 'package:hrm_aqtech/features/authentication/controllers/authentication_controller.dart';
import 'package:hrm_aqtech/features/account/views/change_password/change_password_screen.dart';

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
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'change_password') {
              Get.to(() => ChangePasswordScreen());
            } else if (value == 'change_avatar') {
              Get.to(() => ChangeAvatarScreen());
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'change_password',
              child: Text('Đổi mật khẩu'),
            ),
            const PopupMenuItem<String>(
              value: 'change_avatar',
              child: Text('Đổi ảnh đại diện'),
            ),
          ],
          child: TextButton(
            onPressed: null, // The button will show the popup
            child: Text(
              "Tài khoản",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(color: Colors.white70),
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
