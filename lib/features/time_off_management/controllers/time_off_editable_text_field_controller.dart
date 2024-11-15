import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/time_off_management/controllers/general_time_off_controller.dart';
import 'package:hrm_aqtech/features/time_off_management/models/general_time_off_model.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';
import 'package:hrm_aqtech/utils/popups/loaders.dart';
import 'package:intl/intl.dart';

class TimeOffEditableTextFieldController extends GetxController {
  TimeOffEditableTextFieldController(this.generalTimeOff, this.isCreate);

  final GeneralTimeOff generalTimeOff;
  final bool isCreate;

  var dateFrom = Rx<DateTime>(DateTime.now());
  var dateTo = Rx<DateTime>(DateTime.now());
  var sumDay = Rx<double>(0.0);

  var isEditing = false.obs;

  final reasonController = TextEditingController();
  final noteController = TextEditingController();
  final dateFromController = TextEditingController();
  final dateToController = TextEditingController();
  final sumDayController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    reasonController.text = generalTimeOff.reason;
    noteController.text = generalTimeOff.note;
    dateFromController.text =
        DateFormat('dd/MM/yyyy').format(generalTimeOff.dateFrom);
    dateToController.text =
        DateFormat('dd/MM/yyyy').format(generalTimeOff.dateTo);

    sumDayController.text = MyFormatter.formatDouble(generalTimeOff.sumDay);
    dateFrom.value = generalTimeOff.dateFrom;
    dateTo.value = generalTimeOff.dateTo;

    if (isCreate) {
      _updateSumDay();
    }

    dateFrom.listen((_) => _updateSumDay());
    dateTo.listen((_) => _updateSumDay());
  }

  Future<void> saveChanges() async {
    generalTimeOff.dateFrom = dateFrom.value;
    generalTimeOff.dateTo = dateTo.value;
    generalTimeOff.sumDay = double.parse(sumDayController.text);
    generalTimeOff.reason = reasonController.text;
    generalTimeOff.note = noteController.text;

    await GeneralTimeOffController.instance
        .updateGeneralTimeOff(generalTimeOff);
    toggleEditing();
  }

  void toggleEditing() {
    isEditing.value = !isEditing.value;
  }

  void _updateSumDay() {
    double count = 0.0;
    DateTime startDate = dateFrom.value;
    DateTime endDate = dateTo.value;

    while (startDate.isBefore(endDate) || startDate.isAtSameMomentAs(endDate)) {
      if (startDate.weekday != DateTime.saturday &&
          startDate.weekday != DateTime.sunday) {
        count++;
      }
      startDate = startDate.add(const Duration(days: 1));
    }
    sumDay.value = count;
    sumDayController.text = MyFormatter.formatDouble(sumDay.value);
  }

  Future<void> saveToCreate() async {
    generalTimeOff.dateFrom = dateFrom.value;
    generalTimeOff.dateTo = dateTo.value;
    generalTimeOff.sumDay = double.parse(sumDayController.text);
    generalTimeOff.reason = reasonController.text;
    generalTimeOff.note = noteController.text;

    await GeneralTimeOffController.instance.createTimeOff(generalTimeOff);
    Get.back();
    Loaders.successSnackBar(
        title: "Thành công!", message: "Tạo ngày nghỉ thành công");
  }
}
