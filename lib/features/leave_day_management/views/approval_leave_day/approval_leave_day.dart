import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
import 'package:hrm_aqtech/utils/helpers/hepler_function.dart';

class ApprovalLeaveDayScreen extends StatelessWidget {
  ApprovalLeaveDayScreen({super.key, required this.selectedLeaveDay});
  final LeaveDay selectedLeaveDay;
  final updateLeaveDayController = UpdateLeaveDayController.instance;
  final employeeController = Get.put(EmployeeController());

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

    // Đảm bảo giá trị được chọn có tồn tại trong danh sách
    String selectedEmployeeId = selectedLeaveDay.memberId.toString();
    final allEmployeeIds =
        employeeController.allEmployees.map((e) => e.id.toString()).toSet();
    if (allEmployeeIds.contains(selectedEmployeeId)) {
      updateLeaveDayController.selectedEmployee.value = selectedEmployeeId;
    } else {
      updateLeaveDayController.selectedEmployee.value =
          null; // Hoặc giá trị mặc định khác
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
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MySizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Trạng thái",
                      style: Theme.of(context).textTheme.bodySmall!),
                  const SizedBox(
                    height: 2,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(MySizes.borderRadiusMd),
                      border: Border.all(color: MyColors.accentColor, width: 1),
                    ),
                    child: Obx(
                      () => DropdownButtonHideUnderline(
                        child: DropdownButton<ApprovalStatus>(
                          value: updateLeaveDayController
                              .selectedApprovalStatus.value,
                          dropdownColor: MyColors.iconColor,
                          onChanged: (ApprovalStatus? status) {
                            if (status != null) {
                              updateLeaveDayController
                                  .selectedApprovalStatus.value = status;
                              // Gọi hàm approvalLeaveDay khi chọn giá trị khác
                              updateLeaveDayController.approvalLeaveDay(
                                selectedLeaveDay.id.toString(), // Thay thế bằng ID thực tế
                                HeplerFunction.convertEnumToString(status),
                              );
                            }
                          },
                          items: ApprovalStatus.values
                              .map((ApprovalStatus status) {
                            return DropdownMenuItem<ApprovalStatus>(
                              value: status,
                              child: Padding(
                                padding: const EdgeInsets.all(MySizes.sm),
                                child: Text(
                                  HeplerFunction.displayStatusFromEnum(status),
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
              const SizedBox(
                height: MySizes.sm,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Họ tên",
                    style: Theme.of(context).textTheme.bodySmall!,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(MySizes.borderRadiusMd),
                      border: Border.all(color: MyColors.accentColor, width: 1),
                    ),
                    child: Obx(
                      () => DropdownButtonHideUnderline(
                        child: DropdownButton<String?>(
                          value:
                              updateLeaveDayController.selectedEmployee.value,
                          dropdownColor: MyColors.iconColor,
                          onChanged: updateLeaveDayController.isEditting.value
                              ? (String? employeeId) {
                                  updateLeaveDayController
                                      .selectedEmployee.value = employeeId;
                                }
                              : null,
                          items: employeeController.allEmployees
                              .map((Employee employee) {
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
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: MySizes.sm,
              ),
              const SizedBox(
                height: MySizes.sm,
              ),
              DateTimePicker(
                controller: updateLeaveDayController.dateFromController,
                label: "Ngày bắt đầu nghỉ",
              ),
              const SizedBox(
                height: MySizes.spaceBtwItems,
              ),
              DateTimePicker(
                controller: updateLeaveDayController.dateToController,
                label: "Ngày kết thúc",
              ),
              const SizedBox(
                height: MySizes.spaceBtwItems,
              ),
              EditableTextField(
                textController: updateLeaveDayController.sumDayController,
                label: 'Tổng số ngày nghỉ',
              ),
              const SizedBox(
                height: MySizes.spaceBtwInputFields,
              ),
              EditableTextField(
                textController: updateLeaveDayController.reasonController,
                label: 'Lý do nghỉ',
              ),
              const SizedBox(
                height: MySizes.spaceBtwInputFields,
              ),
              EditableTextField(
                textController: updateLeaveDayController.noteController,
                label: 'Ghi chú',
              ),
              const SizedBox(
                height: MySizes.spaceBtwInputFields,
              ),
              const LeaveDayCheckbox(
                field: 0,
                text: "Tính vào nghỉ phép cá nhân",
              ),
              const LeaveDayCheckbox(
                field: 1,
                text: "Nghỉ không lương",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
