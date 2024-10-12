import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/shimmers/shimmer_list_tile.dart';
import 'package:hrm_aqtech/common/widgets/appbar/appbar.dart';
import 'package:hrm_aqtech/features/authentication/controllers/authentication_controller.dart';
import 'package:hrm_aqtech/features/business_days_management/controllers/bussiness_day_list_controller.dart';
import 'package:hrm_aqtech/features/business_days_management/controllers/date_range_controller.dart';
import 'package:hrm_aqtech/features/business_days_management/models/business_date_model.dart';
import 'package:hrm_aqtech/features/business_days_management/views/business_days_list/widgets/business_date_tile.dart';
import 'package:hrm_aqtech/features/business_days_management/views/business_days_list/widgets/business_day_chart.dart';
import 'package:hrm_aqtech/features/business_days_management/views/business_days_list/widgets/filter_tool.dart';
import 'package:hrm_aqtech/features/business_days_management/views/bussiness_days_update/bussiness_days_update.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class BusinessDaysListScreen extends StatelessWidget {
  const BusinessDaysListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final employeeController = Get.put(EmployeeController());
    final bussinessDateController = Get.put(BussinessDayListController());
    return Scaffold(
      appBar: MyAppBar(
        showBackArrow: true,
        iconColor: MyColors.primaryTextColor,
        title: Text(
          "Quản lý ngày công tác",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          Obx(() {
            return IconButton(
              icon: const Icon(Icons.bar_chart_rounded),
              onPressed: (bussinessDateController.isChartReady.value &&
                      employeeController.isEmployeeDataReady.value)
                  ? () {
                      Get.to(() => const BusinessDayChart());
                    }
                  : null, // Disable the button until ready
              color: (bussinessDateController.isChartReady.value &&
                      employeeController.isEmployeeDataReady.value)
                  ? MyColors.primaryTextColor
                  : Colors.grey, // Change color to indicate disabled state
            );
          }),
          if (AuthenticationController.instance.currentUser.isLeader)
            IconButton(
                onPressed: () {
                  bussinessDateController.updateBusinessDay.isAdd.value = true;
                  Get.to(() => BussinessDaysUpdate(
                        businessDate: BusinessDate(
                            dateFrom: DateTime.now(), dateTo: DateTime.now()),
                      ));
                  DateRangeController.instance.onClose();
                },
                icon: const Icon(
                  Icons.add,
                  color: MyColors.primaryTextColor,
                ))
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (_, innerBoxIsScrolled) {
          return [
            const SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              //floating: true,
              backgroundColor: Colors.white,
              //expandedHeight: 0,
              //collapsedHeight: 250,
              bottom: Filter(),
            )
          ];
        },
        body: Obx(
          () => (bussinessDateController.isLoading.value ||
                  !employeeController.isEmployeeDataReady.value ||
                  !bussinessDateController.isChartReady.value)
              ? const ShimmerListTile()
              : ListView(
                  children: [
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            bussinessDateController.bussinessDateList.length,
                        itemBuilder: (context, index) {
                          final tmp =
                              bussinessDateController.bussinessDateList[index];
                          return BusinessDateTile(
                            backgroundColor: (index % 2 == 0)
                                ? MyColors.lightPrimaryColor
                                : Colors.white,
                            businessDate: tmp,
                          );
                        }),
                  ],
                ),
        ),
      ),
    );
  }
}
