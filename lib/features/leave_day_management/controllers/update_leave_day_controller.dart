import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/data/leave_day/leave_day_repository.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/network_manager.dart';
import 'package:hrm_aqtech/features/leave_day_management/controllers/format_sum_day_controller.dart';
import 'package:hrm_aqtech/features/leave_day_management/models/leave_day_model.dart';
import 'package:hrm_aqtech/features/leave_day_management/views/leave_day_list/leave_day_list_screen.dart';
import 'package:hrm_aqtech/utils/constants/enums.dart';
import 'package:hrm_aqtech/utils/constants/image_paths.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/popups/full_screen_loader.dart';
import 'package:hrm_aqtech/utils/popups/loaders.dart';
import 'package:intl/intl.dart';

class UpdateLeaveDayController extends GetxController {
  static UpdateLeaveDayController get instance => Get.find();
  var isEditting = false.obs;
  var isAdd = false.obs;
  TextEditingController dateFromController = TextEditingController();
  TextEditingController dateToController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController sumDayController = TextEditingController();
  var isAnnual = false.obs;
  var isWithoutPay = false.obs;
  var selectedEmployee = Rxn<String>();
  var selectedApprovalStatus = ApprovalStatus.pending.obs;

  void toggleEditting() {
    isEditting.value = !isEditting.value;
    if (!isEditting.value) {
      isAdd.value = false;
    }
  }

  void toggle(int value) {
    switch (value) {
      case 0:
        isAnnual.value = !isAnnual.value;
        break;
      default:
        isWithoutPay.value = !isWithoutPay.value;
        break;
    }
  }

  void save(LeaveDay newLeaveDay, bool isAdd) async {
    try {
      FullScreenLoader.openDialog("Đang xử lý...", MyImagePaths.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      getLeaveDay(newLeaveDay);
      if (isAdd) {
        await LeaveDayRepository.instance.addLeaveDay(newLeaveDay);
        this.isAdd.value = false;
        Loaders.successSnackBar(
            title: "Thành công!", message: "Xin nghỉ phép thành công");
        Future.delayed(const Duration(seconds: 1), () {
          Get.offAll(() => const LeaveDayListScreen());
        });
      } else {
        await LeaveDayRepository.instance.updateLeaveDay(newLeaveDay);
        toggleEditting();
        Loaders.successSnackBar(
            title: "Thành công!", message: "Chỉnh sửa thành công");
        Future.delayed(const Duration(seconds: 1), () {
          Get.offAll(() => const LeaveDayListScreen());
        });
      }
    } catch (e) {
      Loaders.errorSnackBar(title: "Oops", message: e.toString());
    } finally {
      FullScreenLoader.stopLoading();
    }
  }

  void deleteLeaveDay(String id) {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(MySizes.md),
      title: "Chắc chắn xóa",
      middleText: "Bạn chắc chắn xóa ngày nghỉ này",
      confirm: ElevatedButton(
        onPressed: () async {
          await LeaveDayRepository.instance.deleteLeaveDay(id);
          Loaders.successSnackBar(
              title: "Thành công!", message: "Xóa thành công");
          Get.offAll(() => const LeaveDayListScreen());
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: const Text("Xóa"),
      ),
      cancel: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding:
              const EdgeInsets.symmetric(horizontal: MySizes.md, vertical: 0),
        ),
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text("Quay lại"),
      ),
    );
  }

  void approvalLeaveDay(String id, String approvalStatus) async {
    try {
      FullScreenLoader.openDialog("Đang xử lý...", MyImagePaths.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      await LeaveDayRepository.instance.approvalLeaveDay(id, approvalStatus);

      Loaders.successSnackBar(
        title: "Thành công!",
        message: "Duyệt ngày phép thành công",
      );

      Future.delayed(const Duration(seconds: 1), () {
        Get.offAll(() => const LeaveDayListScreen());
      });
    } catch (e) {
      Loaders.errorSnackBar(
        title: "Oops",
        message: e.toString(),
      );
    } finally {
      FullScreenLoader.stopLoading();
    }
  }

  void getLeaveDay(LeaveDay newLeaveDay) {
    newLeaveDay.dateFrom =
        DateFormat("dd/MM/yyyy").parse(dateFromController.text);
    newLeaveDay.dateTo = DateFormat("dd/MM/yyyy").parse(dateToController.text);
    newLeaveDay.reason = reasonController.text.toString().trim();
    newLeaveDay.note = noteController.text.toString().trim();
    newLeaveDay.sumDay = double.tryParse(sumDayController.text.trim()) ?? 0.0;
    newLeaveDay.isAnnual = isAnnual.value;
    newLeaveDay.isWithoutPay = isWithoutPay.value;
    newLeaveDay.approvalStatus = selectedApprovalStatus.value;
    newLeaveDay.memberId = int.tryParse(selectedEmployee.value ?? '') ?? 0;
  }

  void calculateSumDays() {
    DateTime? dateFrom =
        DateFormat('dd/MM/yyyy').parseStrict(dateFromController.text);
    DateTime? dateTo =
        DateFormat('dd/MM/yyyy').parseStrict(dateToController.text);

    int totalDays = 0;
    DateTime currentDate = dateFrom;

    while (
        currentDate.isBefore(dateTo) || currentDate.isAtSameMomentAs(dateTo)) {
      if (currentDate.weekday != DateTime.saturday &&
          currentDate.weekday != DateTime.sunday) {
        totalDays++;
      }
      currentDate = currentDate.add(const Duration(days: 1));
    }

    String formattedSumDay =
        FormatSumDayController().formatLeaveDay(totalDays.toDouble());
    sumDayController.text = formattedSumDay;
  }
}
