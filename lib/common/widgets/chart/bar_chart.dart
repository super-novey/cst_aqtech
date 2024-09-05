import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/helpers/hepler_function.dart';

class CommonBarChart extends StatelessWidget {
  final String title;
  final Map<int, double> data;
  final String Function(int memberId) getEmployeeName;
  final String Function(double days) formatTooltip;

  const CommonBarChart({
    super.key,
    required this.title,
    required this.data,
    required this.getEmployeeName,
    required this.formatTooltip,
  });

  @override
  Widget build(BuildContext context) {
    final dataEntries = data.entries.toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 400,
            child: dataEntries.isEmpty
                ? const Center(child: Text('No data available'))
                : BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      gridData: const FlGridData(show: false),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 60,
                            getTitlesWidget: (value, meta) {
                              final memberId = dataEntries[value.toInt()].key;
                              final employeeName = getEmployeeName(memberId);
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: SizedBox(
                                  width: 40.0,
                                  child: Text(
                                    employeeName,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                    overflow:
                                        TextOverflow.visible, // Allow wrapping
                                    maxLines: 5, // Limit to two lines
                                    softWrap: true, // Enable wrapping
                                  ),
                                ),
                              );
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
                        show: true,
                        border: Border.all(
                          color: const Color(0xff37434d),
                          width: 1,
                        ),
                      ),
                      barGroups: dataEntries.asMap().entries.map((entry) {
                        final index = entry.key;
                        final totalDays = entry.value.value;

                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: totalDays,
                              color: MyColors.primaryColor,
                              width: HeplerFunction.calculateBarWidth(
                                  context, dataEntries.length),
                              borderRadius: BorderRadius.circular(4),
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
                            final memberId = dataEntries[group.x.toInt()].key;
                            final employeeName = getEmployeeName(memberId);
                            return BarTooltipItem(
                              '$employeeName\n',
                              const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: formatTooltip(rod.toY),
                                  style: const TextStyle(
                                    color: Colors.yellowAccent,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
