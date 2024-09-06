import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/online_work_management/controllers/update_online_work_day_controller.dart';

class OnlineWorkDayTextFiled extends StatelessWidget {
  const OnlineWorkDayTextFiled({
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
              enabled: UpdateOnlineWorkDayController.instance.isEditting.value,
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
