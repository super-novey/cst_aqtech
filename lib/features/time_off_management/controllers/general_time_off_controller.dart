import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/data/time_off/time_off_repository.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/network_manager.dart';
import 'package:hrm_aqtech/features/time_off_management/controllers/date_time_picker_controller.dart';
import 'package:hrm_aqtech/features/time_off_management/models/general_time_off_model.dart';
import 'package:hrm_aqtech/utils/constants/image_paths.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/popups/full_screen_loader.dart';
import 'package:hrm_aqtech/utils/popups/loaders.dart';

class GeneralTimeOffController extends GetxController {
  final isLoading = false.obs;

  static GeneralTimeOffController get instance => Get.find();
  final _timeOffRepository = Get.put(GeneralTimeOffRepository());

  List<GeneralTimeOff> generalTimeOffs = <GeneralTimeOff>[].obs;

  @override
  void onInit() {
    fetchGeneralTimeOffs();
    super.onInit();
  }

  Future<void> fetchGeneralTimeOffs() async {
    try {
      isLoading.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      final timeOffs = await _timeOffRepository.getAllGeneralTimeOffs(
        DateTimePickerController.instance.startDate.value,
        DateTimePickerController.instance.endDate.value,
      );
      generalTimeOffs.assignAll(timeOffs);
    } catch (_) {
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateGeneralTimeOff(GeneralTimeOff timeOff) async {
    try {
      isLoading.value = true;
      await _timeOffRepository.updateGeneralTimeOff(timeOff);
      await fetchGeneralTimeOffs();
      Loaders.successSnackBar(
          title: "Thành công!", message: "Chỉnh sửa ngày nghỉ thành công");
    } catch (_) {
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> delete(int id) async {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(MySizes.md),
        title: "Xóa ngày nghỉ",
        middleText: "Bạn có chắc muốn xóa ngày nghỉ này không?",
        confirm: ElevatedButton(
            onPressed: () async {
              await _timeOffRepository.deleteTimeOff(id);
              await fetchGeneralTimeOffs();
              Loaders.successSnackBar(
                  title: "Thành công!", message: "Xóa ngày nghỉ thành công");

              Navigator.of(Get.overlayContext!).pop();
            },
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                backgroundColor: Colors.red,
                side: const BorderSide(color: Colors.red)),
            child: const Text("Xóa")),
        cancel: OutlinedButton(
            style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: MySizes.md, vertical: 0)),
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: const Text("Quay lại")));
  }

  Future<void> createTimeOff(GeneralTimeOff timeOff) async {
    try {
      FullScreenLoader.openDialog("Đang xử lý...", MyImagePaths.docerAnimation);
      isLoading.value = true;
      await _timeOffRepository.createGeneralTimeOff(timeOff);
      await fetchGeneralTimeOffs();
      Get.back();
    } catch (_) {
    } finally {
      isLoading.value = false;
    }
  }
}
