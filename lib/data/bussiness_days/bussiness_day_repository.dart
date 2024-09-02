import 'package:get/get.dart';
import 'package:hrm_aqtech/features/business_days_management/models/business_date_model.dart';
import 'package:hrm_aqtech/utils/http/http_client.dart';

class BussinessDayRepository extends GetxController {
  static BussinessDayRepository get instance => Get.find();

  Future<List<BusinessDate>> getBussinessDayList(
      DateTime startDate, DateTime endDate) async {
    try {
      // final snapshot = await HttpHelper.get(
      //     "NgayCongTac?query_dateFrom=2024-01-01T00:00:00.000&query_dateTo=2024-09-02T22:00:53.988121");

      final snapshot = await HttpHelper.get(
          "NgayCongTac?query_dateFrom=${startDate.toIso8601String()}&query_dateTo=${endDate.toIso8601String()}");
      
      final list = (snapshot["data"] as List)
          .map((date) => BusinessDate.fromJson(date))
          .toList();

      return list;
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<BusinessDate> getById(int id) async {
    try {
      final snapshot = await HttpHelper.get("NgayPhepChung/$id");
      return BusinessDate.fromJson(snapshot);
    } on Exception catch (_) {
      rethrow;
    }
  }
}
