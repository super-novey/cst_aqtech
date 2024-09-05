import 'package:get/get.dart';
import 'package:hrm_aqtech/data/leave_day/leave_day_repository.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/network_manager.dart';
import 'package:hrm_aqtech/features/leave_day_management/controllers/date_range_controller.dart';
import 'package:hrm_aqtech/features/leave_day_management/models/leave_day_model.dart';

class LeaveDayController extends GetxController {
  static LeaveDayController get instance => Get.find();
  final isLoading = false.obs;
  RxList<LeaveDay> allLeaveDays = <LeaveDay>[].obs;
  RxMap<int, double> memberLeaveDays = <int, double>{}.obs;
  final leaveDayRepository = Get.put(LeaveDayRepository());
  final dateRangeController = Get.put(DateRangeController());

  @override
  void onInit() {
    fetchLeaveDays();
    super.onInit();
  }

  Future<void> fetchLeaveDays() async {
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
      allLeaveDays.value = await LeaveDayRepository.instance
          .getAllLeaveDays(dateFrom: dateFrom, dateTo: dateTo);
      updateMemberDayOffDays();
    } finally {
      // stop loader
      isLoading.value = false;
    }
  }

  Future<void> fetchFilteredLeaveDays() async {
    try {
      // show loader while loading list
      isLoading.value = true;

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }
      final dateFrom =
          dateRangeController.dateRange.value.start.toIso8601String();
      final dateTo = dateRangeController.dateRange.value.end.toIso8601String();
      allLeaveDays.value = await LeaveDayRepository.instance
          .getAllLeaveDays(dateFrom: dateFrom, dateTo: dateTo);
      updateMemberDayOffDays();
    } finally {
      // stop loader
      isLoading.value = false;
    }
  }

  void updateMemberDayOffDays() {
    memberLeaveDays.clear();
    for (var leaveDay in allLeaveDays) {
      memberLeaveDays.update(
        leaveDay.memberId,
        (value) => value + leaveDay.sumDay,
        ifAbsent: () => leaveDay.sumDay,
      );
    }
  }
}
