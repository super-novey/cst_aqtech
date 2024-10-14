//Biểu đồ tổng hợp AQ Report
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/capture/capture_widget.dart';
import 'package:hrm_aqtech/features/daily_report/controllers/aq_case_report_controller.dart';
import 'package:hrm_aqtech/features/daily_report/views/widgets/item_chart.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/devices/device_utils.dart';

class AqCaseReportBarChart extends StatelessWidget {
  const AqCaseReportBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AqCaseReportController());
    final data = controller.aqCaseReportList;
    const barItemWidth = 20.0;

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text('Lỗi: ${controller.errorMessage}'));
        } else {
          return CaptureWidget(
            fullWidth: MyDeviceUtils.getScreenWidth(context),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: 400,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 24, left: 8, right: 8),
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceBetween,
                            gridData: const FlGridData(show: false),
                            maxY: data
                                .fold(
                                    0,
                                    (max, item) => item.tongCase > max
                                        ? item.tongCase + 5
                                        : max)
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
                                          width: 35,
                                          child: Text(
                                            data[index].name,
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
                                    if (value % 10 == 0) {
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
                                sideTitles: SideTitles(
                                  showTitles: false,
                                ),
                              ),
                            ),
                            borderData: FlBorderData(
                                border: const Border(
                                    bottom: BorderSide(
                                        color: MyColors.secondaryTextColor,
                                        width: 1),
                                    left: BorderSide(
                                        color: MyColors.secondaryTextColor,
                                        width: 1))),
                            barGroups: data.asMap().entries.map((entry) {
                              final index = entry.key;
                              final item = entry.value;
                              final List<BarChartRodData> rods = [];

                              if (controller.showTongCase.value) {
                                rods.add(BarChartRodData(
                                  toY: item.tongCase.toDouble(),
                                  color: Colors.blue,
                                  width: barItemWidth,
                                  borderRadius: BorderRadius.zero,
                                ));
                              }

                              if (controller.showConHan.value) {
                                rods.add(BarChartRodData(
                                  toY: item.conHan.toDouble(),
                                  color: Colors.orange,
                                  width: barItemWidth,
                                  borderRadius: BorderRadius.zero,
                                ));
                              }

                              if (controller.showTreHan.value) {
                                rods.add(BarChartRodData(
                                  toY: item.treHan.toDouble(),
                                  color: Colors.red,
                                  width: barItemWidth,
                                  borderRadius: BorderRadius.zero,
                                ));
                              }

                              if (controller.showNhanSu.value) {
                                rods.add(BarChartRodData(
                                  toY: item.nhanSu.toDouble(),
                                  color: Colors.purple,
                                  width: barItemWidth,
                                  borderRadius: BorderRadius.zero,
                                ));
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
                                  if (index < data.length) {
                                    final index = group.x.toInt();
                                    final item = data[index];
                                    String label;
                                    double value;
                                    switch (rod.color) {
                                      case Colors.blue:
                                        label = 'Tổng case';
                                        value = item.tongCase.toDouble();
                                        break;
                                      case Colors.orange:
                                        label = 'Còn hạn';
                                        value = item.conHan.toDouble();
                                        break;
                                      case Colors.red:
                                        label = 'Trễ hạn';
                                        value = item.treHan.toDouble();

                                        break;
                                      case Colors.purple:
                                        label = 'Nhân sự';
                                        value = item.nhanSu.toDouble();
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
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 4, right: 4, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ItemChart(
                          color: Colors.blue,
                          label: "Tổng case",
                          onClick: () {
                            controller.showTongCase.toggle();
                          },
                        ),
                        ItemChart(
                            color: Colors.orange,
                            label: "Còn hạn",
                            onClick: () {
                              controller.showConHan.toggle();
                            }),
                        ItemChart(
                            color: Colors.red,
                            label: "Trễ hạn",
                            onClick: () {
                              controller.showTreHan.toggle();
                            }),
                        ItemChart(
                            color: Colors.purple,
                            label: "Nhân sự",
                            onClick: () {
                              controller.showNhanSu.toggle();
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
