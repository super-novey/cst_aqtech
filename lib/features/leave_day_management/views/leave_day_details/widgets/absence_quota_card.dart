import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/leave_day_management/controllers/leave_day_controller.dart';
import 'package:hrm_aqtech/features/leave_day_management/controllers/update_leave_day_controller.dart';
import 'package:hrm_aqtech/features/leave_day_management/models/absence_quota_model.dart';

class AbsenceQuotaCard extends StatelessWidget {
  const AbsenceQuotaCard({super.key});

  @override
  Widget build(BuildContext context) {
    LeaveDayController controller = Get.find();
    var year = DateTime.now().year;
    int memberId =
        int.parse(UpdateLeaveDayController.instance.selectedEmployee.value!);

    controller.getAbsenceQuota(year, memberId);

    return Obx(() {
      AbsenceQuota absenceQuota = controller.absenceQuota.value;

      return Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'Hạn mức nghỉ phép cá nhân',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
              Center(
                child: Text(
                  'năm ${absenceQuota.year}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
              _buildDetailRow('Hạn mức nghỉ phép',
                  absenceQuota.absenceQuota.toString(), true),
              _buildDetailRow('Tổng ngày đã nghỉ',
                  absenceQuota.totalDayOff.toString(), true),
              _buildDetailRow('Tổng ngày đã nghỉ có phép',
                  absenceQuota.totalDayOffWithPermission.toString(), true),
              _buildDetailRow('Tổng ngày đã nghỉ không phép',
                  absenceQuota.totalDayOffWithoutPermission.toString(), false),
              _buildDetailRow('Hạn mức còn lại',
                  absenceQuota.absenceQuotaAvailable.toString(), true),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildDetailRow(String title, String value, bool isGood) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 80),
          Container(
            decoration: BoxDecoration(
              color: isGood
                  ? Colors.blue.withOpacity(0.2)
                  : Colors.red.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: 12.0, vertical: 4.0), // Added vertical padding
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: isGood ? Colors.blue : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
