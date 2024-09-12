import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/individual_work_management/views/widgets/short_fall_hour_chart.dart';
import 'package:hrm_aqtech/features/individual_work_management/views/widgets/reopen_case_chart.dart';
import 'package:hrm_aqtech/features/individual_work_management/views/widgets/work_case_hour_chart.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class IndividualWorkChart extends StatelessWidget {
  const IndividualWorkChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text("Kết quả làm việc cá nhân"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            ReopenCaseChart(),
            ShortFallHourChart(),
            WorkCaseHoursChart(),
          ],
        ),
      ),
    );
  }
}
