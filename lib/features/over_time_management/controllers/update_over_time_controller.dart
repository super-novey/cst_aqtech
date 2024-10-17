import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/data/over_time/over_time_repository.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/network_manager.dart';
import 'package:hrm_aqtech/features/employee_management/models/employee_model.dart';
import 'package:hrm_aqtech/features/over_time_management/controllers/format_time_controller.dart';
import 'package:hrm_aqtech/features/over_time_management/controllers/over_time_controller.dart';
import 'package:hrm_aqtech/features/over_time_management/models/over_time_model.dart';
import 'package:hrm_aqtech/utils/constants/image_paths.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';
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
  final RxString searchQuery = ''.obs;
  RxList<Employee> filteredEmployees = <Employee>[].obs;

  @override
  void onClose() {
    super.onClose();
    searchQuery.value = '';
    selectedEmployee.value = '';
  }

  void fetchOverTimeDetails(
      OverTime selectedOverTime, List<Employee> allEmployees) {
    dateController.text =
        MyFormatter.formatDate(selectedOverTime.date.toString());
    noteController.text = selectedOverTime.note;
    timeController.text =
        FormatTimeController().formatTimeController(selectedOverTime.time);

    String selectedEmployeeId = selectedOverTime.memberId.toString();
    final allEmployeeIds = allEmployees.map((e) => e.id.toString()).toSet();

    if (allEmployeeIds.contains(selectedEmployeeId)) {
      selectedEmployee.value = selectedEmployeeId;
    } else {
      selectedEmployee.value = null;
    }

    // Initialize filtered employees list
    filteredEmployees.assignAll(allEmployees);
  }

  void filterEmployees(String query, List<Employee> allEmployees) {
    if (query.isEmpty) {
      filteredEmployees.assignAll(allEmployees);
    } else {
      filteredEmployees.assignAll(allEmployees.where(
        (employee) =>
            employee.fullName.toLowerCase().contains(query.toLowerCase()),
      ));
    }
    // Check if the current selectedEmployee is in the filtered list
    String? selectedEmployeeId = selectedEmployee.value;
    final isEmployeeInList = filteredEmployees
        .any((employee) => employee.id.toString() == selectedEmployeeId);

    // If the selected employee is not in the filtered list, keep the value unchanged
    if (!isEmployeeInList && filteredEmployees.isNotEmpty) {
      selectedEmployeeId = filteredEmployees.first.id.toString();
      selectedEmployee.value = selectedEmployeeId;
    }
  }

  void initializeSelectedEmployee(List<String> dropdownValues) {
    if (selectedEmployee.value == null && dropdownValues.isNotEmpty) {
      selectedEmployee.value = dropdownValues.first;
    }
  }

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
        OverTimeController.instance.fetchOverTime();
        Get.back();
        Loaders.successSnackBar(
            title: "Thành công!",
            message: "Thêm thời gian làm việc thành công");

        // Future.delayed(const Duration(seconds: 1), () {
        //   Get.offAll(() => const OverTimeListScreen());
        // });
      } else {
        await OverTimeRepository.instance.updateOverTime(newOverTime);
        toggleEditting();

        OverTimeController.instance.fetchOverTime();
        Get.back();
        Loaders.successSnackBar(
            title: "Thành công!", message: "Chỉnh sửa thành công");
        // Future.delayed(const Duration(seconds: 1), () {
        //   Get.offAll(() => const OverTimeListScreen());
        // });
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
          OverTimeController.instance.fetchFilteredOverTime();

          Navigator.of(Get.overlayContext!).pop();

          Loaders.successSnackBar(
              title: "Thành công!", message: "Xóa thành công");

          // Get.offAll(() => const OverTimeListScreen());
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
