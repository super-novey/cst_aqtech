import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/appbar/appbar.dart';
import 'package:hrm_aqtech/features/business_days_management/controllers/date_range_controller.dart';
import 'package:hrm_aqtech/features/business_days_management/views/business_days_list/widgets/business_date_tile.dart';
import 'package:hrm_aqtech/features/business_days_management/views/business_days_list/widgets/filter_tool.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';

class BusinessDaysListScreen extends StatelessWidget {
  const BusinessDaysListScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {},
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
          body: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(MySizes.defaultSpace),
                  child: BusinessDateTile(),
                );
              }),
        ));
  }
}
