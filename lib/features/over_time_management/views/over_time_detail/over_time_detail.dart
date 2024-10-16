import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/features/employee_management/models/employee_model.dart';
import 'package:hrm_aqtech/features/over_time_management/controllers/format_time_controller.dart';
import 'package:hrm_aqtech/features/over_time_management/controllers/update_over_time_controller.dart';
import 'package:hrm_aqtech/features/over_time_management/models/over_time_model.dart';
import 'package:hrm_aqtech/features/over_time_management/views/over_time_detail/widgets/over_time_datepicker.dart';
import 'package:hrm_aqtech/features/over_time_management/views/over_time_detail/widgets/over_time_text_filed.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';

class OverTimeDetailScreen extends StatelessWidget {
  OverTimeDetailScreen({super.key, required this.selectedOverTime});

  final OverTime selectedOverTime;
  final updateOverTimeController = UpdateOverTimeController.instance;
  final employeeController = Get.put(EmployeeController());

  final TextEditingController searchController = TextEditingController();
  final RxList<Employee> filteredEmployees = <Employee>[].obs;

  void fetchOverTimeDetails() {
    updateOverTimeController.dateController.text =
        MyFormatter.formatDate(selectedOverTime.date.toString());
    updateOverTimeController.noteController.text = selectedOverTime.note;
    updateOverTimeController.timeController.text =
        selectedOverTime.time.toString();
    String formattedTime =
        FormatTimeController().formatTimeController(selectedOverTime.time);
    updateOverTimeController.timeController.text = formattedTime;

    String selectedEmployeeId = selectedOverTime.memberId.toString();
    final allEmployeeIds =
        employeeController.allEmployees.map((e) => e.id.toString()).toSet();
    if (allEmployeeIds.contains(selectedEmployeeId)) {
      updateOverTimeController.selectedEmployee.value = selectedEmployeeId;
    } else {
      updateOverTimeController.selectedEmployee.value = null;
    }

    // Initialize filtered employees list
    filteredEmployees.assignAll(employeeController.allEmployees);
  }

  void filterEmployees(String query) {
    if (query.isEmpty) {
      // Show all employees if query is empty
      filteredEmployees.assignAll(employeeController.allEmployees);
    } else {
      // Filter employees by name based on the search query
      filteredEmployees.assignAll(employeeController.allEmployees.where(
        (employee) =>
            employee.fullName.toLowerCase().contains(query.toLowerCase()),
      ));
    }

    // Ensure the selected employee is valid in the filtered list
    final isValidSelection = filteredEmployees.any((employee) =>
        employee.id.toString() ==
        updateOverTimeController.selectedEmployee.value);

    // If selected employee is no longer valid after filtering, set to first valid employee or null
    if (!isValidSelection && filteredEmployees.isNotEmpty) {
      updateOverTimeController.selectedEmployee.value =
          filteredEmployees.first.id.toString();
    } else if (filteredEmployees.isEmpty) {
      updateOverTimeController.selectedEmployee.value = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchOverTimeDetails();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColors.primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            updateOverTimeController.isEditting.value = false;
            updateOverTimeController.searchQuery.value = '';
            updateOverTimeController.selectedEmployee.value = '';
            Get.back();
          },
        ),
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                if (updateOverTimeController.isEditting.value) {
                  if (updateOverTimeController.isAdd.value) {
                    updateOverTimeController.save(selectedOverTime, true);
                  } else {
                    updateOverTimeController.save(selectedOverTime, false);
                  }
                } else {
                  updateOverTimeController.toggleEditting();
                }
              },
              icon: Icon(
                updateOverTimeController.isEditting.value
                    ? Icons.save
                    : Icons.edit,
                size: 24,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MySizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dropdown for Employees
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Họ tên",
                    style: Theme.of(context).textTheme.bodySmall!,
                  ),
                  const SizedBox(height: MySizes.sm),
                  // Search Bar
                  TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      labelText: 'Tên nhân viên',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) =>
                        updateOverTimeController.searchQuery.value = value,
                  ),
                  const SizedBox(height: MySizes.sm),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(MySizes.borderRadiusMd),
                      border: Border.all(color: MyColors.accentColor, width: 1),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: Obx(() {
                        filterEmployees(
                            updateOverTimeController.searchQuery.value);
                        return DropdownButton<String?>(
                          value:
                              updateOverTimeController.selectedEmployee.value,
                          dropdownColor: MyColors.iconColor,
                          onChanged: updateOverTimeController.isEditting.value
                              ? (String? employeeId) {
                                  updateOverTimeController
                                      .selectedEmployee.value = employeeId;
                                }
                              : null,
                          items: filteredEmployees.map((Employee employee) {
                            return DropdownMenuItem<String?>(
                              value: employee.id.toString(),
                              child: Padding(
                                padding: const EdgeInsets.all(MySizes.sm),
                                child: Text(
                                  employee.fullName,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: MySizes.sm),
              OverTimeDatePicker(
                controller: updateOverTimeController.dateController,
                label: "Ngày",
              ),
              const SizedBox(height: MySizes.spaceBtwItems),
              OverTimeTextFiled(
                textController: updateOverTimeController.timeController,
                label: 'Số giờ',
              ),
              const SizedBox(height: MySizes.spaceBtwInputFields),
              OverTimeTextFiled(
                textController: updateOverTimeController.noteController,
                label: 'Ghi chú',
                maxLines: 15,
              ),
              const SizedBox(height: MySizes.spaceBtwInputFields),
            ],
          ),
        ),
      ),
    );
  }
}
