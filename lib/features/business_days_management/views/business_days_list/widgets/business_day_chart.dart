import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/capture/capture_widget.dart';
import 'package:hrm_aqtech/common/widgets/chart/bar_chart.dart';
import 'package:hrm_aqtech/features/business_days_management/controllers/bussiness_day_list_controller.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class BusinessDayChart extends StatelessWidget {
  BusinessDayChart({super.key});
  final GlobalKey _chartKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BussinessDayListController());
    final employeeController = Get.put(EmployeeController());
    final data = controller.memberWorkDays;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text("Ngày công tác"),
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
        child: CommonBarChart(
          title: 'Biểu đồ thống kê ngày công tác',
          data: data,
          getEmployeeName: (id) =>
              employeeController.getEmployeeNameById(id) ??
              'Unknown', // Handle null values
          formatTooltip: (days) => '${days.toString()} ngày',
        ),
      ),
    );
  }
}
