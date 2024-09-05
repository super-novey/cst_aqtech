import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/chart/bar_chart.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/features/online_work_management/controllers/online_work_day_controller.dart';

class OnlineWorkDayChart extends StatelessWidget {
  const OnlineWorkDayChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnlineWorkDayController());
    final employeeController = Get.put(EmployeeController());
    final data = controller.memberWorkDays;

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
