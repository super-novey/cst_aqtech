import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/time_off_management/controllers/time_off_editable_text_field_controller.dart';
import 'package:hrm_aqtech/features/time_off_management/models/general_time_off_model.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:intl/intl.dart';

class GeneralTimeOffDetailScreen extends StatelessWidget {
  const GeneralTimeOffDetailScreen({super.key, required this.generalTimeOff});

  final GeneralTimeOff generalTimeOff;

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(TimeOffEditableTextFieldController(generalTimeOff));
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy'); // Date format

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết ngày nghỉ'),
        centerTitle: true,
        backgroundColor: MyColors.primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios, // Your custom back icon here
            color: Colors.white,
            size: 24,
          ),
          onPressed: () {
            Get.back(); // Navigate back
          },
        ),
        actions: [
          Obx(() {
            return IconButton(
              icon: Icon(
                controller.isEditing.value ? Icons.save : Icons.edit,
                color: Colors.white,
                size: 24,
              ),
              onPressed: () async {
                if (controller.isEditing.value) {
                  await controller.saveChanges();
                } else {
                  controller.toggleEditing();
                }
              },
            );
          }),
        ],
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Ngày bắt đầu',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                _buildDatePicker(
                  context: context,
                  label: 'Từ ngày',
                  selectedDate: controller.dateFrom.value,
                  isEditing: controller.isEditing.value,
                  onDateSelected: (date) {
                    controller.dateFrom.value = date;
                    controller.dateFromController.text =
                        dateFormat.format(date);
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Ngày kết thúc',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                _buildDatePicker(
                  context: context,
                  label: 'Đến ngày',
                  selectedDate: controller.dateTo.value,
                  isEditing: controller.isEditing.value,
                  onDateSelected: (date) {
                    controller.dateTo.value = date;
                    controller.dateToController.text = dateFormat.format(date);
                  },
                ),
                _buildTextField(
                  controller: controller.sumDayController,
                  label: 'Số ngày nghỉ',
                  isEditing: controller.isEditing,
                ),
                _buildTextField(
                  controller: controller.reasonController,
                  label: 'Lý do nghỉ',
                  isEditing: controller.isEditing,
                ),
                _buildTextField(
                  controller: controller.noteController,
                  label: 'Ghi chú',
                  isEditing: controller.isEditing,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required RxBool isEditing,
  }) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          TextField(
            controller: controller,
            enabled: isEditing.value,
            decoration: InputDecoration(
              hintText: label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black, width: 1),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black, width: 1),
              ),
              suffixIcon: isEditing.value
                  ? const Icon(
                      Icons.edit) // Optional: Add a suffix icon if editing
                  : null,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildDatePicker({
    required BuildContext context,
    required String label,
    required DateTime selectedDate,
    required bool isEditing,
    required Function(DateTime) onDateSelected,
  }) {
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

    return GestureDetector(
      onTap: isEditing
          ? () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );

              if (pickedDate != null) {
                onDateSelected(pickedDate);
              }
            }
          : null,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isEditing)
                Text(
                  dateFormat.format(selectedDate), // Format the date
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              if (!isEditing)
                Text(
                  dateFormat.format(selectedDate), // Format the date
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              if (isEditing) const Icon(Icons.calendar_month_outlined),
            ],
          ),
        ),
      ),
    );
  }
}
