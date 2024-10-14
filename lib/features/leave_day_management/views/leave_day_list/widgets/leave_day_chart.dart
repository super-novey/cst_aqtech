// widgets/DayOff_days_chart.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/capture/capture_widget.dart';
import 'package:hrm_aqtech/common/widgets/chart/bar_chart.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/features/leave_day_management/controllers/leave_day_controller.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class LeaveDayChart extends StatelessWidget {
  const LeaveDayChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeaveDayController());
    final employeeController = Get.put(EmployeeController());
    final data = controller.memberLeaveDays;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text("Ngày nghỉ phép"),
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
      body: CaptureWidget(
        fullWidth: MediaQuery.of(context).size.width + data.length * 60,
        child: Container(
          color: Colors.white,
          child: CommonBarChart(
            title: 'Biểu đồ thống kê ngày nghỉ phép',
            data: data,
            getEmployeeName: (id) =>
                employeeController.getEmployeeNameById(id) ??
                'Unknown', // Handle null values
            formatTooltip: (days) => '${days.toString()} ngày',
          ),
        ),
      ),
    );
  }
}
