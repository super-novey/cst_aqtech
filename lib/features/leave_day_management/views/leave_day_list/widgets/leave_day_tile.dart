import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/features/leave_day_management/controllers/format_sum_day_controller.dart';
import 'package:hrm_aqtech/features/leave_day_management/controllers/update_leave_day_controller.dart';
import 'package:hrm_aqtech/features/leave_day_management/models/leave_day_model.dart';
import 'package:hrm_aqtech/features/leave_day_management/views/approval_leave_day/approval_leave_day.dart';
import 'package:hrm_aqtech/features/leave_day_management/views/leave_day_details/leave_day_detail.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';
import 'package:hrm_aqtech/utils/helpers/hepler_function.dart';

class LeaveDayTile extends StatelessWidget {
  const LeaveDayTile({super.key, required this.leaveDay});
  final LeaveDay leaveDay;

  @override
  Widget build(BuildContext context) {
    final employeeController = Get.put(EmployeeController());
    final formatDayController = Get.put(FormatSumDayController());
    final formattedSumDay = formatDayController.formatLeaveDay(leaveDay.sumDay);
    final updateLeaveDayController = Get.put(UpdateLeaveDayController());
    final approvalStatus = leaveDay.approvalStatus; // Đã sửa lại
    final approvalStatusString =
        HeplerFunction.convertEnumToString(approvalStatus);
    final employeeName =
        employeeController.getEmployeeNameById(leaveDay.memberId);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: ((context) {
                updateLeaveDayController.deleteLeaveDay(leaveDay.id.toString());
              }),
              backgroundColor: Colors.red,
              icon: Icons.delete,
              borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(MySizes.cardRadiusMd),
                    bottomLeft: Radius.circular(MySizes.cardRadiusMd)),
                    
            ),
            SlidableAction(
              onPressed: ((context) {
                updateLeaveDayController.isEditting.value = true;
                Get.to(() => LeaveDayDetailScreen(selectedLeaveDay: leaveDay));
              }),
              backgroundColor: Colors.blue,
              icon: Icons.edit,
              borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(MySizes.cardRadiusMd),
                    bottomRight: Radius.circular(MySizes.cardRadiusMd)),
            ),
          ],
        ),
        child: InkWell(
          onTap: () =>
              {Get.to(() => ApprovalLeaveDayScreen(selectedLeaveDay: leaveDay))},
          child: Container(
            // margin:
            //     const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 8),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                                text: leaveDay.reason,
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
                                    leaveDay.dateFrom.toString()),
                              ),
                            ],
                          ),
                          const Icon(Icons.arrow_right_alt_outlined),
                          Row(
                            children: [
                              const Icon(Icons.calendar_month_outlined),
                              Text(
                                MyFormatter.formatDate(
                                    leaveDay.dateTo.toString()),
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
