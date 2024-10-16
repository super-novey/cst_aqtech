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
    final TextEditingController searchController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(MySizes.defaultSpace),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Employee Dropdown with Search
              Expanded(
                child: MyRoundedContainer(
                  showBorder: true,
                  borderColor: MyColors.primaryColor,
                  child: Obx(() {
                    final employees = individualWorkController.employees;
                    final dropdownValues =
                        controller.getFilteredEmployees(employees);

                    controller.updateSelectedEmployee(dropdownValues);
                    controller.initializeSelectedEmployee(dropdownValues);

                    if (!individualWorkController.isEmployeeDataReady.value &&
                        !controller.isFilterDataReady.value) {
                      return const Padding(
                        padding: EdgeInsets.all(MySizes.sm),
                        child: CircularProgressIndicator(),
                      );
                    }

                    return Column(
                      children: [
                        // Search Field
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: searchController,
                            onChanged: (value) {
                              controller.searchQuery.value = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Search employee',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                        // Employee Dropdown
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String?>(
                            value: controller.selectedEmployee.value,
                            dropdownColor: MyColors.iconColor,
                            onChanged: (String? employeeId) {
                              controller.selectedEmployee.value = employeeId;
                            },
                            items: dropdownValues
                                .map<DropdownMenuItem<String?>>(
                                    (String? value) {
                              final employee = employees.firstWhere(
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
                        ),
                      ],
                    );
                  }),
                ),
              ),
              const SizedBox(width: MySizes.spaceBtwInputFields),
              Column(
                children: [
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
                  const SizedBox(height: 26),
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
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(MyDeviceUtils.getAppBarHeight() * 3);
}
