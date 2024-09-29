import 'package:get/get.dart';
import 'package:hrm_aqtech/features/business_days_management/models/business_date_model.dart';
import 'package:hrm_aqtech/utils/http/http_client.dart';

class BussinessDayRepository extends GetxController {
  static BussinessDayRepository get instance => Get.find();

  Future<List<BusinessDate>> getBussinessDayList(
      DateTime startDate, DateTime endDate) async {
    try {
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

  Future<List<BusinessDate>> getAllBussinessDayList() async {
    try {
      final snapshot = await HttpHelper.get("NgayCongTac");

      final list = (snapshot["data"] as List)
          .map((date) => BusinessDate.fromJson(date))
          .toList();
      return list;
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> addBusinessDay(BusinessDate businessDate) async {
    try {
      await HttpHelper.post("NgayCongTac", [businessDate.toJson()]);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> deleteBusinessDay(int id) async {
    try {
      await HttpHelper.delete("NgayCongTac/$id");
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> updateBusinessDay(BusinessDate businessDay) async {
    try {
      await HttpHelper.put(
          "NgayCongTac/${businessDay.id}", businessDay.toJson());
    } on Exception catch (_) {
      rethrow;
    }
  }
}
