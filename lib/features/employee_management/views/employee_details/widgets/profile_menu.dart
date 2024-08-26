import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/update_employee_controller.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
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
            child: TextField(
              controller: textController,
              enabled: (UpdateEmployeeController.instance.isEditting.value),
              decoration: InputDecoration(
                label: Text(
                  label,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
