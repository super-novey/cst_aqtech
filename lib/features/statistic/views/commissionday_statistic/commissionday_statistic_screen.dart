import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/appbar/appbar.dart';
import 'package:hrm_aqtech/features/statistic/controllers/CommissionDayControllers/commissionday_statistic_controller.dart';
import 'package:hrm_aqtech/features/statistic/views/commissionday_statistic/widgets/commissionday_filter.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class CommissiondayStatisticScreen extends StatelessWidget {
  const CommissiondayStatisticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CommissiondayStatisticController());

    return Scaffold(
      appBar: MyAppBar(
        showBackArrow: true,
        iconColor: MyColors.primaryTextColor,
        title: Text(
          "Thống kê tính tiền công tác phí theo quý",
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
              bottom: CommissiondayFilter(),
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
                              label: Text(
                                'Nick name',
                                style: Theme.of(context).textTheme.headlineSmall,
                              )),
                          DataColumn(
                              headingRowAlignment: MainAxisAlignment.center,
                              label: Text('Tên đầy đủ',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall)),
                          DataColumn(
                              headingRowAlignment: MainAxisAlignment.center,
                              label: Text(
                                style: Theme.of(context).textTheme.headlineSmall,
                                'Tổng số ngày công tác',
                              )),
                          DataColumn(
                              headingRowAlignment: MainAxisAlignment.center,
                              label: Text(
                                'Tổng số ngày công tác phí',
                                style: Theme.of(context).textTheme.headlineSmall,
                              )),
                        ],
                        source: CommisstionDayDataSource(controller),
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

class CommisstionDayDataSource extends DataTableSource {
  final CommissiondayStatisticController controller;
  int? selectedIndex; // To track the selected row

  CommisstionDayDataSource(this.controller);

  @override
  DataRow? getRow(int index) {
    if (index == controller.commissionStatisticList.length) {
      return DataRow.byIndex(
        index: index,
        cells: <DataCell>[
          const DataCell(Center(
              child: Text(
            'Tổng cộng:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ))),
          const DataCell(Center(child: Text(''))), // Empty cell for 'Full Name'
          DataCell(Center(
              child: Text(
            controller.totalCommissionDay.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ))),
          DataCell(Center(
              child: Text(
            controller.totalCommissionPayment.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ))),
        ],
      );
    }
    if (index >= controller.commissionStatisticList.length) return null;
    final stat = controller.commissionStatisticList[index];

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
        DataCell(Center(child: Text(stat.totalCommissionDay.toString()))),
        DataCell(Center(child: Text(stat.totalCommissionPayment.toString()))),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.commissionStatisticList.length + 1;

  @override
  int get selectedRowCount => selectedIndex != null ? 1 : 0;
}
