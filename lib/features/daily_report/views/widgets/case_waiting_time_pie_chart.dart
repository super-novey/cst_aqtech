//Phân bố số case theo thời gian chờ
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/daily_report/controllers/case_waiting_time_controller.dart';
import 'package:pie_chart/pie_chart.dart';

class CaseWaitingTimePieChart extends StatelessWidget {
  const CaseWaitingTimePieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CaseWaitingTimeController());

    // const barItemWidth = 24.0;

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text('Lỗi: ${controller.errorMessage}'));
        } else {
          Map<String, double> pieChartData = {
            for (var item in controller.caseWaitingTimeList)
              item.tuanSo: item.soCase.toDouble()
          };
          return SizedBox(
            width: 400, // Sử dụng chiều rộng đã tính toán
            child: Padding(
                padding: const EdgeInsets.only(
                    top: 24, left: 8, right: 8, bottom: 8),
                child: PieChart(
                  dataMap: pieChartData,
                  legendOptions: const LegendOptions(
                      legendPosition: LegendPosition.bottom),
                  chartValuesOptions: const ChartValuesOptions(
                      showChartValuesInPercentage: true),
                )),
          );
        }
      }),
    );
  }
}
