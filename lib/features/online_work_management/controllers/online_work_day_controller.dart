import 'package:get/get.dart';
import 'package:hrm_aqtech/data/online_work/online_work_day_repository.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/network_manager.dart';
import 'package:hrm_aqtech/features/online_work_management/controllers/date_range_online_work_controller.dart';
import 'package:hrm_aqtech/features/online_work_management/models/online_work_day_model.dart';

class OnlineWorkDayController extends GetxController {
  static OnlineWorkDayController get instance => Get.find();
  final isLoading = false.obs;
  RxList<OnlineWork> allOnlineWorkDays = <OnlineWork>[].obs;
  RxMap<int, double> memberWorkDays = <int, double>{}.obs;
  final onlineWorkDayRepository = Get.put(OnlineWorkDayRepository());
  final dateRangeOnlineController = Get.put(DateRangeOnlineWorkController());

  @override
  void onInit() {
    fetchOnlineWorkDays();
    super.onInit();
  }

  Future<void> fetchOnlineWorkDays() async {
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
      allOnlineWorkDays.value = await OnlineWorkDayRepository.instance
          .getAllOnlineWorkDays(dateFrom: dateFrom, dateTo: dateTo);
      updateMemberWorkDays();
    } finally {
      // stop loader
      isLoading.value = false;
    }
  }

  Future<void> fetchFilteredOnlineWorkDays() async {
    try {
      // show loader while loading list
      isLoading.value = true;

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }
      final dateFrom =
          dateRangeOnlineController.dateRange.value.start.toIso8601String();
      final dateTo =
          dateRangeOnlineController.dateRange.value.end.toIso8601String();
      allOnlineWorkDays.value = await OnlineWorkDayRepository.instance
          .getAllOnlineWorkDays(dateFrom: dateFrom, dateTo: dateTo);
      updateMemberWorkDays();
    } finally {
      // stop loader
      isLoading.value = false;
    }
  }

  void updateMemberWorkDays() {
    memberWorkDays.clear();
    for (var workOnline in allOnlineWorkDays) {
      memberWorkDays.update(
        workOnline.memberId,
        (value) => value + workOnline.sumDay,
        ifAbsent: () => workOnline.sumDay,
      );
    }
  }
}
