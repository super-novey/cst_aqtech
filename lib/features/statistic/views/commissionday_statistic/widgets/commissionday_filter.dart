import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/container/rounded_container.dart';
import 'package:hrm_aqtech/features/statistic/controllers/CommissionDayControllers/commissionday_filter_date_controller.dart';
import 'package:hrm_aqtech/features/statistic/controllers/CommissionDayControllers/commissionday_statistic_controller.dart';
import 'package:hrm_aqtech/features/statistic/controllers/CommissionDayControllers/quarter_dropdown_controller.dart';
import 'package:hrm_aqtech/features/statistic/controllers/LunchStatisticController/lunch_statistic_controller.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/devices/device_utils.dart';
import 'package:month_year_picker/month_year_picker.dart';

class CommissiondayFilter extends StatelessWidget
    implements PreferredSizeWidget {
  const CommissiondayFilter({super.key});
  @override
  Widget build(BuildContext context) {
    final CommissiondayFilterDateController yearController =
        Get.put(CommissiondayFilterDateController());
    final quarterDropDownController = Get.put(QuarterDropdownController());
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
              Expanded(
                child: TextField(
                    decoration: const InputDecoration(label: Text("Chọn năm")),
                    controller: yearController.yearController,
                    readOnly: true,
                    onTap: () => yearController.showYearPicker(context)),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Obx(() {
                  return MyRoundedContainer(
                    showBorder: true,
                    borderColor: Colors.grey,
                    child: DropdownButton<String>(
                      value: quarterDropDownController.selectedQuarter.value,
                      items: quarterDropDownController.quarters
                          .map((String quarter) {
                        return DropdownMenuItem<String>(
                          value: quarter,
                          child: Text(quarter),
                        );
                      }).toList(),
                      onChanged: (String? newQuarter) {
                        if (newQuarter != null) {
                          quarterDropDownController
                              .updateSelectedQuarter(newQuarter);
                        }
                      },
                    ),
                  );
                }),
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
                      CommissiondayStatisticController.instance
                          .fetchCommissionStatistics();
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
