import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/features/over_time_management/controllers/over_time_controller.dart';
import 'package:hrm_aqtech/features/over_time_management/controllers/update_over_time_controller.dart';
import 'package:hrm_aqtech/features/over_time_management/models/over_time_model.dart';
import 'package:hrm_aqtech/features/over_time_management/views/over_time_detail/over_time_detail.dart';
import 'package:hrm_aqtech/features/over_time_management/views/over_time_list/widgets/date_range_over_time_widget.dart';
import 'package:hrm_aqtech/features/over_time_management/views/over_time_list/widgets/over_time_tile.dart';
import 'package:hrm_aqtech/features/over_time_management/views/over_time_list/widgets/over_time_work.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class OverTimeListScreen extends StatelessWidget {
  const OverTimeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final overTimeController = Get.put(OverTimeController());
    final employeeController = Get.put(EmployeeController());
    final updateOverTimeController = Get.put(UpdateOverTimeController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text("Ngày làm việc ngoài giờ"),
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
              updateOverTimeController.isAdd.value = true;
              updateOverTimeController.toggleEditting();
              Get.to(() => OverTimeDetailScreen(
                    selectedOverTime: OverTime(),
                  ));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: const DateRangeOverTimeWidget(),
          ),
          const Divider(),
          Expanded(
            child: Obx(() {
              if (overTimeController.isLoading.value ||
                  !employeeController.isEmployeeDataReady.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (overTimeController.allOverTime.isEmpty) {
                return const Center(
                    child: Text("Không có thời gian làm việc ngoài giờ nào."));
              }

              return ListView(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: overTimeController.allOverTime.length,
                    itemBuilder: (context, index) {
                      final overTime = overTimeController.allOverTime[index];
                      return OverTimeTile(overTime: overTime);
                    },
                  ),
                  const OvertimeWorkChart(),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
