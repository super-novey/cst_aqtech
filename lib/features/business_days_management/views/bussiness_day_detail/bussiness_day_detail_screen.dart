import 'package:flutter/material.dart';
import 'package:hrm_aqtech/common/widgets/appbar/appbar.dart';
import 'package:hrm_aqtech/common/widgets/container/rounded_container.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';

class BussinessDayDetailScreen extends StatelessWidget {
  const BussinessDayDetailScreen({super.key});

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
                const BussinessDateMenu(
                  title: 'Từ ngày:',
                  value: '01/03/2024',
                ),
                const SizedBox(
                  height: MySizes.spaceBtwInputFields,
                ),
                const BussinessDateMenu(
                  title: 'Đến ngày:',
                  value: '01/03/2024',
                ),
                const SizedBox(
                  height: MySizes.spaceBtwInputFields,
                ),
                const BussinessDateMenu(
                  title: 'Số lượng ngày:',
                  value: '1',
                ),
                const SizedBox(
                  height: MySizes.spaceBtwInputFields,
                ),
                const BussinessDateMenu(
                  title: 'Nội dung công tác:',
                  value:
                      'DHMO Đại học Mở TPHCM: Triển khai khối lượng giảng dạy',
                ),
                const SizedBox(
                  height: MySizes.spaceBtwInputFields,
                ),
                const BussinessDateMenu(
                  title: 'Phương tiện di chuyển:',
                  value: 'Xe anh Thành',
                ),
                const SizedBox(
                  height: MySizes.spaceBtwInputFields,
                ),
                const BussinessDateMenu(
                  title: 'Chi phí công tác:',
                  value: '0',
                ),
                const SizedBox(
                  height: MySizes.spaceBtwInputFields,
                ),
                const BussinessDateMenu(
                  title: 'Ghi chú chi phí công tác:',
                  value: '75000 phí công tác + phí phương tiện 100000',
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
                    ...List.generate(
                        3,
                        (index) => TableRow(children: [
                              const TableCell(
                                  child: Padding(
                                padding: EdgeInsets.all(MySizes.sm),
                                child: Text(
                                  "Nguyễn Phước Thành",
                                ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: const EdgeInsets.all(MySizes.sm),
                                child: Text(
                                  MyFormatter.formatCurrency(185000),
                                ),
                              )),
                            ]))
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
