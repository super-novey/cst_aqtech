import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/container/rounded_container.dart';
import 'package:hrm_aqtech/features/statistic/controllers/OverTimeControllers/overtime_filter_date_controller.dart';
import 'package:hrm_aqtech/features/statistic/controllers/OverTimeControllers/overtime_quarter_dropdown_controller.dart';
import 'package:hrm_aqtech/features/statistic/controllers/OverTimeControllers/overtime_statistic_controller.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/devices/device_utils.dart';

class OvertimeFilter extends StatelessWidget implements PreferredSizeWidget {
  const OvertimeFilter({super.key});
  @override
  Widget build(BuildContext context) {
    final yearController = Get.put(OvertimeFilterDateController());
    final quarterDropDownController =
        Get.put(OvertimeQuarterDropdownController());
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
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: quarterDropDownController.selectedQuarter.value,
                        items: quarterDropDownController.quarters
                            .map((String quarter) {
                          return DropdownMenuItem<String>(
                            value: quarter,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(quarter),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newQuarter) {
                          if (newQuarter != null) {
                            quarterDropDownController
                                .updateSelectedQuarter(newQuarter);
                          }
                        },
                      ),
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
                      OvertimeStatisticController.instance
                          .fetchOvertimeStatistics();
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
