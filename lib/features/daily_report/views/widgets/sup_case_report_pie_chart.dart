//Biểu đồ phân bổ tiến độ xử lý
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/capture/capture_widget.dart';
import 'package:hrm_aqtech/features/daily_report/controllers/sup_case_report_controller.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:pie_chart/pie_chart.dart';

class SupCaseReportPieChart extends StatelessWidget {
  const SupCaseReportPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SupCaseReportController());

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text('Lỗi: ${controller.errorMessage}'));
        } else {
          Map<String, double> pieChartData = {
            for (var item in controller.supCaseReportList)
              item.assignedTo: item.canXuLy.toDouble()
          };
          return CaptureWidget(
            fullWidth: 400,
            child: Container(
              color: Colors.white,
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
                      colorList: const [
                        MyColors.blueColor,
                        MyColors.orangeColor,
                        MyColors.redColor,
                        MyColors.purpleColor,
                        MyColors.greenColor,
                        MyColors.brownColor,                        
                      ],
                    )),
              ),
            ),
          );
        }
      }),
    );
  }
}
