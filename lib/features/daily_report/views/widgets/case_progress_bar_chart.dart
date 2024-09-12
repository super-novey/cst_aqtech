//Biểu đồ tiến độ xử lý case
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/daily_report/controllers/coder_case_report_controller.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class CaseProgressBarChart extends StatelessWidget {
  const CaseProgressBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CoderCaseReportController());
    final data = controller.coderCaseReportList;
    const barItemWidth = 15.0;

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text('Lỗi: ${controller.errorMessage}'));
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 800,
              child: Padding(
                padding: const EdgeInsets.only(top: 24, left: 8, right: 8),
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceBetween,
                    gridData: const FlGridData(show: false),
                    maxY: data
                        .fold(
                            0,
                            (max, item) =>
                                item.canXuLy > max ? item.canXuLy + 1 : max)
                        .toDouble(),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 65,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            if (index < data.length) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 8, left: 8, right: 8),
                                child: SizedBox(
                                  width: 60,
                                  child: Text(
                                    data[index].assignedTo,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.visible,
                                    maxLines: 5,
                                    softWrap: true,
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            if ((value + 1) % 0.5 == 0) {
                              return Text(
                                value.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(
                        border: const Border(
                            bottom: BorderSide(
                                color: MyColors.secondaryTextColor, width: 1),
                            left: BorderSide(
                                color: MyColors.secondaryTextColor, width: 1))),
                    barGroups: data.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: item.canXuLy.toDouble(),
                            color: Colors.blue,
                            width: barItemWidth,
                            borderRadius: BorderRadius.zero,
                          ),
                          BarChartRodData(
                            toY: item.soCaseTrongNgay.toDouble(),
                            color: Colors.orange,
                            width: barItemWidth,
                            borderRadius: BorderRadius.zero,
                          ),
                          BarChartRodData(
                            toY: item.xuLyTre.toDouble(),
                            color: Colors.red,
                            width: barItemWidth,
                            borderRadius: BorderRadius.zero,
                          ),
                        ],
                      );
                    }).toList(),
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        tooltipPadding: const EdgeInsets.all(8),
                        tooltipMargin: 8,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          final index = group.x.toInt();
                          if (index < data.length) {
                            final item = data[index];
                            String tooltipText;
                            switch (rodIndex) {
                              case 0:
                                tooltipText = 'Cần xử lý: ${item.canXuLy}';
                                break;
                              case 1:
                                tooltipText =
                                    'Số case trong ngày: ${item.soCaseTrongNgay}';
                                break;
                              case 2:
                                tooltipText = 'Xử lý trễ: ${item.xuLyTre}';
                                break;
                              default:
                                tooltipText = '';
                            }
                            return BarTooltipItem(
                              '${item.assignedTo}\n$tooltipText',
                              const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            );
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}