import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/shimmers/shimmer_list_tile.dart';
import 'package:hrm_aqtech/common/widgets/appbar/appbar.dart';
import 'package:hrm_aqtech/features/business_days_management/controllers/bussiness_day_list_controller.dart';
import 'package:hrm_aqtech/features/business_days_management/controllers/date_range_controller.dart';
import 'package:hrm_aqtech/features/business_days_management/views/business_days_list/widgets/business_date_tile.dart';
import 'package:hrm_aqtech/features/business_days_management/views/business_days_list/widgets/filter_tool.dart';
import 'package:hrm_aqtech/features/business_days_management/views/bussiness_days_update/bussiness_days_update.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class BusinessDaysListScreen extends StatelessWidget {
  const BusinessDaysListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bussinessDateController = Get.put(BussinessDayListController());
    return Scaffold(
        appBar: MyAppBar(
          showBackArrow: true,
          iconColor: MyColors.primaryTextColor,
          title: Text(
            "Quản lý ngày công tác",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => const BussinessDaysUpdate());
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
                floating: true,
                backgroundColor: Colors.white,
                expandedHeight: 100,
                bottom: Filter(),
              )
            ];
          },
          body: Obx(
            () => (bussinessDateController.isLoading.value)
                ? const ShimmerListTile()
                : ListView.builder(
                    itemCount: bussinessDateController.bussinessDateList.length,
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
          ),
        ));
  }
}
