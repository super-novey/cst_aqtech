import 'package:get/get.dart';
import 'package:hrm_aqtech/features/authentication/controllers/authentication_controller.dart';
import 'package:hrm_aqtech/features/online_work_management/models/online_work_day_model.dart';
import 'package:hrm_aqtech/utils/http/http_client.dart';

class OnlineWorkDayRepository extends GetxController {
  static OnlineWorkDayRepository get instance => Get.find();

  Future<List<OnlineWork>> getAllOnlineWorkDays(
      {String? dateFrom, String? dateTo}) async {
    try {
      String url = "LamViecOnline";
      if (dateFrom != null && dateTo != null) {
        url += "?query_dateFrom=$dateFrom&query_dateTo=$dateTo";
      }

      final snapshot = await HttpHelper.get(url);
      final list = (snapshot["data"] as List)
          .map((onlineWork) => OnlineWork.fromJson(onlineWork))
          .toList();

      final isLeader = AuthenticationController.instance.currentUser.isLeader;

      if (isLeader) {
        return list;
      } else {
        final currentUserId = AuthenticationController.instance.currentUser.id;
        return list.where((work) => work.memberId == currentUserId).toList();
      }
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> addOnlineWork(OnlineWork newOnlineWork) async {
    try {
      await HttpHelper.post("LamViecOnline", [newOnlineWork.toJson()]);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> updateOnlineWork(OnlineWork newOnlineWork) async {
    try {
      await HttpHelper.put(
          "LamViecOnline/${newOnlineWork.id}", newOnlineWork.toJson());
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> deleteOnlineWork(String id) async {
    try {
      await HttpHelper.delete("LamViecOnline/$id");
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> approvalOnlineWorkDay(String id, String approvalStatus) async {
    try {
      final data = {
        "id": id,
        "approvalStatus": approvalStatus,
      };
      await HttpHelper.put("LamViecOnline/DuyetLamViecOnline", data);
    } on Exception catch (_) {
      rethrow;
    }
  }
}
