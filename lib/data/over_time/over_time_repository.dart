import 'package:get/get.dart';
import 'package:hrm_aqtech/features/over_time_management/models/over_time_model.dart';
import 'package:hrm_aqtech/utils/http/http_client.dart';

class OverTimeRepository extends GetxController {
  static OverTimeRepository get instance => Get.find();

  Future<List<OverTime>> getAllOverTime(
      {String? dateFrom, String? dateTo}) async {
    try {
      String url = "LamViecNgoaiGio";
      if (dateFrom != null && dateTo != null) {
        url += "?query_dateFrom=$dateFrom&query_dateTo=$dateTo";
      }
      final snapshot = await HttpHelper.get(url);
      final list = (snapshot["data"] as List)
          .map((overTime) => OverTime.fromJson(overTime))
          .toList();
      return list;
    } on Exception catch (_) {
      rethrow;
    }
  }
  
  Future<void> addOverTime(OverTime newOverTime) async {
    try {
      await HttpHelper.post("LamViecNgoaiGio", [newOverTime.toJson()]);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> updateOverTime(OverTime newOverTime) async {
    try {
      await HttpHelper.put("LamViecNgoaiGio/${newOverTime.id}", newOverTime.toJson());
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> deleteOverTime(String id) async {
    try {
      await HttpHelper.delete("LamViecNgoaiGio/$id");
    } on Exception catch (_) {
      rethrow;
    }
  }

  

}
