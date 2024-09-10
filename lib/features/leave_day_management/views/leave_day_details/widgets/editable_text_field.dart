import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/leave_day_management/controllers/update_leave_day_controller.dart';

class EditableTextField extends StatelessWidget {
  const EditableTextField({
    super.key,
    required this.textController,
    required this.label,
    this.isNumberInput = false,
  });

  final String label;
  final TextEditingController textController;
  final bool isNumberInput;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: textController,
              enabled: UpdateLeaveDayController.instance.isEditting.value,
              keyboardType: isNumberInput
                  ? const TextInputType.numberWithOptions(decimal: true)
                  : TextInputType.text,
              inputFormatters: isNumberInput
                  ? [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                    ] 
                  : [],
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
