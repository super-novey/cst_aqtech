import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/appbar/appbar.dart';
import 'package:hrm_aqtech/features/statistic/controllers/OverTimeControllers/overtime_statistic_controller.dart';
import 'package:hrm_aqtech/features/statistic/views/overtime_statistic/widgets/overtime_filter.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';

class OvertimeStatisticScreen extends StatelessWidget {
  const OvertimeStatisticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OvertimeStatisticController());

    return Scaffold(
      appBar: MyAppBar(
        showBackArrow: true,
        iconColor: MyColors.primaryTextColor,
        title: Text(
          "Thống kê làm việc ngoài giờ",
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
              bottom: OvertimeFilter(),
            )
          ];
        },
        body: Obx(
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
                            label: Text(
                              'Nick name',
                              style: Theme.of(context).textTheme.headlineSmall,
                            )),
                        DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            label: Text(
                              'Tên đầy đủ',
                              style: Theme.of(context).textTheme.headlineSmall,
                            )),
                        DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            label: Text(
                              textAlign: TextAlign.center,
                              'Tổng số giờ',
                              style: Theme.of(context).textTheme.headlineSmall,
                            )),
                      ],
                      source: OverTimeDataSource(controller),
                      rowsPerPage: 10,
                      columnSpacing: 30,
                      horizontalMargin: 20,
                      showCheckboxColumn: false,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class OverTimeDataSource extends DataTableSource {
  final OvertimeStatisticController controller;
  int? selectedIndex; // To track the selected row

  OverTimeDataSource(this.controller);

  @override
  DataRow? getRow(int index) {
    if (index == controller.overtimeStatisticList.length) {
      return DataRow.byIndex(
        index: index,
        cells: <DataCell>[
          const DataCell(Text('')),
          const DataCell(
              Text('Tổng cộng', style: TextStyle(fontWeight: FontWeight.bold))),
          DataCell(
            Center(
              child: Text(
                MyFormatter.formatDouble(controller.sumHours),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      );
    }
    if (index >= controller.overtimeStatisticList.length) return null;
    final stat = controller.overtimeStatisticList[index];

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
        DataCell(Center(child: Text(MyFormatter.formatDouble(stat.sumHours)))),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.overtimeStatisticList.length + 1;

  @override
  int get selectedRowCount => selectedIndex != null ? 1 : 0;
}
