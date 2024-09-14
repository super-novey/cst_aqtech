import 'package:hrm_aqtech/utils/helpers/hepler_function.dart';

class LeavedayStatistic {
  int id;
  String nickName; // Nick name
  String fullName; // Tên đầy đủ
  double totalLeaveDays; // Tổng ngày nghỉ phép
  int leaveQuota; // Hạn mức nghỉ phép
  int onlineQuotaPercentage; // Hạn mức % online
  double usedOnlineDays; // Số ngày online đã sử dụng

  LeavedayStatistic({
    this.id = 0,
    this.nickName = "",
    this.fullName = "",
    this.totalLeaveDays = 0.0,
    this.leaveQuota = 0,
    this.onlineQuotaPercentage = 0,
    this.usedOnlineDays = 0,
  });

  double get remainingLeaveDays {
    return leaveQuota - totalLeaveDays;
  }

  double getRemainingOnlineDays(int year) {
    return getTotalOnlineQuotaDays(year) - usedOnlineDays;
  }

  int getTotalOnlineQuotaDays(int year) {
    return HeplerFunction.calculateWorkingDaysInYear(year) *
        onlineQuotaPercentage ~/
        100;
  }
}
