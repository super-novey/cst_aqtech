import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/data/online_work/online_work_day_repository.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/network_manager.dart';
import 'package:hrm_aqtech/features/online_work_management/controllers/format_sum_day_controller.dart';
import 'package:hrm_aqtech/features/online_work_management/models/online_work_day_model.dart';
import 'package:hrm_aqtech/features/online_work_management/views/online_work_day_list/online_work_day_list_screen.dart';
import 'package:hrm_aqtech/utils/constants/enums.dart';
import 'package:hrm_aqtech/utils/constants/image_paths.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/popups/full_screen_loader.dart';
import 'package:hrm_aqtech/utils/popups/loaders.dart';
import 'package:intl/intl.dart';

class UpdateOnlineWorkDayController extends GetxController {
  static UpdateOnlineWorkDayController get instance => Get.find();
  var isEditting = false.obs;
  var isAdd = false.obs;
  TextEditingController dateFromController = TextEditingController();
  TextEditingController dateToController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController sumDayController = TextEditingController();
  var selectedEmployee = Rxn<String>();
  var selectedApprovalStatus = ApprovalStatus.pending.obs;

  void toggleEditting() {
    isEditting.value = !isEditting.value;
    if (!isEditting.value) {
      isAdd.value = false;
    }
  }

  void save(OnlineWork newOnlineWorkDay, bool isAdd) async {
    try {
      FullScreenLoader.openDialog("Đang xử lý...", MyImagePaths.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      getOnlineWorkDay(newOnlineWorkDay);
      if (isAdd) {
        await OnlineWorkDayRepository.instance.addOnlineWork(newOnlineWorkDay);
        this.isAdd.value = false;
        Loaders.successSnackBar(
            title: "Thành công!",
            message: "Xin phép làm việc online thành công");
        Future.delayed(const Duration(seconds: 1), () {
          Get.offAll(() => const OnlineWorkDayListScreen());
        });
      } else {
        await OnlineWorkDayRepository.instance
            .updateOnlineWork(newOnlineWorkDay);
        toggleEditting();
        Loaders.successSnackBar(
            title: "Thành công!", message: "Chỉnh sửa thành công");
        Future.delayed(const Duration(seconds: 1), () {
          Get.offAll(() => const OnlineWorkDayListScreen());
        });
      }
    } catch (e) {
      Loaders.errorSnackBar(title: "Oops", message: e.toString());
    } finally {
      FullScreenLoader.stopLoading();
    }
  }

  void deleteOnlineWorkDay(String id) {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(MySizes.md),
      title: "Chắc chắn xóa",
      middleText: "Bạn chắc chắn xóa ngày làm việc online này",
      confirm: ElevatedButton(
        onPressed: () async {
          await OnlineWorkDayRepository.instance.deleteOnlineWork(id);
          Loaders.successSnackBar(
              title: "Thành công!", message: "Xóa thành công");
          Get.offAll(() => const OnlineWorkDayListScreen());
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

  void getOnlineWorkDay(OnlineWork newOnlineWorkDay) {
    newOnlineWorkDay.dateFrom =
        DateFormat("dd/MM/yyyy").parse(dateFromController.text);
    newOnlineWorkDay.dateTo =
        DateFormat("dd/MM/yyyy").parse(dateToController.text);
    newOnlineWorkDay.reason = reasonController.text.toString().trim();
    newOnlineWorkDay.note = noteController.text.toString().trim();
    newOnlineWorkDay.sumDay =
        double.tryParse(sumDayController.text.trim()) ?? 0.0;
    newOnlineWorkDay.approvalStatus = selectedApprovalStatus.value;
    newOnlineWorkDay.memberId = int.tryParse(selectedEmployee.value ?? '') ?? 0;
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

    String formattedSumDay = FormatSumDayOnlineWorkController()
        .formatOnlineWorkDay(totalDays.toDouble());
    sumDayController.text = formattedSumDay;
  }

  void approvalOnlineWorkDay(String id, String approvalStatus) async {
    try {
      FullScreenLoader.openDialog("Đang xử lý...", MyImagePaths.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      await OnlineWorkDayRepository.instance.approvalOnlineWorkDay(id, approvalStatus);

      Loaders.successSnackBar(
        title: "Thành công!",
        message: "Trạng thái ngày phép đã được cập nhật thành công",
      );

      Future.delayed(const Duration(seconds: 1), () {
        Get.offAll(() => const OnlineWorkDayListScreen());
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
}
