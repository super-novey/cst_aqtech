import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/over_time_management/controllers/update_over_time_controller.dart';

class OverTimeTextFiled extends StatelessWidget {
  const OverTimeTextFiled({
    super.key,
    required this.textController,
    required this.label,
    this.maxLines = 1,
  });

  final String label;
  final TextEditingController textController;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: textController,
              enabled: UpdateOverTimeController.instance.isEditting.value,
              maxLines: maxLines,
              decoration: InputDecoration(
                labelText: label,
                alignLabelWithHint: true,
                hintStyle: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
