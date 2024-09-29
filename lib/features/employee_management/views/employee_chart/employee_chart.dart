import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/features/employee_management/views/employee_list/widgets/enhanced_pie_slice_painter.dart';
import 'package:hrm_aqtech/utils/helpers/helper_function.dart';
import 'package:get/get.dart';

class EmployeeChart extends StatelessWidget {
  const EmployeeChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EmployeeController());
    final data = controller.data;

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Text(
                    'Nhân sự AQ',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Tỉ lệ và nhân viên các phòng ban',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 400,
              child: Obx(() {
                return PieChart(
                  PieChartData(
                    sectionsSpace: 2,
                    centerSpaceRadius: 0,
                    sections: data.asMap().entries.map((entry) {
                      final index = entry.key;
                      final sectionData = entry.value;
                      final isTouched = index == controller.touchedIndex.value;
                      final double fontSize = isTouched ? 18.0 : 14.0;
                      final double radius = isTouched ? 160.0 : 150.0;

                      final title = isTouched
                          ? '${sectionData.xData}:${sectionData.count}\n${sectionData.yData}%\n'
                          : '${sectionData.yData}%';

                      return PieChartSectionData(
                        color: HeplerFunction.getRoleColor(
                            HeplerFunction.getRoleFromString(
                                sectionData.xData)),
                        value: sectionData.yData.toDouble(),
                        title: title,
                        titleStyle: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        radius: radius,
                        badgePositionPercentageOffset: .98,
                      );
                    }).toList(),
                    borderData: FlBorderData(show: false),
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          controller.updateTouchedIndex(-1);
                          return;
                        }
                        controller.updateTouchedIndex(pieTouchResponse
                            .touchedSection!.touchedSectionIndex);
                      },
                    ),
                  ),
                  swapAnimationDuration: const Duration(milliseconds: 500),
                  swapAnimationCurve: Curves.easeInOut, // Animation curve
                );
              }),
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: data.map((sectionData) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Enhanced Pie Slice Shape for Legend
                    CustomPaint(
                      size: const Size(20, 20),
                      painter: EnhancedPieSlicePainter(
                        color: HeplerFunction.getRoleColor(
                          HeplerFunction.getRoleFromString(sectionData.xData),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      sectionData.xData,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
