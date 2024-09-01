import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/texts/dashed_line.dart';
import 'package:hrm_aqtech/features/business_days_management/views/business_days_list/widgets/footer_widget.dart';
import 'package:hrm_aqtech/features/business_days_management/views/business_days_list/widgets/member_list_widget.dart';
import 'package:hrm_aqtech/features/business_days_management/views/bussiness_day_detail/bussiness_day_detail_screen.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';

class BusinessDateTile extends StatelessWidget {
  const BusinessDateTile({super.key, required this.backgroundColor});

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => const BussinessDayDetailScreen()),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: MySizes.defaultSpace, vertical: MySizes.spaceBtwItems),
        child: Slidable(
          endActionPane: ActionPane(motion: const BehindMotion(), children: [
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: MyColors.accentColor,
              foregroundColor: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(MySizes.cardRadiusMd),
                  bottomLeft: Radius.circular(MySizes.cardRadiusMd)),
              icon: Icons.edit,
            ),
            SlidableAction(
              onPressed: (context) {},
              icon: Icons.delete,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(MySizes.cardRadiusMd),
                  bottomRight: Radius.circular(MySizes.cardRadiusMd)),
              foregroundColor: Colors.white,
              backgroundColor: MyColors.accentColor,
            )
          ]),
          child: Card(
              elevation: 4,
              color: backgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(MySizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      "DHMO Đại học Mở TPHCM: Triển khai khối lượng giảng dạy",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: MySizes.spaceBtwItems,
                    ),

                    // Danh sách thành viên
                    const MemberListWidget(),
                    const SizedBox(
                      height: MySizes.spaceBtwItems,
                    ),

                    // Divider
                    const Divider(
                      color: MyColors.dividerColor,
                    ),

                    const FooterWidget()
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
