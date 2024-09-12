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
                              'Tổng số ngày phép\n(trọn ngày)',
                              maxLines: 2,
                            )),
                        DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            label: Text(
                              textAlign: TextAlign.center,
                              'Tổng số ngày online\n(trọn ngày)',
                              maxLines: 2,
                            )),
                        DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            label: Text(
                              textAlign: TextAlign.center,
                              'Tổng số ngày công tác\n(trọn ngày)',
                              maxLines: 2,
                            )),
                        DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            label: Text(
                              textAlign: TextAlign.center,
                              'Tổng số ngày nghỉ chung\n(nếu có)',
                              maxLines: 2,
                            )),
                        DataColumn(
                            headingRowAlignment: MainAxisAlignment.center,
                            label: Text('Số ngày còn lại')),
                      ], rows: [
                        ...controller.lunchStatisticList
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
                                DataCell(Text(
                                    textAlign: TextAlign.center,
                                    stat.nickName)),
                                DataCell(Text(
                                    textAlign: TextAlign.center,
                                    stat.fullName)),
                                DataCell(Text(
                                    textAlign: TextAlign.center,
                                    stat.totalIndividualDayOff.toString())),
                                DataCell(Text(
                                    textAlign: TextAlign.center,
                                    stat.totalCommissionDay.toString())),
                                DataCell(Text(
                                    textAlign: TextAlign.center,
                                    stat.totalWorkingOnline.toString())),
                                DataCell(Text(
                                    textAlign: TextAlign.center,
                                    stat.totalAQDayOff.toString())),
                                DataCell(Text(
                                    "${21 - stat.totalCommissionDay - stat.totalIndividualDayOff - stat.totalAQDayOff - stat.totalWorkingOnline}"))
                              ]);
                        }),

                        // Hàng tổng cộng
                        DataRow(
                          cells: [
                            const DataCell(Text('')),
                            const DataCell(Text('Tổng cộng',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(
                              Text(
                                '${controller.totalIndividualDayOff}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataCell(
                              Text(
                                '${controller.totalWorkingOnline}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataCell(
                              Text(
                                '${controller.totalCommissionDay}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataCell(
                              Text(
                                '${controller.totalAQDayOff}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataCell(
                              Text(
                                '${controller.totalDaysRemaining}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ]),
              ),
            ),
          )),
    );
  }
}
