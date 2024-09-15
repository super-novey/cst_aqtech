import 'package:get/get.dart';
import 'package:hrm_aqtech/data/employees/employee_repository.dart';
import 'package:hrm_aqtech/data/leave_day/leave_day_repository.dart';
import 'package:hrm_aqtech/data/online_work/online_work_day_repository.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/network_manager.dart';
import 'package:hrm_aqtech/features/employee_management/models/employee_model.dart';
import 'package:hrm_aqtech/features/leave_day_management/models/leave_day_model.dart';
import 'package:hrm_aqtech/features/online_work_management/models/online_work_day_model.dart';
import 'package:hrm_aqtech/features/statistic/controllers/LeaveDayControllers/leaveday_filter_date_controller.dart';
import 'package:hrm_aqtech/features/statistic/models/leaveday_statistic.dart';

class LeavedayStatisticController extends GetxController {
  static LeavedayStatisticController get instance => Get.find();

  final _employeeRepository = Get.put(EmployeeRepository());
  final _leaveDayRepository = Get.put(LeaveDayRepository());
  final _onlineWorkRepository = Get.put(OnlineWorkDayRepository());

  var employeeList = <Employee>[];
  var leaveDayList = <LeaveDay>[];
  var onlineWorkList = <OnlineWork>[];
  var leadayStatisticList = <LeavedayStatistic>[].obs;

  var memberLeaveDays = <int, double>{};
  var memberWorkDays = <int, double>{};

  var isLoading = false.obs;

  @override
  void onInit() {
    fetchLeaveDayStatistic();
    super.onInit();
  }

  Future<void> fetchLeaveDayStatistic() async {
    try {
      isLoading.value = true;
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }
      final dateFrom = DateTime(
          LeavedayFilterDateController.instance.selectedYear.value, 1, 1);
      final dateTo = DateTime(
          LeavedayFilterDateController.instance.selectedYear.value, 12, 31);

      final result = await Future.wait([
        _employeeRepository.getAllEmployees(),
        _leaveDayRepository.getAllLeaveDays(
            dateFrom: dateFrom.toIso8601String(),
            dateTo: dateTo.toIso8601String()),
        _onlineWorkRepository.getAllOnlineWorkDays(
            dateFrom: dateFrom.toIso8601String(),
            dateTo: dateTo.toIso8601String())
      ]);

      employeeList.assignAll(result[0] as List<Employee>);
      leaveDayList.assignAll(result[1] as List<LeaveDay>);
      onlineWorkList.assignAll(result[2] as List<OnlineWork>);

      // employeeList.assignAll(await _employeeRepository.getAllEmployees());
      // leaveDayList.assignAll(await _leaveDayRepository.getAllLeaveDays(
      //     dateFrom: dateFrom.toIso8601String(),
      //     dateTo: dateTo.toIso8601String()));
      // onlineWorkList.assignAll(await _onlineWorkRepository.getAllOnlineWorkDays(
      //     dateFrom: dateFrom.toIso8601String(),
      //     dateTo: dateTo.toIso8601String()));

      updateMemberDayOffDays();
      updateMemberWorkDays();
    } finally {
      isLoading.value = false;
      fetchLeaveDayStatisticList();
    }
  }

  updateMemberDayOffDays() {
    memberLeaveDays.clear();
    for (var leaveDay in leaveDayList) {
      if (leaveDay.isAnnual) {
        memberLeaveDays.update(
          leaveDay.memberId,
          (value) => value + leaveDay.sumDay,
          ifAbsent: () => leaveDay.sumDay,
        );
      }
    }
  }

  updateMemberWorkDays() {
    memberWorkDays.clear();
    for (var workOnline in onlineWorkList) {
      memberWorkDays.update(
        workOnline.memberId,
        (value) => value + workOnline.sumDay,
        ifAbsent: () => workOnline.sumDay,
      );
    }
  }

  void fetchLeaveDayStatisticList() {
    leadayStatisticList.clear();
    for (var employee in employeeList) {
      double totalLeaveDay = 0;
      double totalOnlineDay = 0;

      if (memberLeaveDays.containsKey(employee.id)) {
        totalLeaveDay = memberLeaveDays[employee.id]!;
      }

      if (memberWorkDays.containsKey(employee.id)) {
        totalOnlineDay = memberWorkDays[employee.id]!;
      }

      final stat = LeavedayStatistic(
          id: employee.id,
          leaveQuota: employee.absenceQuota,
          onlineQuotaPercentage: employee.wfhQuota,
          fullName: employee.fullName,
          nickName: employee.nickName,
          totalLeaveDays: totalLeaveDay,
          usedOnlineDays: totalOnlineDay);
      leadayStatisticList.add(stat);
    }
  }
}
