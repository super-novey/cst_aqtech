import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          child: Obx(
            () => (controller.isLoading.value)
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: MediaQuery.of(context)
                          .size
                          .width, // Set width to match screen
                      child: PaginatedDataTable(
                        columns: <DataColumn>[
                          DataColumn(
                              label: Text(
                                'Nick name',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              headingRowAlignment: MainAxisAlignment.center),
                          DataColumn(
                            label: Text(
                              'Tên đầy đủ',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            headingRowAlignment: MainAxisAlignment.center,
                          ),
                          DataColumn(
                            label: Text(
                              'Hạn mức nghỉ phép',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            headingRowAlignment: MainAxisAlignment.center,
                          ),
                          DataColumn(
                            label: Text(
                              'Tổng ngày nghỉ phép',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            headingRowAlignment: MainAxisAlignment.center,
                          ),
                          DataColumn(
                            label: Text(
                              'Tên số ngày phép còn lại',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            headingRowAlignment: MainAxisAlignment.center,
                          ),
                          DataColumn(
                            label: Text(
                              'Hạn mức % online',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            headingRowAlignment: MainAxisAlignment.center,
                          ),
                          DataColumn(
                            label: Text(
                              'Hạn mức số ngày online',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            headingRowAlignment: MainAxisAlignment.center,
                          ),
                          DataColumn(
                            label: Text(
                              'Số ngày online',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            headingRowAlignment: MainAxisAlignment.center,
                          ),
                          DataColumn(
                            label: Text(
                              'Số ngày online còn lại',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            headingRowAlignment: MainAxisAlignment.center,
                          ),
                        ],
                        source: LeaveDayDataSource(controller),
                        rowsPerPage: 10,
                        columnSpacing: 30,
                        horizontalMargin: 20,
                        showCheckboxColumn: false,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class LeaveDayDataSource extends DataTableSource {
  final LeavedayStatisticController controller;
  int? selectedIndex; // To track the selected row

  LeaveDayDataSource(this.controller);

  @override
  DataRow? getRow(int index) {
    if (index >= controller.leadayStatisticList.length) return null;
    final stat = controller.leadayStatisticList[index];

    return DataRow.byIndex(
      index: index,
      selected: selectedIndex == index, // Highlight if selected
      onSelectChanged: (bool? selected) {
        if (selected == true) {
          // Update selected index and notify listeners to refresh the table
          selectedIndex = index;
          notifyListeners(); // Calls to refresh the UI
        }
      },
      color: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (selectedIndex == index) {
            return MyColors.accentColor.withOpacity(0.3); // Highlighted color
          }
          return index % 2 == 0
              ? MyColors.lightPrimaryColor.withOpacity(0.4)
              : Colors.white;
        },
      ),
      cells: <DataCell>[
        DataCell(Center(child: Text(stat.nickName))),
        DataCell(Center(child: Text(stat.fullName))),
        DataCell(Center(child: Text(stat.leaveQuota.toString()))),
        DataCell(
            Center(child: Text(MyFormatter.formatDouble(stat.totalLeaveDays)))),
        DataCell(Center(
            child: Text(MyFormatter.formatDouble(stat.remainingLeaveDays)))),
        DataCell(Center(child: Text("${stat.onlineQuotaPercentage}%"))),
        DataCell(Center(
            child: Text(
                "${stat.getTotalOnlineQuotaDays(LeavedayFilterDateController.instance.selectedYear.value)}"))),
        DataCell(
            Center(child: Text(MyFormatter.formatDouble(stat.usedOnlineDays)))),
        DataCell(
          Center(
              child: Text(MyFormatter.formatDouble(stat.getRemainingOnlineDays(
                  LeavedayFilterDateController.instance.selectedYear.value)))),
        )
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.leadayStatisticList.length;

  @override
  int get selectedRowCount => selectedIndex != null ? 1 : 0;
}
