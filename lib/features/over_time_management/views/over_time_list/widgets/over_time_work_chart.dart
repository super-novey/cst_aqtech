import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/chart/bar_chart.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/features/over_time_management/controllers/over_time_controller.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class OvertimeWorkChart extends StatelessWidget {
  const OvertimeWorkChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OverTimeController());
    final employeeController = Get.put(EmployeeController());

    final data = controller.memberOvertimeHours;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text("Làm việc ngoài giờ"),
        centerTitle: true,
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
      body: CommonBarChart(
        title: 'Biểu đồ thống kê làm việc ngoài giờ',
        data: data,
        getEmployeeName: (id) =>
            employeeController.getEmployeeNameById(id) ?? 'Unknown',
        formatTooltip: (days) => '${days.toString()} ngày',
      ),
    );
  }
}
