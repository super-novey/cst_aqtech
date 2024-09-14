import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hrm_aqtech/common/widgets/appbar/appbar.dart';
import 'package:hrm_aqtech/features/statistic/controllers/LeaveDayControllers/leaveday_filter_date_controller.dart';
import 'package:hrm_aqtech/features/statistic/controllers/LeaveDayControllers/leaveday_statistic_controller.dart';
import 'package:hrm_aqtech/features/statistic/views/leave_day_statistic/widgets/leaveday_filter.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';

class LeaveDayStatisticScreen extends StatelessWidget {
  const LeaveDayStatisticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeavedayStatisticController());
    return Scaffold(
      appBar: MyAppBar(
        showBackArrow: true,
        iconColor: MyColors.primaryTextColor,
        title: Text(
          "Thống kê tính nghỉ phép năm",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              const SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: Colors.white,
                expandedHeight: 100,
                bottom: LeavedayFilter(),
              )
            ];
          },
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(
                () => (controller.isLoading.value)
                    ? const CircularProgressIndicator()
                    : DataTable(columns: const <DataColumn>[
                        DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            label: Text('Nick name')),
                        DataColumn(label: Text('Tên đầy đủ')),
                        DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            label: Text(
                              textAlign: TextAlign.center,
                              'Hạn mức nghỉ phép',
                            )),
                        DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            label: Text(
                              textAlign: TextAlign.center,
                              'Tổng ngày nghỉ phép',
                            )),
                        DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            label: Text(
                              textAlign: TextAlign.center,
                              'Tên số ngày phép còn lại',
                            )),
                        DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            label: Text(
                              textAlign: TextAlign.center,
                              'Hạn mức % online',
                            )),
                        DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            label: Text(
                              textAlign: TextAlign.center,
                              'Hạn mức số ngày online',
                            )),
                        DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            label: Text(
                              textAlign: TextAlign.center,
                              'Số ngày online',
                            )),
                        DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            label: Text(
                              textAlign: TextAlign.center,
                              'Số ngày online còn lại',
                            )),
                      ], rows: [
                        ...controller.leadayStatisticList
                            .asMap()
                            .entries
                            .map((entry) {
                          int index = entry.key;
                          var stat = entry.value;
                          return DataRow(
                              color: WidgetStateProperty.resolveWith<Color>(
                                  (Set<WidgetState> states) {
                                // Nếu chỉ số dòng là chẵn thì thay đổi màu nền
                                return index % 2 == 0
                                    ? MyColors.lightPrimaryColor
                                        .withOpacity(0.4)
                                    : Colors.white;
                              }),
                              cells: <DataCell>[
                                DataCell(Text(stat.nickName)),
                                DataCell(Text(stat.fullName)),
                                DataCell(Text(stat.leaveQuota.toString())),
                                DataCell(Text(MyFormatter.formatDouble(
                                    stat.totalLeaveDays))),
                                DataCell(Text(MyFormatter.formatDouble(
                                    stat.remainingLeaveDays))),
                                DataCell(
                                    Text("${stat.onlineQuotaPercentage}%")),
                                DataCell(Text(
                                    "${stat.getTotalOnlineQuotaDays(LeavedayFilterDateController.instance.selectedYear.value)}")),
                                DataCell(Text(MyFormatter.formatDouble(
                                    stat.usedOnlineDays))),
                                DataCell(Text(MyFormatter.formatDouble(
                                    stat.getRemainingOnlineDays(
                                        LeavedayFilterDateController
                                            .instance.selectedYear.value)))),
                              ]);
                        }),
                      ]),
              ),
            ),
          )),
    );
  }
}
