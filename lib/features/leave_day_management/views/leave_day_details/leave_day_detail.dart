import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/authentication/controllers/authentication_controller.dart';
import 'package:hrm_aqtech/features/leave_day_management/views/leave_day_details/widgets/leave_day_date_picker.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/features/employee_management/models/employee_model.dart';
import 'package:hrm_aqtech/features/leave_day_management/controllers/format_sum_day_controller.dart';
import 'package:hrm_aqtech/features/leave_day_management/controllers/update_leave_day_controller.dart';
import 'package:hrm_aqtech/features/leave_day_management/models/leave_day_model.dart';
import 'package:hrm_aqtech/features/leave_day_management/views/leave_day_details/widgets/editable_text_field.dart';
import 'package:hrm_aqtech/features/leave_day_management/views/leave_day_details/widgets/leave_day_checkbox.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/enums.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';
import 'package:hrm_aqtech/utils/helpers/helper_function.dart';

class LeaveDayDetailScreen extends StatelessWidget {
  LeaveDayDetailScreen({super.key, required this.selectedLeaveDay});
  final LeaveDay selectedLeaveDay;
  final updateLeaveDayController = UpdateLeaveDayController.instance;
  final employeeController = Get.put(EmployeeController());

  final TextEditingController searchController = TextEditingController();

  void fetchLeaveDayDetails() {
    updateLeaveDayController.dateFromController.text =
        MyFormatter.formatDate(selectedLeaveDay.dateFrom.toString());
    updateLeaveDayController.dateToController.text =
        MyFormatter.formatDate(selectedLeaveDay.dateTo.toString());

    updateLeaveDayController.reasonController.text = selectedLeaveDay.reason;
    updateLeaveDayController.noteController.text = selectedLeaveDay.note;

    String formattedSumDay =
        FormatSumDayController().formatLeaveDay(selectedLeaveDay.sumDay);
    updateLeaveDayController.sumDayController.text = formattedSumDay;
    updateLeaveDayController.isAnnual.value = selectedLeaveDay.isAnnual;
    updateLeaveDayController.isWithoutPay.value = selectedLeaveDay.isWithoutPay;

    String selectedEmployeeId = selectedLeaveDay.memberId.toString();
    final allEmployeeIds =
        employeeController.allEmployees.map((e) => e.id.toString()).toSet();
    if (allEmployeeIds.contains(selectedEmployeeId)) {
      updateLeaveDayController.selectedEmployee.value = selectedEmployeeId;
    } else {
      updateLeaveDayController.selectedEmployee.value = null;
    }
    updateLeaveDayController.selectedApprovalStatus.value =
        selectedLeaveDay.approvalStatus;
  }

