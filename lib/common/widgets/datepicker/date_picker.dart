import 'package:flutter/material.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/update_employee_controller.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({super.key, required this.controler, required this.label});

  final TextEditingController controler;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Obx(
       () => Row(
        children: [
          Expanded(
            child: TextField(
              controller: controler,
              enabled: (UpdateEmployeeController.instance.isEditting.value),
              readOnly: true,
              decoration: InputDecoration(
                label: Text(
                  label,
                  style: Theme.of(context).textTheme.headlineSmall,
                  
                ),
                suffixIcon: const Icon(Icons.calendar_month_outlined, color: MyColors.primaryTextColor,),
              ),
              onTap: () {
                _selectDate(context, controler);
              },
            ),
          ),
        ],
      ),
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
