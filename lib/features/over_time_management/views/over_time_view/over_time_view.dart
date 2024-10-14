import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/features/over_time_management/controllers/format_time_controller.dart';
import 'package:hrm_aqtech/features/over_time_management/controllers/update_over_time_controller.dart';
import 'package:hrm_aqtech/features/over_time_management/models/over_time_model.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';

class OverTimeViewScreen extends StatelessWidget {
  OverTimeViewScreen({super.key, required this.selectedOverTime});
  final OverTime selectedOverTime;
  final updateOverTimeController = UpdateOverTimeController.instance;
  final employeeController = Get.put(EmployeeController());

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
                "Thông tin ngày làm việc ngoài giờ",
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
                                "Nhân viên: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.secondaryTextColor),
                              ),
                              SizedBox(
                                height: MySizes.spaceBtwInputFields,
                              ),
                              Text(
                                "Ngày: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.secondaryTextColor),
                              ),
                              SizedBox(
                                height: MySizes.spaceBtwInputFields,
                              ),
                              Text(
                                "Giờ: ",
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
                                "${employeeController.getEmployeeNameById(selectedOverTime.memberId)}",
                              ),
                              const SizedBox(
                                height: MySizes.spaceBtwInputFields,
                              ),
                              Text(MyFormatter.formatDate(
                                  selectedOverTime.date.toString())),
                              const SizedBox(
                                height: MySizes.spaceBtwInputFields,
                              ),
                              Text(FormatTimeController()
                                  .formatTimeController(selectedOverTime.time)),
                              const SizedBox(
                                height: MySizes.spaceBtwInputFields,
                              ),
                            ],
                          ),
                        ],
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
                        selectedOverTime.note,
                        maxLines: 15,
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
