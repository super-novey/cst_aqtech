import 'package:get/get.dart';
import 'package:hrm_aqtech/features/time_off_management/models/general_time_off_model.dart';
import 'package:hrm_aqtech/utils/http/http_client.dart';

class TimeOffRepository extends GetxController {
  static TimeOffRepository get instance => Get.find();

  Future<List<GeneralTimeOff>> getAllGeneralTimeOffs() async {
    try {
      final snapshot = await HttpHelper.get("NgayPhepChung");
      final list = (snapshot["data"] as List)
          .map((data) => GeneralTimeOff.fromJson(data))
          .toList();
      return list;
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> updateGeneralTimeOff(GeneralTimeOff timeOff) async {
    try {
      await HttpHelper.put("NgayPhepChung/${timeOff.id}", {
        "dateFrom": timeOff.dateFrom.toIso8601String(),
        "dateTo": timeOff.dateTo.toIso8601String(),
        "sumDay": timeOff.sumDay,
        "reason": timeOff.reason,
        "note": timeOff.note,
      });
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> deleteTimeOff(int id) async {
    try {
      await HttpHelper.delete("NgayPhepChung/$id");
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> createGeneralTimeOff(GeneralTimeOff timeOff) async {
    try {
      await HttpHelper.post("NgayPhepChung", [
        {
          "dateFrom": timeOff.dateFrom.toIso8601String(),
          "dateTo": timeOff.dateTo.toIso8601String(),
          "sumDay": timeOff.sumDay,
          "reason": timeOff.reason,
          "note": timeOff.note,
        }
      ]);
    } on Exception catch (_) {
      rethrow;
    }
  }

  // Future<int> _getNextId() async {
  //   final timeOffs = await getAllGeneralTimeOffs();
  //   if (timeOffs.isEmpty) {
  //     return 1;
  //   }
  //   return timeOffs
  //           .map((timeOff) => timeOff.id)
  //           .reduce((a, b) => a > b ? a : b) +
  //       1;
  // }
}
