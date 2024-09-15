import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/appbar/appbar.dart';
import 'package:hrm_aqtech/features/statistic/controllers/LunchStatisticController/lunch_statistic_controller.dart';
import 'package:hrm_aqtech/features/statistic/views/lunch_statistic/widgets/lunch_filter.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class LunchStatisticScreen extends StatelessWidget {
  const LunchStatisticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LunchStatisticController());

    return Scaffold(
      appBar: MyAppBar(
        showBackArrow: true,
        iconColor: MyColors.primaryTextColor,
        title: Text(
          "Thống kê tính tiền ăn trưa theo tháng",
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
              bottom: LunchFilter(),
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
                              headingRowAlignment: MainAxisAlignment.center,
                              label: Text('Nick name',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall)),
                          DataColumn(
                              headingRowAlignment: MainAxisAlignment.center,
                              label: Text('Tên đầy đủ',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall)),
                          DataColumn(
                              headingRowAlignment: MainAxisAlignment.center,
                              label: Text(
                                  textAlign: TextAlign.center,
                                  'Tổng số ngày phép\n(trọn ngày)',
                                  maxLines: 2,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall)),
                          DataColumn(
                              headingRowAlignment: MainAxisAlignment.center,
                              label: Text(
                                  textAlign: TextAlign.center,
                                  'Tổng số ngày online\n(trọn ngày)',
                                  maxLines: 2,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall)),
                          DataColumn(
                              headingRowAlignment: MainAxisAlignment.center,
                              label: Text(
                                  textAlign: TextAlign.center,
                                  'Tổng số ngày công tác\n(trọn ngày)',
                                  maxLines: 2,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall)),
                          DataColumn(
                              headingRowAlignment: MainAxisAlignment.center,
                              label: Text(
                                  textAlign: TextAlign.center,
                                  'Tổng số ngày nghỉ chung\n(nếu có)',
                                  maxLines: 2,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall)),
                          DataColumn(
                              headingRowAlignment: MainAxisAlignment.center,
                              label: Text('Số ngày còn lại',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall)),
                        ],
                        source: LunchDataSource(controller),
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

class LunchDataSource extends DataTableSource {
  final LunchStatisticController controller;
  int? selectedIndex; // To track the selected row

  LunchDataSource(this.controller);

  @override
  DataRow? getRow(int index) {
    if (index == controller.lunchStatisticList.length) {
      return DataRow.byIndex(
        index: index,
        cells: <DataCell>[
          const DataCell(Text('')),
          const DataCell(Center(
            child: Text('Tổng cộng',
                style: TextStyle(fontWeight: FontWeight.bold)),
          )),
          DataCell(
            Center(
              child: Text(
                '${controller.totalIndividualDayOff}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          DataCell(
            Center(
              child: Text(
                '${controller.totalWorkingOnline}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          DataCell(
            Center(
              child: Text(
                '${controller.totalCommissionDay}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          DataCell(
            Center(
              child: Text(
                '${controller.totalAQDayOff}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          DataCell(
            Center(
              child: Text(
                '${controller.totalDaysRemaining}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      );
    }
    if (index >= controller.lunchStatisticList.length) return null;
    final stat = controller.lunchStatisticList[index];

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
        DataCell(Center(child: Text(stat.totalIndividualDayOff.toString()))),
        DataCell(Center(child: Text(stat.totalCommissionDay.toString()))),
        DataCell(Center(child: Text(stat.totalWorkingOnline.toString()))),
        DataCell(Center(child: Text(stat.totalAQDayOff.toString()))),
        DataCell(Center(
          child: Text(
              "${21 - stat.totalCommissionDay - stat.totalIndividualDayOff - stat.totalAQDayOff - stat.totalWorkingOnline}"),
        ))
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.lunchStatisticList.length + 1;

  @override
  int get selectedRowCount => selectedIndex != null ? 1 : 0;
}
