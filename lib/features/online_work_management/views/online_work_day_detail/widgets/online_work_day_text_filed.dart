import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/online_work_management/controllers/update_online_work_day_controller.dart';

class OnlineWorkDayTextFiled extends StatelessWidget {
  const OnlineWorkDayTextFiled({
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
              enabled: UpdateOnlineWorkDayController.instance.isEditting.value,
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
