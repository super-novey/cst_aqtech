//Phân bố số case theo thời gian chờ
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/daily_report/controllers/case_waiting_time_controller.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class CaseWaitingTimeBarChart extends StatelessWidget {
  const CaseWaitingTimeBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CaseWaitingTimeController());
    final data = controller.caseWaitingTimeList;
    const barItemWidth = 24.0;

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
              width: 400, 
              child: Padding(
                padding: const EdgeInsets.only(top: 24, left: 8, right: 8, bottom: 8),
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceBetween,
                    gridData: const FlGridData(show: false),
                    maxY: data
                        .fold(
                            0, (max, item) => item.soCase > max ? item.soCase + 4 : max)
                        .toDouble(),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 60,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            if (index < data.length) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 40,
                                  child: Text(
                                    data[index].tuanSo,
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
                          color: MyColors.secondaryTextColor,
                          width: 1
                        ),
                        left: BorderSide(
                          color: MyColors.secondaryTextColor,
                          width: 1
                        )
                      )
                    ),
                    barGroups: data.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: item.soCase.toDouble(),
                            color: MyColors.primaryColor,
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
                            return BarTooltipItem(
                              '${item.tuanSo}\nSố ca: ${item.soCase}',
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
