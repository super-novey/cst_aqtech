import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/statistic/models/commissionday_statistic.dart';
import 'package:hrm_aqtech/utils/http/http_client.dart';

class CommissiondayStatisticRepository extends GetxController {
  static CommissiondayStatisticRepository get instance => Get.find();

  Future<List<CommissionDay>> getCommissionDayStatistic(
      DateTimeRange date, int year) async {
    try {
      final snapshot = await HttpHelper.get(
          "BaoBieuThongKe/ThongKeTinhTienCongTac?query_dateFrom=${date.start.toIso8601String()}&query_dateTo=${date.end.toIso8601String()}&year=$year");
      final list = (snapshot["data"] as List)
          .map((sta) => CommissionDay.fromJson(sta))
          .toList();
      return list;
    } on Exception catch (_) {
      rethrow;
    }
  }
}