  @override
  Widget build(BuildContext context) {
    fetchLeaveDayDetails();

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
            updateLeaveDayController.isEditting.value = false;
            updateLeaveDayController.searchQuery.value = '';
            updateLeaveDayController.selectedEmployee.value = '';
            Get.back();
          },
        ),
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                if (updateLeaveDayController.isEditting.value) {
                  if (updateLeaveDayController.isAdd.value) {
                    updateLeaveDayController.save(selectedLeaveDay, true);
                  } else {
                    updateLeaveDayController.save(selectedLeaveDay, false);
                  }
                } else {
                  updateLeaveDayController.toggleEditting();
                }
              },
              icon: Icon(
                updateLeaveDayController.isEditting.value
                    ? Icons.save
                    : Icons.edit,
                size: 24,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MySizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (AuthenticationController.instance.currentUser.isLeader)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Trạng thái",
                        style: Theme.of(context).textTheme.bodySmall!),
                    const SizedBox(height: 2),
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
                          child: DropdownButton<ApprovalStatus>(
                            value: updateLeaveDayController
                                .selectedApprovalStatus.value,
                            dropdownColor: MyColors.iconColor,
                            onChanged: updateLeaveDayController.isEditting.value
                                ? (ApprovalStatus? status) {
                                    if (status != null) {
                                      updateLeaveDayController
                                          .selectedApprovalStatus
                                          .value = status;
                                    }
                                  }
                                : null,
                            items: ApprovalStatus.values
                                .map((ApprovalStatus status) {
                              return DropdownMenuItem<ApprovalStatus>(
                                value: status,
                                child: Padding(
                                  padding: const EdgeInsets.all(MySizes.sm),
                                  child: Text(
                                    HeplerFunction.displayStatusFromEnum(
                                        status),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: MySizes.sm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Họ tên", style: Theme.of(context).textTheme.bodySmall!),
                  const SizedBox(height: 2),
                  TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Nhập tên nhân viên',
                    ),
                    onChanged: (value) {
                      updateLeaveDayController.searchQuery.value =
                          value.toLowerCase();
                    },
                  ),
                  const SizedBox(height: MySizes.md),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(MySizes.borderRadiusMd),
                      border: Border.all(color: MyColors.accentColor, width: 1),
                    ),
                    child: Obx(
                      () {
                        // Filter the employees based on search query
                        final filteredEmployees =
                            employeeController.allEmployees.where((employee) {
                          final matchesName = employee.fullName
                              .toLowerCase()
                              .contains(updateLeaveDayController
                                  .searchQuery.value
                                  .trim());
                          return matchesName &&
                              (AuthenticationController
                                      .instance.currentUser.isLeader ||
                                  employee.id ==
                                      AuthenticationController
                                          .instance.currentUser.id);
                        }).toList();

                        // Check if the current selectedEmployee is in the filtered list
                        String? selectedEmployeeId =
                            updateLeaveDayController.selectedEmployee.value;
                        final isEmployeeInList = filteredEmployees.any(
                            (employee) =>
                                employee.id.toString() == selectedEmployeeId);

                        // If the selected employee is not in the filtered list, keep the value unchanged
                        if (!isEmployeeInList && filteredEmployees.isNotEmpty) {
                          selectedEmployeeId =
                              filteredEmployees.first.id.toString();
                          updateLeaveDayController.selectedEmployee.value =
                              selectedEmployeeId;
                        }

                        return DropdownButtonHideUnderline(
                          child: DropdownButton<String?>(
                            value: selectedEmployeeId,
                            dropdownColor: MyColors.iconColor,
                            onChanged: updateLeaveDayController.isEditting.value
                                ? (String? employeeId) {
                                    if (employeeId != null) {
                                      updateLeaveDayController
                                          .selectedEmployee.value = employeeId;
                                    }
                                  }
                                : null,
                            items: filteredEmployees.map((Employee employee) {
                              return DropdownMenuItem<String?>(
                                value: employee.id.toString(),
                                child: Text(employee.fullName),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: MySizes.spaceBtwItems),
              DateTimePicker(
                controller: updateLeaveDayController.dateFromController,
                label: "Ngày bắt đầu nghỉ",
              ),
              const SizedBox(height: MySizes.spaceBtwItems),
              DateTimePicker(
                controller: updateLeaveDayController.dateToController,
                label: "Ngày kết thúc",
              ),
              const SizedBox(height: MySizes.spaceBtwItems),
              EditableTextField(
                textController: updateLeaveDayController.sumDayController,
                label: 'Tổng số ngày nghỉ',
                isNumberInput: true,
              ),
              const SizedBox(height: MySizes.spaceBtwInputFields),
              EditableTextField(
                textController: updateLeaveDayController.reasonController,
                label: 'Lý do nghỉ',
              ),
              const SizedBox(height: MySizes.spaceBtwInputFields),
              EditableTextField(
                textController: updateLeaveDayController.noteController,
                label: 'Ghi chú',
              ),
              const SizedBox(height: MySizes.spaceBtwInputFields),
              const LeaveDayCheckbox(
                  field: 0, text: "Tính vào nghỉ phép cá nhân"),
              const LeaveDayCheckbox(field: 1, text: "Nghỉ không lương"),
            ],
          ),
        ),
      ),
    );
  }
}
