import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/daily_report/controllers/daily_report_controller.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/enums.dart';
import 'package:hrm_aqtech/utils/helpers/hepler_function.dart';

class DailyReportScreen extends StatelessWidget {
  const DailyReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DailyReportController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text("AQTech report"),
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
      body: Obx(() {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: MyColors.secondaryTextColor, width: 0.5),
                    borderRadius: BorderRadius.circular(12)),
                child: DropdownButton<Chart>(
                  value: controller.selectedChart.value,
                  underline: const SizedBox(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16
                  ),
                  isExpanded: true,
                  items: Chart.values.map((Chart chart) {
                    return DropdownMenuItem<Chart>(
                      value: chart,
                      child: Text(HeplerFunction.displayNameOfChart(chart)),
                    );
                  }).toList(),
                  onChanged: (Chart? newValue) {
                    if (newValue != null) {
                      controller.updateChart(newValue);
                    }
                  },
                ),
              ),
            ),
            Expanded(
              child: HeplerFunction.chooseChart(controller.selectedChart.value),
            ),
          ],
        );
      }),
    );
  }
}
