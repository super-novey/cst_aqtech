import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/leave_day_management/controllers/update_leave_day_controller.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:intl/intl.dart';

class DateTimePicker extends StatelessWidget {
  const DateTimePicker({
    super.key,
    required this.controller,
    required this.label,
  });

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {

    return Obx(
      () => Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              enabled: UpdateLeaveDayController.instance.isEditting.value,
              readOnly: true,
              decoration: InputDecoration(
                labelText: label,
                
                hintStyle: const TextStyle(color: Colors.grey),
                suffixIcon: const Icon(Icons.calendar_month_outlined, color: MyColors.primaryTextColor,),
              ),
              onTap: () {
                _selectDate(context, controller);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime initialDate = DateTime.now();
    if (controller.text.isNotEmpty) {
      try {
        initialDate = DateFormat('dd/MM/yyyy').parse(controller.text);
      } catch (e) {
        initialDate = DateTime.now(); // Nếu lỗi, chọn ngày hiện tại
      }
    }

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.teal, // Màu của ngày được chọn
            hintColor: Colors.teal, // Màu của các chi tiết phụ (ví dụ: viền quanh ngày)
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            dialogBackgroundColor: Colors.teal, // Màu nền của hộp thoại chọn ngày
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.teal, // Màu của các nút
              ),
            ),
            dividerColor: Colors.teal, // Màu của các đường phân cách
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      if (controller == UpdateLeaveDayController.instance.dateFromController ||
          controller == UpdateLeaveDayController.instance.dateToController) {
        UpdateLeaveDayController.instance.calculateSumDays();
      }
    }
  }
}
