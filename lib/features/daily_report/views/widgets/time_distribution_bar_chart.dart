//Biểu đồ phân bổ thời gian
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/daily_report/controllers/coder_case_report_controller.dart';
import 'package:hrm_aqtech/features/daily_report/views/widgets/item_chart.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class TimeDistributionBarChart extends StatelessWidget {
  const TimeDistributionBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CoderCaseReportController());
    final data = controller.coderCaseReportList;
    const barItemWidth = 20.0;
  
    return Scaffold(
      body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text('Lỗi: ${controller.errorMessage}'));
          } else {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
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
                                        item.tgCanXyLy > max ? item.tgCanXyLy + 4 : max)
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
                                        padding: const EdgeInsets.only(
                                            top: 8, left: 8, right: 8),
                                        child: SizedBox(
                                          width: 65,
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
                              final List<BarChartRodData> rods = [];
                              if(controller.showTgCanXyLy.value) {
                                rods.add(BarChartRodData(
                                    toY: item.tgCanXyLy.toDouble(),
                                    color: Colors.blue,
                                    width: barItemWidth,
                                    borderRadius: BorderRadius.zero,
                                  ),);
                              }
                              if(controller.showLuongGioTrongNgay.value) {
                                rods.add(BarChartRodData(
                                    toY: item.luongGioTrongNgay.toDouble(),
                                    color: Colors.orange,
                                    width: barItemWidth,
                                    borderRadius: BorderRadius.zero,
                                  ),);
                              }
                              return BarChartGroupData(
                                x: index,
                                barRods: rods,
                              );
                            }).toList(),
                            barTouchData: BarTouchData(
                              enabled: true,
                              touchTooltipData: BarTouchTooltipData(
                                tooltipPadding: const EdgeInsets.all(8),
                                tooltipMargin: 8,
                                getTooltipItem:
                                  (group, groupIndex, rod, rodIndex) {
                                final index = group.x.toInt();
                                final item = data[index];
                                String label;
                                double value;

                                switch (rod.color) {
                                  case Colors.blue:
                                    label = 'Số giờ cần xử lý tất cả case';
                                    value = item.tgCanXyLy.toDouble();
                                    break;
                                  case Colors.orange:
                                    label = 'Số giờ đã xử lý';
                                    value = item.luongGioTrongNgay.toDouble();
                                    break;
                                  default:
                                    label = '';
                                    value = 0.0;
                                    break;
                                }

                                return BarTooltipItem(
                                  '$label: ${value.toStringAsFixed(0)}',
                                  const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                height: 30,
                child: Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ItemChart(color: Colors.blue, label: "Số giờ cần xử lý tất cả case",
                      onClick: () {
                        controller.showTgCanXyLy.toggle();
                      },),
                      ItemChart(
                          color: Colors.orange, label: "Số giờ đã xử lý",
                          onClick: () {
                            controller.showLuongGioTrongNgay.toggle();
                          }),
                    ],
                  ),
                ),
              )
              ],
            );
          }
        }),
    );
  }
}
