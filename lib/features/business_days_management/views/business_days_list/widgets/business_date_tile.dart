import 'package:flutter/material.dart';
import 'package:hrm_aqtech/common/widgets/container/rounded_container.dart';
import 'package:hrm_aqtech/common/widgets/texts/dashed_line.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/constants/texts.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';

class BusinessDateTile extends StatelessWidget {
  const BusinessDateTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: MySizes.defaultSpace, vertical: MySizes.spaceBtwItems),
      child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(MySizes.sm),
            child: Column(
              children: [
                // Danh sách thành viên
                SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: ListView.builder(
                      itemCount: 2,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) {
                        return MyRoundedContainer(
                          margin: const EdgeInsets.only(right: MySizes.sm),
                          padding: const EdgeInsets.symmetric(
                              horizontal: MySizes.sm),
                          backgroundColor: MyColors.primaryColor,
                          child: Center(
                              child: Text(
                            "Nguyen Anh Duy",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .apply(color: Colors.white),
                          )),
                        );
                      }),
                ),
                const SizedBox(
                  height: MySizes.spaceBtwItems,
                ),
                // Ngày bắt đầu - Số ngày -  Ngày kết thúc
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Ngày bắt đầu
                    Text(
                      "01/01/2024",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .apply(color: MyColors.dartPrimaryColor),
                    ),

                    const SizedBox(
                      width: MySizes.sm,
                    ),

                    const DashedLine(),

                    // Số lượng ngày
                    Text(
                      " 5 ngày ",
                      style: Theme.of(context).textTheme.bodyLarge!.apply(
                          color: MyColors.secondaryTextColor,
                          fontStyle: FontStyle.italic),
                    ),

                    const DashedLine(),
                    const SizedBox(
                      width: MySizes.sm,
                    ),
                    // Ngày kết thúc
                    Text(
                      "01/01/2024",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .apply(color: MyColors.dartPrimaryColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: MySizes.spaceBtwItems,
                ),

                // Nội dung công tác
                const Text(
                  MyTexts.lorem,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),

                // Divider
                const Divider(
                  color: MyColors.dividerColor,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.motorcycle_sharp),
                          const SizedBox(
                            width: MySizes.sm,
                          ),
                          Expanded(
                            child: Text(
                              MyTexts.lorem,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .apply(color: MyColors.accentColor),
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      MyFormatter.formatCurrency(200000000),
                      style: Theme.of(context).textTheme.headlineSmall,
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
