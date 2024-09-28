import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/authentication/controllers/authentication_controller.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/features/over_time_management/controllers/format_time_controller.dart';
import 'package:hrm_aqtech/features/over_time_management/controllers/update_over_time_controller.dart';
import 'package:hrm_aqtech/features/over_time_management/models/over_time_model.dart';
import 'package:hrm_aqtech/features/over_time_management/views/over_time_detail/over_time_detail.dart';
import 'package:hrm_aqtech/features/over_time_management/views/over_time_view/over_time_view.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';

class OverTimeTile extends StatelessWidget {
  const OverTimeTile({super.key, required this.overTime});
  final OverTime overTime;

  @override
  Widget build(BuildContext context) {
    final employeeController = Get.put(EmployeeController());
    final updateOverTimeController = Get.put(UpdateOverTimeController());
    final employeeName =
        employeeController.getEmployeeNameById(overTime.memberId);
    final formatTimeController = Get.put(FormatTimeController());
    final isLeader = AuthenticationController.instance.currentUser.isLeader;
    return Slidable(
      enabled: isLeader,
      endActionPane: ActionPane(motion: const DrawerMotion(), children: [
        SlidableAction(
          onPressed: ((context) {
            updateOverTimeController.deleteOverTime(overTime.id.toString());
          }),
          backgroundColor: Colors.red,
          icon: Icons.delete,
          borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(MySizes.cardRadiusMd),
                bottomLeft: Radius.circular(MySizes.cardRadiusMd)),
        ),
        SlidableAction(
            onPressed: ((context) {
              updateOverTimeController.isEditting.value=true;
              Get.to(() => OverTimeDetailScreen(selectedOverTime: overTime));
                        }),
            backgroundColor: Colors.blue,
            icon: Icons.edit,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(MySizes.cardRadiusMd),
                bottomRight: Radius.circular(MySizes.cardRadiusMd)),
          ),

      ]),
      child: InkWell(
        onTap: () =>
            {Get.to(() => OverTimeViewScreen(selectedOverTime: overTime))},
        child: Container(
          margin:
              const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 8),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 2,
                  color: Color.fromARGB(255, 229, 225, 225),
                ),
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, top: 8, right: 16, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(TextSpan(
                        text: "Họ tên: ",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey),
                        children: [
                          TextSpan(
                              text: employeeName ?? 'Unknown',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey))
                        ])),
                    Text.rich(TextSpan(
                        text: "Ngày: ",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey),
                        children: [
                          TextSpan(
                              text: MyFormatter.formatDate(
                                  overTime.date.toString()),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey))
                        ])),

                    Text.rich(TextSpan(
                        text: "Số giờ: ",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey),
                        children: [
                          TextSpan(
                              text: formatTimeController
                                  .formatTimeController(overTime.time),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey))
                        ])),
                    const Divider(),
                    Text.rich(
                      TextSpan(
                          text: "Ghi chú: ",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                          children: [
                            TextSpan(
                                text: overTime.note,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey))
                          ]),
                      maxLines: 2,
                    ),
                    // Row(
                    //   children: [
                    //     const Icon(Icons.calendar_month_outlined),
                    //     Text(
                    //       MyFormatter.formatDate(overTime.date.toString()),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
