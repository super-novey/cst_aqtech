import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/container/rounded_container.dart';
import 'package:hrm_aqtech/features/statistic/controllers/LunchStatisticController/filter_date_controller.dart';
import 'package:hrm_aqtech/features/statistic/controllers/LunchStatisticController/lunch_statistic_controller.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/devices/device_utils.dart';
import 'package:month_year_picker/month_year_picker.dart';

class LunchFilter extends StatelessWidget implements PreferredSizeWidget {
  const LunchFilter({super.key});
  @override
  Widget build(BuildContext context) {
    final LunchFilterDateController monthYearController =
        Get.put(LunchFilterDateController());
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
                      onPressed: () {},
                      icon: const Icon(Icons.filter_alt_off))),
              const SizedBox(
                width: MySizes.spaceBtwItems - 2,
              ),
              // text hiển thị ngày
              Expanded(
                child: TextField(
                  controller: monthYearController.dateController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showMonthYearPicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(DateTime.now().year - 20),
                      lastDate: DateTime(DateTime.now().year + 20),
                    );
                    if (pickedDate != null) {
                      monthYearController.updateDate(pickedDate);
                    }
                  },
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
                      LunchStatisticController.instance.fetchLunchStatistics();
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
  Size get preferredSize =>
      Size.fromHeight(MyDeviceUtils.getAppBarHeight() * 2);
}
