import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/container/rounded_container.dart';
import 'package:hrm_aqtech/features/business_days_management/controllers/bussiness_day_list_controller.dart';
import 'package:hrm_aqtech/features/business_days_management/controllers/date_range_controller.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/devices/device_utils.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';

class Filter extends StatelessWidget implements PreferredSizeWidget {
  const Filter({super.key});
  @override
  Widget build(BuildContext context) {
    final dateRangeController = Get.put(DateRangeController());
    return Padding(
      padding: const EdgeInsets.all(MySizes.defaultSpace),
      child: Column(
        children: [
          // Lọc ngày
          Row(
            children: [
              MyRoundedContainer(
                  showBorder: true,
                  borderColor: MyColors.accentColor,
                  child: IconButton(
                      onPressed: () {
                        BussinessDayListController.instance
                            .fetchBussinessDate(true);
                      },
                      icon: const Icon(Icons.filter_alt_off))),
              const SizedBox(
                width: MySizes.spaceBtwItems - 2,
              ),
              // text hiển thị ngày
              Expanded(
                child: GestureDetector(
                  onTap: dateRangeController.showRangeDatePicker,
                  child: MyRoundedContainer(
                    padding: const EdgeInsets.all(12),
                    borderColor: MyColors.dartPrimaryColor,
                    showBorder: true,
                    child: Obx(
                      () => Text(
                        "${MyFormatter.formatDateTime(dateRangeController.dateRange.value.start)} - ${MyFormatter.formatDateTime(dateRangeController.dateRange.value.end)}",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                width: MySizes.spaceBtwItems,
              ),

              // button tìm kiếm
              MyRoundedContainer(
                  backgroundColor: MyColors.dartPrimaryColor,
                  child: IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      BussinessDayListController.instance
                          .fetchBussinessDate(false);
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(MyDeviceUtils.getAppBarHeight() * 2.5);
}
