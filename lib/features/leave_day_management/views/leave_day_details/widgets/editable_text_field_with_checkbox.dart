import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/leave_day_management/controllers/update_leave_day_controller.dart';
import 'package:hrm_aqtech/features/leave_day_management/views/leave_day_details/widgets/leave_day_checkbox.dart';

class EditableTextFieldWithCheckbox extends StatelessWidget {
  const EditableTextFieldWithCheckbox({
    super.key,
    required this.textController,
    required this.label,
    this.isNumberInput = false,
    required this.field,
  });

  final String label;
  final TextEditingController textController;
  final bool isNumberInput;
  final int field;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Align the checkbox properly
        children: [
          Expanded(
            child: TextFormField(
              controller: textController,
              enabled: UpdateLeaveDayController.instance.isEditting.value,
              keyboardType: isNumberInput
                  ? const TextInputType.numberWithOptions(decimal: true)
                  : TextInputType.text,
              inputFormatters: isNumberInput
                  ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))]
                  : [],
              decoration: InputDecoration(
                labelText: label,
                hintStyle: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
          LeaveDayCheckbox(
            field: field,
          ),
        ],
      ),
    );
  }
}
