import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/datepicker/date_picker.dart';
import 'package:hrm_aqtech/common/widgets/images/circular_image.dart';
import 'package:hrm_aqtech/common/widgets/texts/section_heading.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/update_employee_controller.dart';
import 'package:hrm_aqtech/features/employee_management/models/employee_model.dart';
import 'package:hrm_aqtech/features/employee_management/views/employee_details/widgets/profile_menu.dart';
import 'package:hrm_aqtech/features/employee_management/views/employee_list/employee_list_screen.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/enums.dart';
import 'package:hrm_aqtech/utils/constants/image_paths.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';

class EmployeeDetailScreen extends StatelessWidget {
  EmployeeDetailScreen({super.key, required this.selectedEmployee});

  // Text controller
  final controller = UpdateEmployeeController.instance;
  final Employee selectedEmployee;

  void fetchEmployeeDetails() {
    controller.emailController.text = selectedEmployee.email;
    controller.tfsController.text = selectedEmployee.tfsName;
    controller.fullNameController.text = selectedEmployee.fullName;
    controller.nickNameController.text = selectedEmployee.nickName;
    controller.phoneController.text = selectedEmployee.phone;
    controller.isActive.value = selectedEmployee.isActive;
    controller.isLeader.value = selectedEmployee.isLeader;
    controller.isLunch.value = selectedEmployee.isLunch;
    controller.wfhQuotaController.text = selectedEmployee.wfhQuota.toString();
    controller.selectedDepartment.value = selectedEmployee.role;
    controller.startDate.text =
        MyFormatter.formatDate(selectedEmployee.startDate.toString());
    controller.absenceQuotaController.text =
        selectedEmployee.absenceQuota.toString();
    controller.birthDateController.text =
        MyFormatter.formatDate(selectedEmployee.birthDate.toString());
  }

  @override
  Widget build(BuildContext context) {
    fetchEmployeeDetails();
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.offAll(() => const EmployeeListScreen());
                },
                icon: const Icon(Icons.arrow_back_ios)),
            backgroundColor: MyColors.primaryColor,
            actions: [
              Obx(
                () => IconButton(
                    onPressed: () {
                      if (controller.isEditting.value) {
                        if (controller.isAdd.value) {
                          controller.save(selectedEmployee, true);
                        } else {
                          controller.save(selectedEmployee, false);
                        }
                      } else {
                        controller.toggleEditting();
                      }
                    },
                    icon: Icon(
                        controller.isEditting.value ? Icons.save : Icons.edit)),
              ),
            ]),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(MySizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1.
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      // Avatar image
                      const MyCircularImage(
                        image: MyImagePaths.defaultUser,
                        width: 80,
                        height: 80,
                      ),
                      // change avatar image
                      TextButton(
                          onPressed: () {},
                          child: const Text("Đổi ảnh đại diện"))
                    ],
                  ),
                ),
                // 2.
                const MySectionHeading(
                  title: "Thông tin cá nhân",
                ),

                const SizedBox(
                  height: MySizes.spaceBtwItems,
                ),

                ProfileMenu(
                  textController: controller.fullNameController,
                  label: 'Họ và tên',
                ),
                const SizedBox(
                  height: MySizes.spaceBtwInputFields,
                ),
                ProfileMenu(
                  textController: controller.tfsController,
                  label: 'Tfs name',
                ),
                const SizedBox(
                  height: MySizes.spaceBtwInputFields,
                ),
                DatePicker(
                    controler: controller.birthDateController,
                    label: "Ngày sinh"),

                const SizedBox(
                  height: MySizes.spaceBtwInputFields,
                ),
                ProfileMenu(
                  textController: controller.nickNameController,
                  label: 'Nick name',
                ),
                const SizedBox(
                  height: MySizes.spaceBtwInputFields,
                ),
                ProfileMenu(
                  textController: controller.emailController,
                  label: 'Email',
                ),
                const SizedBox(
                  height: MySizes.spaceBtwItems,
                ),
                ProfileMenu(
                  textController: controller.phoneController,
                  label: 'Điện thoại',
                ),
                const SizedBox(
                  height: MySizes.spaceBtwItems,
                ),
                const MySectionHeading(
                  title: "Công ty",
                ),

                const SizedBox(
                  height: MySizes.spaceBtwItems,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text
                    Text(
                      "Phòng ban",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(fontWeightDelta: 2),
                    ),
                    const SizedBox(
                      width: MySizes.sm,
                    ),
                    // Drop down button Phong Ban
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(MySizes.borderRadiusMd),
                        border:
                            Border.all(color: MyColors.accentColor, width: 1),
                      ),
                      child: Obx(
                        () => DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: controller.selectedDepartment.value,
                            dropdownColor: MyColors.iconColor,
                            onChanged: controller.isEditting.value
                                ? (EmployeeRole? role) {
                                    if (role != null) {
                                      controller.selectedDepartment.value =
                                          role;
                                    }
                                  }
                                : null,
                            items: EmployeeRole.values.map((EmployeeRole role) {
                              return DropdownMenuItem(
                                  value: role,
                                  child: Padding(
                                    padding: const EdgeInsets.all(MySizes.sm),
                                    child: Text(
                                      role.toString().split('.').last,
                                    ),
                                  ));
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: MySizes.spaceBtwItems,
                ),
                DatePicker(
                    controler: controller.startDate, label: "Ngày vào công ty"),
                const SizedBox(
                  height: MySizes.spaceBtwItems,
                ),
                ProfileMenu(
                    textController: controller.absenceQuotaController,
                    label: "Số ngày nghỉ phép/năm"),
                const SizedBox(
                  height: MySizes.spaceBtwItems,
                ),
                ProfileMenu(
                    textController: controller.wfhQuotaController,
                    label: "Hạn mức % làm việc online/năm"),

                const SizedBox(
                  height: MySizes.spaceBtwItems,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: MyColors.accentColor,
                      ),
                      borderRadius:
                          BorderRadius.circular(MySizes.borderRadiusMd)),
                  child: const Column(
                    children: [
                      MyCheckboxListTile(
                        field: 0,
                        text: "Là leader",
                      ),
                      MyCheckboxListTile(
                        field: 1,
                        text: "Trợ cấp ăn trưa",
                      ),
                      MyCheckboxListTile(text: "Còn hoạt động", field: 2)
                    ],
                  ),
                ),
                const SizedBox(
                  height: MySizes.spaceBtwSections,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[400]),
                      onPressed: () {
                        controller.delete(selectedEmployee.id.toString());
                      },
                      child: const Text("Xóa nhân viên")),
                )
              ],
            ),
          ),
        ));
  }
}

class MyCheckboxListTile extends StatelessWidget {
  const MyCheckboxListTile({
    super.key,
    required this.text,
    required this.field,
  });

  final String text;
  final int field;

  @override
  Widget build(BuildContext context) {
    final controller = UpdateEmployeeController.instance;
    return Obx(
      () => CheckboxListTile(
        activeColor: MyColors.dartPrimaryColor,
        enabled: (controller.isEditting.value),
        title: Text(text),
        value: (field == 0)
            ? controller.isLeader.value
            : (field == 1)
                ? controller.isLunch.value
                : controller.isActive.value,
        onChanged: (value) {
          controller.toggle(field);
        },
      ),
    );
  }
}
