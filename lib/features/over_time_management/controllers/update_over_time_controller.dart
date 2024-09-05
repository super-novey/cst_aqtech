import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/data/over_time/over_time_repository.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/network_manager.dart';
import 'package:hrm_aqtech/features/over_time_management/models/over_time_model.dart';
import 'package:hrm_aqtech/features/over_time_management/views/over_time_list/over_time_list_screen.dart';
import 'package:hrm_aqtech/utils/constants/image_paths.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/popups/full_screen_loader.dart';
import 'package:hrm_aqtech/utils/popups/loaders.dart';
import 'package:intl/intl.dart';

class UpdateOverTimeController extends GetxController {
  static UpdateOverTimeController get instance => Get.find();
  var isEditting = false.obs;
  var isAdd = false.obs;
  TextEditingController dateController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  var selectedEmployee = Rxn<String>();

  void toggleEditting() {
    isEditting.value = !isEditting.value;
    if (!isEditting.value) {
      isAdd.value = false;
    }
  }

  void save(OverTime newOverTime, bool isAdd) async {
    try {
      FullScreenLoader.openDialog("Đang xử lý...", MyImagePaths.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      getOverTime(newOverTime);
      if (isAdd) {
        await OverTimeRepository.instance.addOverTime(newOverTime);
        this.isAdd.value = false;
        Loaders.successSnackBar(
            title: "Thành công!",
            message: "Thêm thời gian làm việc thành công");
        Future.delayed(const Duration(seconds: 1), () {
          Get.offAll(() => const OverTimeListScreen());
        });
      } else {
        await OverTimeRepository.instance.updateOverTime(newOverTime);
        toggleEditting();
        Loaders.successSnackBar(
            title: "Thành công!", message: "Chỉnh sửa thành công");
        Future.delayed(const Duration(seconds: 1), () {
          Get.offAll(() => const OverTimeListScreen());
        });
      }
    } catch (e) {
      Loaders.errorSnackBar(title: "Oops", message: e.toString());
    } finally {
      FullScreenLoader.stopLoading();
    }
  }

  void deleteOverTime(String id) {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(MySizes.md),
      title: "Chắc chắn xóa",
      middleText: "Bạn chắc chắn xóa ngày làm việc ngoài giờ này",
      confirm: ElevatedButton(
        onPressed: () async {
          await OverTimeRepository.instance.deleteOverTime(id);
          Loaders.successSnackBar(
              title: "Thành công!", message: "Xóa thành công");
          Get.offAll(() => const OverTimeListScreen());
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

  void getOverTime(OverTime newOverTime) {
    newOverTime.date = DateFormat("dd/MM/yyyy").parse(dateController.text);
    newOverTime.note = noteController.text.toString().trim();
    newOverTime.time = double.tryParse(timeController.text.trim()) ?? 0;
    newOverTime.memberId = int.tryParse(selectedEmployee.value ?? '') ?? 0;
  }
}
