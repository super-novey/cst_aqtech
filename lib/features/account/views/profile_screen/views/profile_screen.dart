import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/account/views/change_password/change_password_screen.dart';
import 'package:hrm_aqtech/features/authentication/controllers/authentication_controller.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/update_employee_controller.dart';
import 'package:hrm_aqtech/common/widgets/images/avatar_image.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/constants/image_paths.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';
import 'package:hrm_aqtech/utils/helpers/helper_function.dart';
import 'package:hrm_aqtech/utils/popups/loaders.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final UpdateEmployeeController controller =
      Get.put(UpdateEmployeeController());
  final user = AuthenticationController.instance.currentUser;
  final avatar = AuthenticationController.instance.currentAvatar.value;

  @override
  Widget build(BuildContext context) {
    controller.avatar.value = avatar;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  SizedBox(
                    height: 120,
                    child: Container(
                      color: MyColors.primaryColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Obx(
                              () => AvatarImage(
                                imageUrl: controller.avatar.value.isNotEmpty
                                    ? controller.avatar.value
                                    : MyImagePaths.defaultUser,
                                radius: 50,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () async {
                                  await controller.selectImage();
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: MyColors.primaryColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.add_a_photo_rounded,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: MySizes.spaceBtwItems),
                        Obx(
                          () => controller.isSelectedAvatar.value
                              ? TextButton(
                                  onPressed: controller.isSelectedAvatar.value
                                      ? () async {
                                          await controller.updateAvatar(
                                              user.id, controller.avatar.value);
                                          Get.back();
                                        }
                                      : null,
                                  child: const Text("Lưu thay đổi",
                                      style: TextStyle(
                                          color: MyColors.primaryColor)),
                                )
                              : const SizedBox.shrink(),
                        ),
                        Obx(
                          () => controller.avatar.isNotEmpty
                              ? TextButton(
                                  onPressed: () async {
                                    Get.defaultDialog(
                                        contentPadding:
                                            const EdgeInsets.all(MySizes.md),
                                        title: "Xóa ảnh đại diện",
                                        middleText:
                                            "Bạn có chắc muốn xóa ảnh đại diện?",
                                        confirm: ElevatedButton(
                                            onPressed: () async {
                                              await controller.updateAvatar(
                                                  user.id, '');
                                              Navigator.of(Get.overlayContext!)
                                                  .pop();
                                              Get.back();
                                              Loaders.successSnackBar(
                                                  title: "Thành công!",
                                                  message:
                                                      "Xóa ảnh đại diện thành công");
                                            },
                                            style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                backgroundColor: Colors.red,
                                                side: const BorderSide(
                                                    color: Colors.red)),
                                            child: const Text("Xóa")),
                                        cancel: OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: MySizes.md,
                                                        vertical: 0)),
                                            onPressed: () => Navigator.of(
                                                    Get.overlayContext!)
                                                .pop(),
                                            child: const Text("Quay lại")));
                                    // Get.back();
                                  },
                                  child: const Text("Xóa ảnh đại diện",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 224, 60, 48))),
                                )
                              : const SizedBox.shrink(),
                        ),
                        Text(
                          user.fullName,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          '(${user.nickName}) ',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: MySizes.spaceBtwItems),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6.0, horizontal: 16.0),
                              decoration: BoxDecoration(
                                color: HeplerFunction.getRoleColor(
                                    HeplerFunction.convertToRole(user.role)),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: user.role == 'admin'
                                  ? Text(
                                      user.role,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      HeplerFunction.convertToRole(user.role)
                                          .name
                                          .toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                            ),
                            if (user.isLeader)
                              Row(
                                children: [
                                  const SizedBox(width: 20),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6.0, horizontal: 16.0),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 239, 89, 52),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: const Text(
                                      'AQ Leader',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              )
                          ],
                        ),
                        const SizedBox(height: MySizes.spaceBtwItems),
                        _getRow(
                          context,
                          'Email',
                          Icons.email_rounded,
                          user.email,
                        ),
                        _getRow(
                          context,
                          'Số điện thoại',
                          Icons.phone_android_rounded,
                          user.phone,
                        ),
                        _getRow(
                          context,
                          'Sinh nhật',
                          Icons.calendar_month_outlined,
                          MyFormatter.formatDateTime(user.birthDate),
                        ),
                        _getRow(
                          context,
                          'Ngày bắt đầu làm việc',
                          Icons.calendar_today_outlined,
                          MyFormatter.formatDateTime(user.startDate),
                        ),
                        _getRow(
                          context,
                          'TFS account',
                          Icons.account_circle_rounded,
                          user.tfsName,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 50, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.black,
                              size: 18,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(ChangePasswordScreen());
                          },
                          child: Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.key_rounded,
                              color: Colors.black,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getRow(
      BuildContext context, String title, IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.black,
              size: 24,
            ),
          ),
          const SizedBox(width: 20),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const Spacer(),
          Text(value, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
