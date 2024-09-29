import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/authentication/controllers/authentication_controller.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/update_employee_controller.dart';
import 'package:hrm_aqtech/common/widgets/images/avatar_image.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/constants/image_paths.dart';

class ChangeAvatarScreen extends StatelessWidget {
  ChangeAvatarScreen({super.key});

  final UpdateEmployeeController controller =
      Get.put(UpdateEmployeeController());
  final user = AuthenticationController.instance.currentUser;
  final avatar = AuthenticationController.instance.currentAvatar;

  @override
  Widget build(BuildContext context) {
    controller.avatar.value = avatar;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: MyColors.primaryColor,
        title: const Text("Cập nhật ảnh đại diện"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MySizes.defaultSpace),
          child: Center(
            child: Column(
              children: [
                Obx(
                  () => AvatarImage(
                    imageUrl: controller.avatar.value.isNotEmpty
                        ? controller.avatar.value
                        : MyImagePaths.defaultUser,
                    radius: 60,
                  ),
                ),
                const SizedBox(height: MySizes.spaceBtwItems),
                TextButton(
                  onPressed: () async {
                    await controller.selectImage();
                  },
                  child: const Text("Chọn ảnh đại diện"),
                ),
                const SizedBox(height: MySizes.spaceBtwSections),
                Obx(
                  () => controller.avatar.value.isNotEmpty
                      ? ElevatedButton(
                          onPressed: controller.avatar.value.isNotEmpty
                              ? () async {
                                  await controller.updateAvatar(
                                      user.id, controller.avatar.value);
                                  Get.back();
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.primaryColor,
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text("Lưu thay đổi"),
                        )
                      : const SizedBox.shrink(),
                ),
                const SizedBox(height: MySizes.spaceBtwSections),
                Obx(
                  () => controller.avatar.value.isNotEmpty
                      ? ElevatedButton(
                          onPressed: () async {
                            await controller.updateAvatar(user.id, '');
                            Get.back(); // Go back after deleting
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                                255, 224, 60, 48), // Change color for delete
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text("Xóa ảnh đại diện"),
                        )
                      : const SizedBox
                          .shrink(), // Hides the button if avatar is empty
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
