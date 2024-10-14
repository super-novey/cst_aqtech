import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/capture/capture_widget.dart';
import 'package:hrm_aqtech/features/daily_report/controllers/case_waiting_time_controller.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/devices/device_utils.dart';
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
          return CaptureWidget(
            fullWidth: MyDeviceUtils.getScreenWidth(context),
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    width: 400,
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                  child: Obx(() => Text(
                        'Tổng số case chờ xử lý: ${controller.getTotalSoCase()}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: MyColors.secondaryTextColor,
                        ),
                      )),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
