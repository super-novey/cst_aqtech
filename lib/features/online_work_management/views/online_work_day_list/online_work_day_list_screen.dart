import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/features/online_work_management/controllers/online_work_day_controller.dart';
import 'package:hrm_aqtech/features/online_work_management/controllers/update_online_work_day_controller.dart';
import 'package:hrm_aqtech/features/online_work_management/models/online_work_day_model.dart';
import 'package:hrm_aqtech/features/online_work_management/views/online_work_day_detail/online_work_day_detail.dart';
import 'package:hrm_aqtech/features/online_work_management/views/online_work_day_list/widgets/date_range_online_work_widget.dart';
import 'package:hrm_aqtech/features/online_work_management/views/online_work_day_list/widgets/online_work_day_chart.dart';
import 'package:hrm_aqtech/features/online_work_management/views/online_work_day_list/widgets/online_work_day_tile.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class OnlineWorkDayListScreen extends StatelessWidget {
  const OnlineWorkDayListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final onlineWorkDayController = Get.put(OnlineWorkDayController());
    final employeeController = Get.put(EmployeeController());
    final updateOnlineWorkDayController =
        Get.put(UpdateOnlineWorkDayController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text("Ngày làm việc online"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              updateOnlineWorkDayController.isAdd.value = true;
              updateOnlineWorkDayController.toggleEditting();
              Get.to(() => OnlineWorkDayDetailScreen(
                    selectedOnlineWorkDay: OnlineWork(),
                  ));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: const DateRangeOnlineWorkWidget(),
          ),
          const Divider(),
          Expanded(
            child: Obx(() {
              if (onlineWorkDayController.isLoading.value ||
                  !employeeController.isEmployeeDataReady.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (onlineWorkDayController.allOnlineWorkDays.isEmpty) {
                return const Center(
                    child: Text("Không có ngày làm việc online nào."));
              }

              return ListView(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: onlineWorkDayController.allOnlineWorkDays.length,
                    itemBuilder: (context, index) {
                      final onlineWorkDay =
                          onlineWorkDayController.allOnlineWorkDays[index];
                      return OnlineWorkDayTile(onlineWorkDay: onlineWorkDay);
                    },
                  ),
                  const OnlineWorkDayChart(),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
