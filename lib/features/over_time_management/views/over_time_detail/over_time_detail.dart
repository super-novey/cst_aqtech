import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/features/employee_management/models/employee_model.dart';
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

  void fetchOverTimeDetails() {
    updateOverTimeController.dateController.text =
        MyFormatter.formatDate(selectedOverTime.date.toString());
    updateOverTimeController.noteController.text = selectedOverTime.note;
    updateOverTimeController.timeController.text =
        selectedOverTime.time.toString();

    String selectedEmployeeId = selectedOverTime.memberId.toString();
    final allEmployeeIds =
        employeeController.allEmployees.map((e) => e.id.toString()).toSet();
    if (allEmployeeIds.contains(selectedEmployeeId)) {
      updateOverTimeController.selectedEmployee.value = selectedEmployeeId;
    } else {
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
          )
        ],
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
                              updateOverTimeController.selectedEmployee.value,
                          dropdownColor: MyColors.iconColor,
                          onChanged: updateOverTimeController.isEditting.value
                              ? (String? employeeId) {
                                  updateOverTimeController
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
              OverTimeDatePicker(
                controller: updateOverTimeController.dateController,
                label: "Ngày",
              ),
              const SizedBox(
                height: MySizes.spaceBtwItems,
              ),
              OverTimeTextFiled(
                textController: updateOverTimeController.timeController,
                label: 'Số giờ',
              ),
              const SizedBox(
                height: MySizes.spaceBtwInputFields,
              ),
              OverTimeTextFiled(
                textController: updateOverTimeController.noteController,
                label: 'Ghi chú',
                maxLines: 15,
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
