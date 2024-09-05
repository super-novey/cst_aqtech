import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/features/leave_day_management/controllers/leave_day_controller.dart';
import 'package:hrm_aqtech/features/leave_day_management/controllers/update_leave_day_controller.dart';
import 'package:hrm_aqtech/features/leave_day_management/models/leave_day_model.dart';
import 'package:hrm_aqtech/features/leave_day_management/views/leave_day_details/leave_day_detail.dart';
import 'package:hrm_aqtech/features/leave_day_management/views/leave_day_list/widgets/date_range_widget.dart';
import 'package:hrm_aqtech/features/leave_day_management/views/leave_day_list/widgets/leave_day_chart.dart';
import 'package:hrm_aqtech/features/leave_day_management/views/leave_day_list/widgets/leave_day_tile.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class LeaveDayListScreen extends StatelessWidget {
  const LeaveDayListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final leaveDayController = Get.put(LeaveDayController());
    final employeeController = Get.put(EmployeeController());
    final updateLeaveDayController = Get.put(UpdateLeaveDayController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text("Ngày nghỉ phép cá nhân"),
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
              updateLeaveDayController.isAdd.value = true;
              updateLeaveDayController.toggleEditting();
              Get.to(() => LeaveDayDetailScreen(
                    selectedLeaveDay: LeaveDay(),
                  ));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: const DateRangeWidget(),
          ),
          const Divider(),
          Expanded(
            child: Obx(() {
              if (leaveDayController.isLoading.value ||
                  !employeeController.isEmployeeDataReady.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (leaveDayController.allLeaveDays.isEmpty) {
                return const Center(child: Text("Không có ngày nghỉ nào."));
              }

              return ListView(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: leaveDayController.allLeaveDays.length,
                    itemBuilder: (context, index) {
                      final leaveDay = leaveDayController.allLeaveDays[index];
                      return LeaveDayTile(leaveDay: leaveDay);
                    },
                  ),
                  const LeaveDayChart(),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
