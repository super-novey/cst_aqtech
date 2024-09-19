import 'package:flutter/material.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:intl/intl.dart';

class ChooseDateWidget extends StatelessWidget {
  const ChooseDateWidget({
    super.key,
    required this.controller,
    required this.label,
  });

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    if (controller.text.isEmpty) {
      controller.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    }

    return Row(
      children: [
        SizedBox(
          width: 150,
          height: 50,
          child: TextFormField(
            controller: controller,
            readOnly: true,
            decoration: InputDecoration(
              hintStyle: const TextStyle(color: MyColors.secondaryTextColor),
              suffixIcon: const Icon(
                Icons.calendar_month_rounded,
                color: Colors.black,
              ),
              labelText: label,
              labelStyle: const TextStyle(color: Colors.black),
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                    color: MyColors.secondaryTextColor, width: 0.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                    color: MyColors.secondaryTextColor, width: 0.5),
              ),
            ),
            onTap: () {
              _selectDate(context, controller);
            },
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime initialDate = DateTime.now();
    if (controller.text.isNotEmpty) {
      try {
        initialDate = DateFormat('dd/MM/yyyy').parse(controller.text);
      } catch (e) {
        initialDate = DateTime.now();
      }
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
