import 'package:get/get.dart';
import 'package:hrm_aqtech/data/bussiness_days/bussiness_day_repository.dart';
import 'package:hrm_aqtech/features/business_days_management/controllers/date_range_controller.dart';
import 'package:hrm_aqtech/features/business_days_management/models/business_date_model.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/network_manager.dart';

class BussinessDayListController extends GetxController {
  static BussinessDayListController get instance => Get.find();

  final _bussinessDayRepository = Get.put(BussinessDayRepository());
  List<BusinessDate> bussinessDateList = <BusinessDate>[].obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    fetchBussinessDate();
    super.onInit();
  }

  Future<void> fetchBussinessDate() async {
    try {
      isLoading.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      bussinessDateList.assignAll(
          await _bussinessDayRepository.getBussinessDayList(
              DateRangeController.instance.dateRange.value.start,
              DateRangeController.instance.dateRange.value.end));
    } finally {
      isLoading.value = false;
    }
  }
}
