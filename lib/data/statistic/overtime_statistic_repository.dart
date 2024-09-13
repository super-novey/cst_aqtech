import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/statistic/models/overtime_statistic.dart';
import 'package:hrm_aqtech/utils/http/http_client.dart';

class OvertimeStatisticRepository extends GetxController {
  static OvertimeStatisticRepository get instance => Get.find();

  Future<List<OverTimeStatistic>> getOverTimeStatistic(
      DateTimeRange date, int year) async {
    try {
      final snapshot = await HttpHelper.get(
          "LamViecNgoaiGio/ThongKeTienLamViecNgoaiGio?query_dateFrom=${date.start.toIso8601String()}&query_dateTo=${date.end.toIso8601String()}&year=$year");
      print(snapshot);
      final list = (snapshot["data"] as List)
          .map((sta) => OverTimeStatistic.fromJson(sta))
          .toList();
      return list;
    } on Exception catch (_) {
      rethrow;
    }
  }
}
