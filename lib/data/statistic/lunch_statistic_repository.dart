import 'package:get/get.dart';
import 'package:hrm_aqtech/features/statistic/models/lunch_statistics.dart';
import 'package:hrm_aqtech/utils/http/http_client.dart';

class LunchStatisticRepository {
  static LunchStatisticRepository get instance => Get.find();

  Future<List<LunchStatistics>> getLunchStatistic(int month, int year) async {
    try {
      final snapshot = await HttpHelper.get(
          "BaoBieuThongKe/ThongKeTinhTienAnTrua?year=$year&month=$month");
      final list = (snapshot["data"] as List)
          .map((sta) => LunchStatistics.fromJson(sta))
          .toList();
      return list;
    } on Exception catch (_) {
      rethrow;
    }
  }
}
