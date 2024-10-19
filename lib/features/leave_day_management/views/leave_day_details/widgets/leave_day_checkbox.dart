import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/leave_day_management/controllers/update_leave_day_controller.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class LeaveDayCheckbox extends StatelessWidget {
  const LeaveDayCheckbox({
    super.key,
    required this.field,
  });

  final int field;

  @override
  Widget build(BuildContext context) {
    final controller = UpdateLeaveDayController.instance;
    return Obx(
      () => Checkbox(
        activeColor: MyColors.dartPrimaryColor,
        value: (field == 0)
            ? controller.isAnnual.value
            : (field == 1)
                ? controller.isWithoutPay.value
                : false,
        onChanged: (controller.isEditting.value)
            ? (value) {
                controller.toggle(field);
              }
            : null, // Disable interaction if not editing
      ),
    );
  }
}
