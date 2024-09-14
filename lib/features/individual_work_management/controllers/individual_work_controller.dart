import 'dart:developer';

import 'package:get/get.dart';
import 'package:hrm_aqtech/data/individual_work/individual_work_repository.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/network_manager.dart';
import 'package:hrm_aqtech/features/individual_work_management/controllers/filter_controller.dart';
import 'package:hrm_aqtech/features/individual_work_management/models/individual_work_model.dart';

class IndividualWorkController extends GetxController {
  static IndividualWorkController get instance => Get.find();
  final IndividualWorkRepository repository =
      Get.put(IndividualWorkRepository());
  final EmployeeController employeeController = Get.find();
  final FilterController filterController = Get.find();

  var isLoading = false.obs;

  Rx<IndividualWork> individualWork = IndividualWork(
    soGioLamViecTrongTuan: [],
    soLuongCaseThucHienTrongTuan: [],
    soLuotCaseBiMoLai: [],
    soGioUocLuongCase: [],
    soGioThucTeLamCase: [],
    soGioThamGiaMeeting: [],
    phanTramTiLeMoCase: [],
    phanTramTiLeChenhLechUocLuongVaThucTe: [],
    soGioLamThieu: [],
  ).obs;


  Future<void> fetchIndividualWork(String user, String year) async {
    try {
      isLoading.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }
      log('user: $user');
      log('year: $year');
      var tfsName = EmployeeController.instance.getTfsNameById(user);
      log('year: $tfsName');

      var data = await repository.fetchIndividualWork(tfsName ?? '', year);
      individualWork.value = data;
    } finally {
      isLoading.value = false;
    }
  }
}
