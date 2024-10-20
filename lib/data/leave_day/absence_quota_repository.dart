import 'package:get/get.dart';
import 'package:hrm_aqtech/features/leave_day_management/models/absence_quota_model.dart';
import 'package:hrm_aqtech/utils/http/http_client.dart';

class AbsenceQuotaRepository extends GetxController {
  // Fetch the absence quota data for a specific year and memberId
  Future<AbsenceQuota> getAbsenceQuota({
    required int year,
    required int memberId,
  }) async {
    try {
      String url =
          "NgayPhepCaNhan/HanMucNghiPhepCaNhan?year=$year&query_memberId=$memberId";
      final response = await HttpHelper.get(url);
      // Check if 'data' is a list and not null
      if (response["data"] != null && response["data"] is List) {
        final data = response['data'] as List<dynamic>;
        return AbsenceQuota.fromJson(data[0]);
      } else {
        throw Exception('Invalid data format');
      }
    } on Exception catch (_) {
      rethrow;
    }
  }
}
