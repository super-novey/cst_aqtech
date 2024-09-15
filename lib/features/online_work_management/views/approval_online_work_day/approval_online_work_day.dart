import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/features/online_work_management/controllers/format_sum_day_controller.dart';
import 'package:hrm_aqtech/features/online_work_management/controllers/update_online_work_day_controller.dart';
import 'package:hrm_aqtech/features/online_work_management/models/online_work_day_model.dart';
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
  final formatSumDayOnlineWorkController =
      Get.put(FormatSumDayOnlineWorkController());

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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text("Thông tin ngày làm việc online cá nhân",
                style: Theme.of(context).textTheme.titleMedium!),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  border:
                      Border.all(color: MyColors.secondaryTextColor, width: 1),
                  borderRadius: BorderRadius.circular(12)),
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
                            border: Border.all(
                                color: MyColors.accentColor, width: 1),
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
                                      selectedOnlineWorkDay.id.toString(),
                                      HeplerFunction.convertEnumToString(
                                          status),
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
                      "${employeeController.getEmployeeNameById(selectedOnlineWorkDay.memberId)}",
                    ),
                    const SizedBox(
                      height: MySizes.spaceBtwInputFields,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          ],
                        ),
                        const SizedBox(
                          width: MySizes.spaceBtwInputFields,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                MyFormatter.formatDate(selectedOnlineWorkDay.dateFrom.toString())),
                            const SizedBox(
                              height: MySizes.spaceBtwInputFields,
                            ),
                            Text(
                                MyFormatter.formatDate(selectedOnlineWorkDay.dateTo.toString())),
                            const SizedBox(
                              height: MySizes.spaceBtwInputFields,
                            ),
                            Text(
                                formatSumDayOnlineWorkController.formatOnlineWorkDay(selectedOnlineWorkDay.sumDay)),
                            const SizedBox(
                              height: MySizes.spaceBtwInputFields,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Text(
                      "Lý do làm việc online: ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyColors.secondaryTextColor),
                    ),
                    const SizedBox(
                      height: MySizes.spaceBtwInputFields,
                    ),
                    SizedBox(
                      width: 280,
                      child: Text(selectedOnlineWorkDay.reason)),
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
                    SizedBox(
                      width: 280,
                      child: Text(
                        selectedOnlineWorkDay.note,
                        maxLines: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
