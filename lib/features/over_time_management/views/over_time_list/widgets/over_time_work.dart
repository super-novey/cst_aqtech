import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/chart/bar_chart.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/features/over_time_management/controllers/over_time_controller.dart';

class OvertimeWorkChart extends StatelessWidget {
  const OvertimeWorkChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OverTimeController());
    final employeeController = Get.put(EmployeeController());

    final data = controller.memberOvertimeHours;
    return CommonBarChart(
      title: 'Biểu đồ thống kê ngày công tác',
      data: data,
      getEmployeeName: (id) =>
          employeeController.getEmployeeNameById(id) ??
          'Unknown', 
      formatTooltip: (days) => '${days.toString()} ngày',
    );
  }
}
