import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/features/leave_day_management/controllers/format_sum_day_controller.dart';
import 'package:hrm_aqtech/features/leave_day_management/controllers/update_leave_day_controller.dart';
import 'package:hrm_aqtech/features/leave_day_management/models/leave_day_model.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/enums.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';
import 'package:hrm_aqtech/utils/helpers/helper_function.dart';
import 'package:hrm_aqtech/features/authentication/controllers/authentication_controller.dart';

class ApprovalLeaveDayScreen extends StatelessWidget {
  ApprovalLeaveDayScreen({super.key, required this.selectedLeaveDay});
  final LeaveDay selectedLeaveDay;
  final updateLeaveDayController = UpdateLeaveDayController.instance;
  final employeeController = Get.put(EmployeeController());
  final formatSumDayController = Get.put(FormatSumDayController());

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
    bool isLeader = AuthenticationController.instance.currentUser.isLeader;

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
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                "Thông tin ngày nghỉ cá nhân",
                style: Theme.of(context).textTheme.titleMedium!,
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border:
                      Border.all(color: MyColors.secondaryTextColor, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(MySizes.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Trạng thái",
                              style: Theme.of(context).textTheme.bodySmall!),
                          const SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(MySizes.borderRadiusMd),
                              border: Border.all(
                                  color: MyColors.accentColor, width: 1),
                            ),
                            child: Obx(
                              () => DropdownButtonHideUnderline(
                                child: DropdownButton<ApprovalStatus>(
                                  value: updateLeaveDayController
                                      .selectedApprovalStatus.value,
                                  dropdownColor: MyColors.iconColor,
                                  onChanged: isLeader
                                      ? (ApprovalStatus? status) {
                                          if (status != null) {
                                            updateLeaveDayController
                                                .selectedApprovalStatus
                                                .value = status;
                                            updateLeaveDayController
                                                .approvalLeaveDay(
                                              selectedLeaveDay.id.toString(),
                                              HeplerFunction
                                                  .convertEnumToString(status),
                                            );
                                          }
                                        }
                                      : null, // Disable dropdown if the user is not a leader
                                  items: ApprovalStatus.values
                                      .map((ApprovalStatus status) {
                                    return DropdownMenuItem<ApprovalStatus>(
                                      value: status,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.all(MySizes.sm),
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
                      const SizedBox(
                        height: MySizes.sm,
                      ),
                      const SizedBox(
                        height: MySizes.spaceBtwInputFields,
                      ),
                      const Text(
                        "Nhân viên: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MyColors.secondaryTextColor),
                      ),
                      const SizedBox(
                        height: MySizes.spaceBtwInputFields,
                      ),
                      Text(
                        "${employeeController.getEmployeeNameById(selectedLeaveDay.memberId)}",
                      ),
                      const SizedBox(
                        height: MySizes.spaceBtwInputFields,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MySizes.spaceBtwInputFields,
                              ),
                              Text(
                                "Từ ngày: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.secondaryTextColor),
                              ),
                              SizedBox(
                                height: MySizes.spaceBtwInputFields,
                              ),
                              Text(
                                "Đến ngày: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.secondaryTextColor),
                              ),
                              SizedBox(
                                height: MySizes.spaceBtwInputFields,
                              ),
                              Text(
                                "Số lượng ngày: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.secondaryTextColor),
                              ),
                              SizedBox(
                                height: MySizes.spaceBtwInputFields,
                              ),
                              Text(
                                "Tính vào nghỉ phép năm: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.secondaryTextColor),
                              ),
                              SizedBox(
                                height: MySizes.spaceBtwInputFields,
                              ),
                              Text(
                                "Nghỉ không lương: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.secondaryTextColor),
                              ),
                              SizedBox(
                                height: MySizes.spaceBtwInputFields,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: MySizes.spaceBtwInputFields,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(MyFormatter.formatDate(
                                  selectedLeaveDay.dateFrom.toString())),
                              const SizedBox(
                                height: MySizes.spaceBtwInputFields,
                              ),
                              Text(MyFormatter.formatDate(
                                  selectedLeaveDay.dateTo.toString())),
                              const SizedBox(
                                height: MySizes.spaceBtwInputFields,
                              ),
                              Text(formatSumDayController
                                  .formatLeaveDay(selectedLeaveDay.sumDay)),
                              const SizedBox(
                                height: MySizes.spaceBtwInputFields,
                              ),
                              Text(selectedLeaveDay.isAnnual ? "Có" : "Không"),
                              const SizedBox(
                                height: MySizes.spaceBtwInputFields,
                              ),
                              Text(selectedLeaveDay.isWithoutPay
                                  ? "Có"
                                  : "Không"),
                              const SizedBox(
                                height: MySizes.spaceBtwInputFields,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Text(
                        "Lý do nghỉ phép: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MyColors.secondaryTextColor),
                      ),
                      const SizedBox(
                        height: MySizes.spaceBtwInputFields,
                      ),
                      Text(
                        selectedLeaveDay.reason,
                        maxLines: 10,
                        style: const TextStyle(
                          height: 2,
                        ),
                      ),
                      const SizedBox(
                        height: MySizes.spaceBtwInputFields,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: MySizes.spaceBtwInputFields,
                      ),
                      const Text(
                        "Ghi chú: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MyColors.secondaryTextColor),
                      ),
                      const SizedBox(
                        height: MySizes.spaceBtwInputFields,
                      ),
                      Text(
                        selectedLeaveDay.note,
                        maxLines: 10,
                        style: const TextStyle(
                          height: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
