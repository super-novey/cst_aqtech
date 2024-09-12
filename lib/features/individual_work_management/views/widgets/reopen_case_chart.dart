import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hrm_aqtech/features/individual_work_management/controllers/filter_controller.dart';
import 'package:hrm_aqtech/features/individual_work_management/controllers/individual_work_controller.dart';
import 'package:hrm_aqtech/features/individual_work_management/models/individual_work_model.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';

class ReopenCaseChart extends StatelessWidget {
  const ReopenCaseChart({super.key});

  @override
  Widget build(BuildContext context) {
    final IndividualWork individualWork =
        IndividualWorkController.instance.individualWork.value;
    final year = FilterController.instance.year.value;

    const double redLineValue = 20.0;

    // Prepare the spots for the line chart
    List<FlSpot> spots =
        individualWork.soLuotCaseBiMoLai.asMap().entries.map((entry) {
      int index = entry.key;
      int reopenedCases = entry.value;
      int totalCases = individualWork.soLuongCaseThucHienTrongTuan[index];

      double ratio = totalCases > 0 ? (reopenedCases / totalCases) * 100 : 0.0;

      return FlSpot(index.toDouble(), ratio);
    }).toList();

    if (spots.isEmpty) {
      spots = [const FlSpot(0, 0)];
    }

    double chartWidth = spots.length * 40.0;
    double minWidth = 600;
    chartWidth = chartWidth < minWidth ? minWidth : chartWidth;

    return Column(
      children: [
        const SizedBox(height: 20.0),
        const Text(
          'Số lần mở lại case',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          '(Tính theo phần trăm)',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Năm $year',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: chartWidth,
              height: 400,
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false, // Hide the top titles
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 60,
                          getTitlesWidget: (value, meta) {
                            if (value.toInt() % 2 == 0) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: SizedBox(
                                  width: 50,
                                  child: Text(
                                    'Week ${value.toInt() + 1}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.visible,
                                    maxLines: 1,
                                    softWrap: true,
                                  ),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 50,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              '${(value).toStringAsFixed(0)}%',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(
                        color: const Color(0xff37434d),
                        width: 1,
                      ),
                    ),
                    minX: 0,
                    maxX: spots.isNotEmpty ? spots.length.toDouble() - 1 : 1,
                    minY: spots
                        .map((spot) => spot.y)
                        .reduce((a, b) => a < b ? a : b),
                    maxY: spots
                        .map((spot) => spot.y)
                        .reduce((a, b) => a > b ? a : b),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          const FlSpot(0, redLineValue),
                          FlSpot(spots.length.toDouble() - 1, redLineValue)
                        ],
                        isCurved: false,
                        color: Colors.red,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(show: false),
                        aboveBarData: BarAreaData(show: false),
                        // Line thickness
                      ),
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        color: MyColors.primaryColor,
                        dotData: const FlDotData(show: true),
                        belowBarData: BarAreaData(
                          show: false,
                        ),
                        aboveBarData: BarAreaData(
                          show: false,
                        ),
                        // aboveBarData: BarAreaData(
                        //   show: true,
                        //   color: const Color.fromARGB(255, 18, 237, 113)
                        //       .withOpacity(0.4),
                        //   cutOffY: 20.0,
                        //   applyCutOffY: true,
                        // ),
                        // belowBarData: BarAreaData(
                        //   show: true,
                        //   color: const Color.fromARGB(255, 250, 75, 40)
                        //       .withOpacity(0.3),
                        //   // spotsLine: ,
                        //   cutOffY: 20.0,
                        //   applyCutOffY: true,
                        // ),
                        preventCurveOverShooting: true,
                      ),
                      // Add a red horizontal line at y = 20
                    ],
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        getTooltipItems: (List<LineBarSpot> touchedSpots) {
                          return touchedSpots.map((spot) {
                            return LineTooltipItem(
                              'Week ${spot.x.toInt() + 1}\n',
                              const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      '% Mở lại case: ${MyFormatter.formatDouble(double.parse(spot.y.toStringAsFixed(2)))}',
                                  style: const TextStyle(
                                    color: Colors.yellow,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            );
                          }).toList();
                        },
                      ),
                      handleBuiltInTouches: true,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
