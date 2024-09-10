import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/chart/bar_chart.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/features/online_work_management/controllers/online_work_day_controller.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class OnlineWorkDayChart extends StatelessWidget {
  const OnlineWorkDayChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnlineWorkDayController());
    final employeeController = Get.put(EmployeeController());
    final data = controller.memberWorkDays;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text("Làm việc Online"),
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
        title: 'Biểu đồ thống kê làm việc online',
        data: data,
        getEmployeeName: (id) =>
            employeeController.getEmployeeNameById(id) ??
            'Unknown', // Handle null values
        formatTooltip: (days) => '${days.toString()} ngày',
      ),
    );
  }
}
