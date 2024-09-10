import 'package:flutter/material.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/update_employee_controller.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({super.key, required this.controler, required this.label});

  final TextEditingController controler;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _selectDate(context, controler),
            child: AbsorbPointer(
              child: TextField(
                controller: controler,
                enabled: (UpdateEmployeeController.instance.isEditting.value),
                decoration: InputDecoration(
                  label: Text(
                    label,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime initialDate = DateTime.now();
    if (controller.text.isNotEmpty) {
      initialDate = DateFormat('dd/MM/yyyy').parse(controller.text);
    }

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    }
  }
}
