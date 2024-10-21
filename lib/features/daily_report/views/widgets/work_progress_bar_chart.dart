//Biểu đồ tiến độ công việc
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/capture/capture_widget.dart';
import 'package:hrm_aqtech/features/daily_report/controllers/sup_case_report_controller.dart';
import 'package:hrm_aqtech/features/daily_report/views/widgets/item_chart.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class WorkProgressBarChart extends StatelessWidget {
  const WorkProgressBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SupCaseReportController());
    final data = controller.supCaseReportList;
    const barItemWidth = 15.0;
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text('Lỗi: ${controller.errorMessage}'));
        } else {
          return CaptureWidget(
            fullWidth: data.length * 5 * barItemWidth * 1.5,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: data.length * 5 * barItemWidth * 1.5,
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
                                      (max, item) => item.canXuLy > max
                                          ? item.canXuLy + 5
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
                                          color: MyColors.secondaryTextColor,
                                          width: 1),
                                      left: BorderSide(
                                          color: MyColors.secondaryTextColor,
                                          width: 1))),
                              barGroups: data.asMap().entries.map((entry) {
                                final index = entry.key;
                                final item = entry.value;
                                final List<BarChartRodData> rods = [];
                                if (controller.showCaseLamTrongNgay.value) {
                                  rods.add(
                                    BarChartRodData(
                                      toY: item.caseLamTrongNgay.toDouble(),
                                      color: MyColors.greenColor,
                                      width: barItemWidth,
                                      borderRadius: BorderRadius.zero,
                                    ),
                                  );
                                }
                                if (controller.showCanXuLy.value) {
                                  rods.add(
                                    BarChartRodData(
                                      toY: item.canXuLy.toDouble(),
                                      color: MyColors.blueColor,
                                      width: barItemWidth,
                                      borderRadius: BorderRadius.zero,
                                    ),
                                  );
                                }
                                if (controller.showXuLyTre.value) {
                                  rods.add(
                                    BarChartRodData(
                                      toY: item.xuLyTre.toDouble(),
                                      color: MyColors.redColor,
                                      width: barItemWidth,
                                      borderRadius: BorderRadius.zero,
                                    ),
                                  );
                                }
                                if (controller.showPhanTichTre.value) {
                                  rods.add(
                                    BarChartRodData(
                                      toY: item.phanTichTre.toDouble(),
                                      color: MyColors.orangeColor,
                                      width: barItemWidth,
                                      borderRadius: BorderRadius.zero,
                                    ),
                                  );
                                }
                                if (controller.showTestTre.value) {
                                  rods.add(
                                    BarChartRodData(
                                      toY: item.testTre.toDouble(),
                                      color: MyColors.purpleColor,
                                      width: barItemWidth,
                                      borderRadius: BorderRadius.zero,
                                    ),
                                  );
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
                                      case MyColors.greenColor:
                                        label = 'Số case đã xử lý';
                                        value =
                                            item.caseLamTrongNgay.toDouble();
                                        break;
                                      case MyColors.blueColor:
                                        label = 'Cần xử lý';
                                        value = item.canXuLy.toDouble();
                                        break;
                                      case MyColors.redColor:
                                        label = 'Xử lý trễ';
                                        value = item.xuLyTre.toDouble();
                                        break;
                                      case MyColors.orangeColor:
                                        label = 'Phân tích trễ';
                                        value = item.phanTichTre.toDouble();
                                        break;
                                      case MyColors.purpleColor:
                                        label = 'Test trễ';
                                        value = item.testTre.toDouble();
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
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, bottom: 4),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ItemChart(
                                color: MyColors.greenColor,
                                label: "Số case đã xử lý",
                                onClick: () {
                                  controller.showCaseLamTrongNgay.toggle();
                                },
                              ),
                              ItemChart(
                                  color: MyColors.blueColor,
                                  label: "Cần xử lý",
                                  onClick: () {
                                    controller.showCanXuLy.toggle();
                                  }),
                              ItemChart(
                                  color: MyColors.redColor,
                                  label: "Xử lý trễ",
                                  onClick: () {
                                    controller.showXuLyTre.toggle();
                                  })
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ItemChart(
                                color: MyColors.orangeColor,
                                label: "Phân tích trễ",
                                onClick: () {
                                  controller.showPhanTichTre.toggle();
                                },
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              ItemChart(
                                  color: MyColors.purpleColor,
                                  label: "Test trễ",
                                  onClick: () {
                                    controller.showTestTre.toggle();
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
