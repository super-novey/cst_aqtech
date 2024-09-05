import 'package:get/get.dart';
import 'package:hrm_aqtech/features/leave_day_management/models/leave_day_model.dart';
import 'package:hrm_aqtech/utils/http/http_client.dart';

class LeaveDayRepository extends GetxController {
  static LeaveDayRepository get instance => Get.find();

  Future<List<LeaveDay>> getAllLeaveDays({String? dateFrom, String? dateTo}) async {
    try {
      String url = "NgayPhepCaNhan";
      
      if (dateFrom != null && dateTo != null) {
        url += "?query_dateFrom=$dateFrom&query_dateTo=$dateTo";
      }
      final snapshot = await HttpHelper.get(url);
      final list = (snapshot["data"] as List)
          .map((leaveDay) => LeaveDay.fromJson(leaveDay))
          .toList();
      return list;
    } on Exception catch (_) {
      rethrow;
    }
  }
  Future<void> addLeaveDay(LeaveDay newLeaveDay) async {
    try {
      await HttpHelper.post("NgayPhepCaNhan", [newLeaveDay.toJson()]);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> updateLeaveDay(LeaveDay newLeaveDay) async {
    try {
      await HttpHelper.put(
          "NgayPhepCaNhan/${newLeaveDay.id}", newLeaveDay.toJson());
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> deleteLeaveDay(String id) async {
    try {
      await HttpHelper.delete("NgayPhepCaNhan/$id");
    } on Exception catch (_) {
      rethrow;
    }
  }

    Future<void> approvalLeaveDay(String id, String approvalStatus) async {
    try {
      final data = {
        "id": id,
        "approvalStatus": approvalStatus,
      };
      await HttpHelper.put("NgayPhepCaNhan/DuyetNgayPhep", data);
    } on Exception catch (_) {
      rethrow;
    }
  }

}