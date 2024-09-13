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
                              'Tổng số giờ',
                            )),
                      ], rows: [
                        ...controller.overtimeStatisticList
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
                                    MyFormatter.formatDouble(stat.sumHours))),
                              ]);
                        }),

                        // // Hàng tổng cộng
                        DataRow(
                          cells: [
                            const DataCell(Text('')),
                            const DataCell(Text('Tổng cộng',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(
                              Text(
                                MyFormatter.formatDouble(controller.sumHours),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ]),
              ),
            ),
          )),
    );
  }
}
