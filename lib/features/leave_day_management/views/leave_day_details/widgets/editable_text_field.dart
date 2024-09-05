import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/leave_day_management/controllers/update_leave_day_controller.dart';

class EditableTextField extends StatelessWidget {
  const EditableTextField({
    super.key,
    required this.textController,
    required this.label,
  });

  final String label;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: textController,
              enabled: UpdateLeaveDayController.instance.isEditting.value,
              decoration: InputDecoration(
                labelText: label,
                hintStyle: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
