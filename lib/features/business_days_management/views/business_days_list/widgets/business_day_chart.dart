import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/chart/bar_chart.dart';
import 'package:hrm_aqtech/features/business_days_management/controllers/bussiness_day_list_controller.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';

class BusinessDayChart extends StatelessWidget {
  const BusinessDayChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BussinessDayListController());
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
