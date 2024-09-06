import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/texts/dashed_line.dart';
import 'package:hrm_aqtech/features/business_days_management/controllers/bussiness_day_list_controller.dart';
import 'package:hrm_aqtech/features/business_days_management/controllers/format_day_controller.dart';
import 'package:hrm_aqtech/features/business_days_management/models/business_date_model.dart';
import 'package:hrm_aqtech/features/business_days_management/views/business_days_list/widgets/member_list_widget.dart';
import 'package:hrm_aqtech/features/business_days_management/views/bussiness_day_detail/bussiness_day_detail_screen.dart';
import 'package:hrm_aqtech/features/business_days_management/views/bussiness_days_update/bussiness_days_update.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';

class BusinessDateTile extends StatelessWidget {
  const BusinessDateTile(
      {super.key, required this.backgroundColor, required this.businessDate});

  final Color backgroundColor;
  final BusinessDate businessDate;
  
  @override
  Widget build(BuildContext context) {
    final formatDayController = Get.put(FormatDayController());
    return GestureDetector(
      onTap: () => Get.to(() => BusinessDayDetailScreen(
            businessDate: businessDate,
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: MySizes.defaultSpace, vertical: MySizes.spaceBtwItems),
        child: Slidable(
          endActionPane: ActionPane(motion: const BehindMotion(), children: [
            SlidableAction(
              onPressed: (context) {
                Get.to(() => BussinessDaysUpdate(
                      businessDate: businessDate,
                    ));
              },
              backgroundColor: MyColors.accentColor,
              foregroundColor: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(MySizes.cardRadiusMd),
                  bottomLeft: Radius.circular(MySizes.cardRadiusMd)),
              icon: Icons.edit,
            ),
            SlidableAction(
              onPressed: (context) {
                BussinessDayListController.instance.delete(businessDate.id);
              },
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
                          MyFormatter.formatDateTime(businessDate.dateFrom),
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
                          " ${formatDayController.formatDayController(businessDate.sumDay)} ngày ",
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
                          MyFormatter.formatDateTime(businessDate.dateTo),
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
                    Text(
                      businessDate.commissionContent,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: MySizes.spaceBtwItems,
                    ),

                    // Danh sách thành viên
                    MemberListWidget(
                      memberList: businessDate.memberList,
                    ),
                    const SizedBox(
                      height: MySizes.spaceBtwItems,
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
                            // Phương tiện di chuyển
                            children: [
                              const Icon(Icons.motorcycle_sharp),
                              const SizedBox(
                                width: MySizes.sm,
                              ),
                              Expanded(
                                child: Text(
                                  businessDate.transportation,
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
                        // Công tác phí
                        Text(
                          MyFormatter.formatCurrency(
                              businessDate.commissionExpenses),
                          style: Theme.of(context).textTheme.headlineSmall,
                        )
                      ],
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
