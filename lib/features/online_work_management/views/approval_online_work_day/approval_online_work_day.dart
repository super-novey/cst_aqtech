import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/features/employee_management/models/employee_model.dart';
import 'package:hrm_aqtech/features/online_work_management/controllers/format_sum_day_controller.dart';
import 'package:hrm_aqtech/features/online_work_management/controllers/update_online_work_day_controller.dart';
import 'package:hrm_aqtech/features/online_work_management/models/online_work_day_model.dart';
import 'package:hrm_aqtech/features/online_work_management/views/online_work_day_detail/widgets/online_work_day_date_picker.dart';
import 'package:hrm_aqtech/features/online_work_management/views/online_work_day_detail/widgets/online_work_day_text_filed.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/enums.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';
import 'package:hrm_aqtech/utils/helpers/hepler_function.dart';

class ApprovalOnlineWorkDayScreen extends StatelessWidget {
  ApprovalOnlineWorkDayScreen({super.key, required this.selectedOnlineWorkDay});
  final OnlineWork selectedOnlineWorkDay;
  final updateOnlineWorkDayController = UpdateOnlineWorkDayController.instance;
  final employeeController = Get.put(EmployeeController());

  void fetchOnlineWorkDayDetails() {
    updateOnlineWorkDayController.dateFromController.text =
        MyFormatter.formatDate(selectedOnlineWorkDay.dateFrom.toString());
    updateOnlineWorkDayController.dateToController.text =
        MyFormatter.formatDate(selectedOnlineWorkDay.dateTo.toString());

    updateOnlineWorkDayController.reasonController.text =
        selectedOnlineWorkDay.reason;
    updateOnlineWorkDayController.noteController.text =
        selectedOnlineWorkDay.note;

    String formattedSumDay = FormatSumDayOnlineWorkController()
        .formatOnlineWorkDay(selectedOnlineWorkDay.sumDay);
    updateOnlineWorkDayController.sumDayController.text = formattedSumDay;

    String selectedEmployeeId = selectedOnlineWorkDay.memberId.toString();
    final allEmployeeIds =
        employeeController.allEmployees.map((e) => e.id.toString()).toSet();
    if (allEmployeeIds.contains(selectedEmployeeId)) {
      updateOnlineWorkDayController.selectedEmployee.value = selectedEmployeeId;
    } else {
      updateOnlineWorkDayController.selectedEmployee.value = null;
    }
    updateOnlineWorkDayController.selectedApprovalStatus.value =
        selectedOnlineWorkDay.approvalStatus;
  }

  @override
  Widget build(BuildContext context) {
    fetchOnlineWorkDayDetails();
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
            updateOnlineWorkDayController.isEditting.value = false;
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
                          value: updateOnlineWorkDayController
                              .selectedApprovalStatus.value,
                          dropdownColor: MyColors.iconColor,
                          onChanged: (ApprovalStatus? status) {
                            if (status != null) {
                              updateOnlineWorkDayController
                                  .selectedApprovalStatus.value = status;
                              updateOnlineWorkDayController
                                  .approvalOnlineWorkDay(
                                selectedOnlineWorkDay.id
                                    .toString(), // Thay thế bằng ID thực tế
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
                          value: updateOnlineWorkDayController
                              .selectedEmployee.value,
                          dropdownColor: MyColors.iconColor,
                          onChanged:
                              updateOnlineWorkDayController.isEditting.value
                                  ? (String? employeeId) {
                                      updateOnlineWorkDayController
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
              OnlineWorkDayDatePicker(
                controller: updateOnlineWorkDayController.dateFromController,
                label: "Ngày bắt đầu",
              ),
              const SizedBox(
                height: MySizes.spaceBtwItems,
              ),
              OnlineWorkDayDatePicker(
                controller: updateOnlineWorkDayController.dateToController,
                label: "Ngày kết thúc",
              ),
              const SizedBox(
                height: MySizes.spaceBtwItems,
              ),
              OnlineWorkDayTextFiled(
                textController: updateOnlineWorkDayController.sumDayController,
                label: 'Tổng số ngày',
              ),
              const SizedBox(
                height: MySizes.spaceBtwInputFields,
              ),
              OnlineWorkDayTextFiled(
                textController: updateOnlineWorkDayController.reasonController,
                label: 'Lý do làm việc online',
              ),
              const SizedBox(
                height: MySizes.spaceBtwInputFields,
              ),
              OnlineWorkDayTextFiled(
                textController: updateOnlineWorkDayController.noteController,
                label: 'Ghi chú',
              ),
              const SizedBox(
                height: MySizes.spaceBtwInputFields,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
