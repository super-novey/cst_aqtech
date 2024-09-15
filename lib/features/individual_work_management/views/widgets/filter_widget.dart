import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/container/rounded_container.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/features/employee_management/models/employee_model.dart';
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
    final EmployeeController employeeController = Get.find();

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
                  final dropdownValues = employeeController.allEmployees
                      .map((employee) => employee.id.toString())
                      .toList();

                  if (controller.selectedEmployee.value != null &&
                      !dropdownValues
                          .contains(controller.selectedEmployee.value)) {
                    controller.selectedEmployee.value =
                        dropdownValues.isNotEmpty ? dropdownValues.first : null;
                  }

                  String? initialEmployeeId =
                      employeeController.allEmployees.isNotEmpty
                          ? employeeController.allEmployees.first.id.toString()
                          : null;

                  if (controller.selectedEmployee.value == null &&
                      initialEmployeeId != null) {
                    controller.selectedEmployee.value = initialEmployeeId;
                  }

                  if (!employeeController.isEmployeeDataReady.value &&
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
                            employeeController.allEmployees.firstWhere(
                          (employee) => employee.id.toString() == value,
                          orElse: () => Employee(id: 0, fullName: "Unknown"),
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
                    IndividualWorkController.instance.fetchIndividualWork(
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
