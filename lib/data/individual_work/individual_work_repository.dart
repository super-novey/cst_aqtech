import 'package:get/get.dart';
import 'package:hrm_aqtech/features/individual_work_management/models/individual_work_model.dart';
import 'package:hrm_aqtech/utils/http/http_client.dart';

class IndividualWorkRepository extends GetxController {
  static IndividualWorkRepository get instance => Get.find();

  Future<IndividualWork> fetchIndividualWork(String user, String year) async {
    try {
      final response = await HttpHelper.post(
        "KetQuaLamViecCaNhan/KetQuaLamViecCaNhan",
        {
          "user": user,
          "year": year,
        },
      );

      if (response['data'] != null &&
          response['data'] is Map<String, dynamic>) {
        final data = response['data'] as Map<String, dynamic>;

        return IndividualWork.fromJson(data);
      } else {
        throw Exception('Invalid data format');
      }
    } on Exception catch (_) {
      rethrow;
    }
  }
}
