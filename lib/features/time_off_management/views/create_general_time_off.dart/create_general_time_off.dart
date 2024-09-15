import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/time_off_management/controllers/time_off_editable_text_field_controller.dart';
import 'package:hrm_aqtech/features/time_off_management/models/general_time_off_model.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:intl/intl.dart';

class CreateGeneralTimeOffScreen extends StatelessWidget {
  const CreateGeneralTimeOffScreen({super.key, required this.generalTimeOff});

  final GeneralTimeOff generalTimeOff;

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(TimeOffEditableTextFieldController(generalTimeOff));
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy'); // Date format

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tạo ngày nghỉ chung',
          overflow: TextOverflow.ellipsis, // Handle long text
        ),
        backgroundColor: MyColors.primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 24,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.save,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () async {
              await controller.saveToCreate();
              Get.snackbar(
                'Tạo thành công',
                'Đã tạo ngày nghỉ mới.',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          )
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
                    "Ngày bắt dầu",
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
                  onDateSelected: (date) {
                    controller.dateFrom.value = date;
                    controller.dateFromController.text =
                        dateFormat.format(date);
                  },
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Ngày kết thúc",
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
                  onDateSelected: (date) {
                    controller.dateTo.value = date;
                    controller.dateToController.text = dateFormat.format(date);
                  },
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: controller.sumDayController,
                  label: 'Số ngày nghỉ',
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: controller.reasonController,
                  label: 'Lý do nghỉ',
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: controller.noteController,
                  label: 'Ghi chú',
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
  }) {
    return Card(
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        elevation: 4,
        semanticContainer: true,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white, width: 1),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white, width: 1),
            ),
          ),
        ));
  }

  Widget _buildDatePicker({
    required BuildContext context,
    required String label,
    required DateTime selectedDate,
    required Function(DateTime) onDateSelected,
  }) {
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );

        if (pickedDate != null) {
          onDateSelected(pickedDate);
        }
      },
      child: Card(
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        elevation: 4,
        semanticContainer: true,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateFormat.format(selectedDate), // Format the date
                style: const TextStyle(fontSize: 16),
              ),
              const Icon(Icons.calendar_month_outlined),
            ],
          ),
        ),
      ),
    );
  }
}
