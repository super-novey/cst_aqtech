import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/authentication/controllers/authentication_controller.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/features/online_work_management/controllers/format_sum_day_controller.dart';
import 'package:hrm_aqtech/features/online_work_management/controllers/update_online_work_day_controller.dart';
import 'package:hrm_aqtech/features/online_work_management/models/online_work_day_model.dart';
import 'package:hrm_aqtech/features/online_work_management/views/approval_online_work_day/approval_online_work_day.dart';
import 'package:hrm_aqtech/features/online_work_management/views/online_work_day_detail/online_work_day_detail.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';
import 'package:hrm_aqtech/utils/helpers/hepler_function.dart';

class OnlineWorkDayTile extends StatelessWidget {
  const OnlineWorkDayTile({super.key, required this.onlineWorkDay});
  final OnlineWork onlineWorkDay;

  @override
  Widget build(BuildContext context) {
    final employeeController = Get.put(EmployeeController());
    final formatDayController = Get.put(FormatSumDayOnlineWorkController());
    final formattedSumDay =
        formatDayController.formatOnlineWorkDay(onlineWorkDay.sumDay);
    final updateOnlineWorkDayController =
        Get.put(UpdateOnlineWorkDayController());
    final approvalStatus = onlineWorkDay.approvalStatus; // Đã sửa lại
    final approvalStatusString =
        HeplerFunction.convertEnumToString(approvalStatus);
    final employeeName =
        employeeController.getEmployeeNameById(onlineWorkDay.memberId);
    final isLeader = AuthenticationController.instance.currentUser.isLeader;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        enabled: isLeader,
        endActionPane: ActionPane(motion: const DrawerMotion(), children: [
          SlidableAction(
            onPressed: ((context) {
              updateOnlineWorkDayController
                  .deleteOnlineWorkDay(onlineWorkDay.id.toString());
            }),
            backgroundColor: Colors.red,
            icon: Icons.delete,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(MySizes.cardRadiusMd),
                bottomLeft: Radius.circular(MySizes.cardRadiusMd)),
          ),
          SlidableAction(
            onPressed: ((context) {
              Get.to(() => OnlineWorkDayDetailScreen(
                  selectedOnlineWorkDay: onlineWorkDay));
            }),
            backgroundColor: Colors.blue,
            icon: Icons.edit,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(MySizes.cardRadiusMd),
                bottomRight: Radius.circular(MySizes.cardRadiusMd)),
          ),
        ]),
        child: InkWell(
          onTap: () => {
            Get.to(() => ApprovalOnlineWorkDayScreen(
                selectedOnlineWorkDay: onlineWorkDay))
          },
          child: Container(
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
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: HeplerFunction.getStatusColor(approvalStatus),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        approvalStatusString,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      HeplerFunction.getStatusIcon(approvalStatus),
                    ],
                  ),
                ),
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
                          text: "Lý do nghỉ: ",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                          children: [
                            TextSpan(
                                text: onlineWorkDay.reason,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey))
                          ])),
                      Text.rich(TextSpan(
                          text: "Số ngày nghỉ: ",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                          children: [
                            TextSpan(
                                text: formattedSumDay,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey))
                          ])),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.calendar_month_outlined),
                              Text(
                                MyFormatter.formatDate(
                                    onlineWorkDay.dateFrom.toString()),
                              ),
                            ],
                          ),
                          const Icon(Icons.arrow_right_alt_outlined),
                          Row(
                            children: [
                              const Icon(Icons.calendar_month_outlined),
                              Text(
                                MyFormatter.formatDate(
                                    onlineWorkDay.dateTo.toString()),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
