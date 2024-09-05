// widgets/DayOff_days_chart.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/chart/bar_chart.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/features/leave_day_management/controllers/leave_day_controller.dart';

class LeaveDayChart extends StatelessWidget {
  const LeaveDayChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeaveDayController());
    final employeeController = Get.put(EmployeeController());
    final data = controller.memberLeaveDays;

    return CommonBarChart(
      title: 'Biểu đồ thống kê ngày công tác',
      data: data,
      getEmployeeName: (id) =>
          employeeController.getEmployeeNameById(id) ??
          'Unknown', // Handle null values
      formatTooltip: (days) => '${days.toString()} ngày',
    );
  }
}
