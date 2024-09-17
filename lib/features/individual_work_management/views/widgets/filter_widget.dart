import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/container/rounded_container.dart';
import 'package:hrm_aqtech/features/employee_management/models/employee_tfs_name.dart';
import 'package:hrm_aqtech/features/individual_work_management/controllers/filter_controller.dart';
import 'package:hrm_aqtech/features/individual_work_management/controllers/individual_work_controller.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/devices/device_utils.dart';

class Filter extends StatelessWidget implements PreferredSizeWidget {
  const Filter({super.key});

  @override
  Widget build(BuildContext context) {
    final FilterController controller = Get.find();
    final IndividualWorkController individualWorkController = Get.find();

    return Padding(
      padding: const EdgeInsets.all(MySizes.defaultSpace),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Employee Dropdown
              MyRoundedContainer(
                showBorder: true,
                borderColor: MyColors.primaryColor,
                child: Obx(() {
                  final dropdownValues = individualWorkController.employees
                      .map((employee) => employee.id.toString())
                      .toList();

                  if (controller.selectedEmployee.value != null &&
                      !dropdownValues
                          .contains(controller.selectedEmployee.value)) {
                    controller.selectedEmployee.value =
                        dropdownValues.isNotEmpty ? dropdownValues.first : null;
                  }

                  String? initialEmployeeId = individualWorkController
                          .employees.isNotEmpty
                      ? individualWorkController.employees.first.id.toString()
                      : null;

                  if (controller.selectedEmployee.value == null &&
                      initialEmployeeId != null) {
                    controller.selectedEmployee.value = initialEmployeeId;
                  }

                  if (!individualWorkController.isEmployeeDataReady.value &&
                      !controller.isFilterDataReady.value) {
                    return const Padding(
                      padding: EdgeInsets.all(MySizes.sm),
                      child: CircularProgressIndicator(),
                    );
                  }

                  return DropdownButtonHideUnderline(
                    child: DropdownButton<String?>(
                      value: controller.selectedEmployee.value,
                      dropdownColor: MyColors.iconColor,
                      onChanged: (String? employeeId) {
                        controller.selectedEmployee.value = employeeId;
                      },
                      items: dropdownValues
                          .map<DropdownMenuItem<String?>>((String? value) {
                        final employee =
                            individualWorkController.employees.firstWhere(
                          (employee) => employee.id.toString() == value,
                          orElse: () => EmployeeTFSName(
                              id: 0,
                              fullName: "Unknown",
                              tfsName: '',
                              nickName: ''),
                        );
                        return DropdownMenuItem<String?>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.all(MySizes.sm),
                            child: Text(
                              employee.fullName,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }),
              ),
              // Year Picker
              GestureDetector(
                onTap: () {
                  controller.selectYear(context);
                },
                child: MyRoundedContainer(
                  padding: const EdgeInsets.all(12),
                  borderColor: MyColors.dartPrimaryColor,
                  showBorder: true,
                  child: Obx(
                    () => Text(
                      "${controller.year.value}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: MySizes.spaceBtwInputFields),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyRoundedContainer(
                showBorder: true,
                borderColor: MyColors.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      const Text(
                        'Clear',
                        style: TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        onPressed: () {
                          // Handle filter action
                        },
                        icon: const Icon(Icons.filter_alt_off),
                      ),
                    ],
                  ),
                ),
              ),
              MyRoundedContainer(
                backgroundColor: MyColors.dartPrimaryColor,
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    individualWorkController.fetchIndividualWork(
                        controller.selectedEmployee.string,
                        controller.year.string);
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(MyDeviceUtils.getAppBarHeight() * 3);
}
