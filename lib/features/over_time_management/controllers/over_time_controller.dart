import 'package:get/get.dart';
import 'package:hrm_aqtech/data/over_time/over_time_repository.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/network_manager.dart';
import 'package:hrm_aqtech/features/over_time_management/controllers/date_range_over_time_controller.dart';
import 'package:hrm_aqtech/features/over_time_management/models/over_time_model.dart';

class OverTimeController extends GetxController {
  static OverTimeController get instance => Get.find();
  final isLoading = false.obs;
  RxList<OverTime> allOverTime = <OverTime>[].obs;
  RxMap<int, double> memberOvertimeHours = <int, double>{}.obs;
  final overTimeRepository = Get.put(OverTimeRepository());
  final dateRangeOverTimeController = Get.put(DateRangeOverTimeController());

  @override
  void onInit() {
    fetchOverTime();
    super.onInit();
  }

  Future<void> fetchOverTime() async {
    try {
      // show loader while loading list
      isLoading.value = true;

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }
      final dateFrom = DateTime(DateTime.now().year, 1, 1).toIso8601String();
      final dateTo = DateTime.now().toIso8601String();
      allOverTime.value = await OverTimeRepository.instance
          .getAllOverTime(dateFrom: dateFrom, dateTo: dateTo);
      updateMemberOvertimeHours();
    } finally {
      // stop loader
      isLoading.value = false;
    }
  }

  Future<void> fetchFilteredOverTime() async {
    try {
      // show loader while loading list
      isLoading.value = true;

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }
      final dateFrom =
          dateRangeOverTimeController.dateRange.value.start.toIso8601String();
      final dateTo =
          dateRangeOverTimeController.dateRange.value.end.toIso8601String();
      allOverTime.value = await OverTimeRepository.instance
          .getAllOverTime(dateFrom: dateFrom, dateTo: dateTo);
      updateMemberOvertimeHours();
    } finally {
      // stop loader
      isLoading.value = false;
    }
  }

  void updateMemberOvertimeHours() {
    memberOvertimeHours.clear();
    for (var workOvertime in allOverTime) {
      memberOvertimeHours.update(
        workOvertime.memberId,
        (value) =>
            value + workOvertime.time.toDouble(), // Convert time to double
        ifAbsent: () => workOvertime.time.toDouble(),
      );
    }
  }
}
