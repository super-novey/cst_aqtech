import 'package:flutter/material.dart';
import 'package:hrm_aqtech/common/widgets/appbar/appbar.dart';
import 'package:hrm_aqtech/common/widgets/container/rounded_container.dart';
import 'package:hrm_aqtech/features/business_days_management/models/business_date_model.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';

class BusinessDayDetailScreen extends StatelessWidget {
  const BusinessDayDetailScreen({super.key, required this.businessDate});

  final BusinessDate businessDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        showBackArrow: true,
        iconColor: MyColors.primaryTextColor,
        title: Text(
          "Thông tin ngày công tác",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MySizes.defaultSpace),
          child: MyRoundedContainer(
            padding: const EdgeInsets.all(MySizes.defaultSpace),
            showBorder: true,
            borderColor: MyColors.accentColor,
            child: Column(
              children: [
                BussinessDateMenu(
                  title: 'Từ ngày:',
                  value: MyFormatter.formatDateTime(businessDate.dateFrom),
                ),
                const SizedBox(
                  height: MySizes.spaceBtwInputFields,
                ),
                BussinessDateMenu(
                  title: 'Đến ngày:',
                  value: MyFormatter.formatDateTime(businessDate.dateTo),
                ),
                const SizedBox(
                  height: MySizes.spaceBtwInputFields,
                ),
                BussinessDateMenu(
                  title: 'Số lượng ngày:',
                  value: businessDate.sumDay.toString(),
                ),
                const SizedBox(
                  height: MySizes.spaceBtwInputFields,
                ),
                BussinessDateMenu(
                  title: 'Nội dung công tác:',
                  value: businessDate.commissionContent,
                ),
                const SizedBox(
                  height: MySizes.spaceBtwInputFields,
                ),
                BussinessDateMenu(
                  title: 'Phương tiện di chuyển:',
                  value: businessDate.transportation,
                ),
                const SizedBox(
                  height: MySizes.spaceBtwInputFields,
                ),
                BussinessDateMenu(
                  title: 'Chi phí công tác:',
                  value: businessDate.commissionExpenses.toString(),
                ),
                const SizedBox(
                  height: MySizes.spaceBtwInputFields,
                ),
                BussinessDateMenu(
                  title: 'Ghi chú chi phí công tác:',
                  value: businessDate.note,
                ),
                const SizedBox(
                  height: MySizes.spaceBtwInputFields,
                ),
                const Divider(
                  color: MyColors.dividerColor,
                ),
                const BussinessDateMenu(
                  title: 'Danh sách nhân sự:',
                  value: '',
                ),
                const SizedBox(
                  height: MySizes.spaceBtwInputFields,
                ),
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  border: TableBorder.all(color: MyColors.accentColor),
                  children: [
                    // Tiêu đề
                    TableRow(
                        decoration:
                            const BoxDecoration(color: MyColors.primaryColor),
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(MySizes.sm),
                              child: Text(
                                "Họ tên",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .apply(color: Colors.white),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(MySizes.sm),
                              child: Text(
                                "Công tác phí",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .apply(color: Colors.white),
                              ),
                            ),
                          ),
                        ]),
                    ...List.generate(businessDate.memberList.length, (index) {
                      final member = businessDate.memberList[index];
                      return TableRow(children: [
                        // TableCell(
                        //     child: Padding(
                        //   padding: const EdgeInsets.all(MySizes.sm),
                        //   child: Text(
                        //     member.id.toString(),
                        //   ),
                        // )),
                        FutureBuilder(
                            future: member.getNameById(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const TableCell(
                                    child: Padding(
                                  padding: EdgeInsets.all(MySizes.sm),
                                  child: Text(''),
                                ));
                              } else if (snapshot.hasError) {
                                return const TableCell(
                                    child: Padding(
                                  padding: EdgeInsets.all(MySizes.sm),
                                  child: Text(''),
                                ));
                              } else if (snapshot.hasData) {
                                final name = snapshot.data!;
                                return TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(MySizes.sm),
                                  child: Text(
                                    name,
                                  ),
                                ));
                              } else {
                                return const TableCell(
                                    child: Padding(
                                  padding: EdgeInsets.all(MySizes.sm),
                                  child: Text(''),
                                ));
                              }
                            }),
                        TableCell(
                            child: Padding(
                          padding: const EdgeInsets.all(MySizes.sm),
                          child: Text(
                            MyFormatter.formatCurrency(member.memberExpenses),
                          ),
                        )),
                      ]);
                    })
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BussinessDateMenu extends StatelessWidget {
  const BussinessDateMenu({
    super.key,
    required this.title,
    required this.value,
  });

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style:
              Theme.of(context).textTheme.bodyMedium!.apply(fontWeightDelta: 2),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
          ),
        )
      ],
    );
  }
}
