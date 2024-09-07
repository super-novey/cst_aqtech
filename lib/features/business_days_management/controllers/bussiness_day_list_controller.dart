import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/data/bussiness_days/bussiness_day_repository.dart';
import 'package:hrm_aqtech/features/business_days_management/controllers/date_range_controller.dart';
import 'package:hrm_aqtech/features/business_days_management/controllers/update_business_day_controller.dart';
import 'package:hrm_aqtech/features/business_days_management/models/business_date_model.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/network_manager.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/popups/loaders.dart';

class BussinessDayListController extends GetxController {
  static BussinessDayListController get instance => Get.find();

  final _bussinessDayRepository = Get.put(BussinessDayRepository());
  final updateBusinessDay = Get.put(UpdateBusinessDayController());

  List<BusinessDate> bussinessDateList = <BusinessDate>[].obs;
  RxMap<int, double> memberWorkDays = <int, double>{}.obs;

  var isLoading = false.obs;
  final isShowChart = false.obs;

  @override
  void onInit() {
    fetchBussinessDate(false);
    super.onInit();
  }

  Future<void> fetchBussinessDate(bool isAll) async {
    try {
      isLoading.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      if (isAll) {
        bussinessDateList
            .assignAll(await _bussinessDayRepository.getAllBussinessDayList());
      } else {
        bussinessDateList.assignAll(
            await _bussinessDayRepository.getBussinessDayList(
                DateRangeController.instance.dateRange.value.start,
                DateRangeController.instance.dateRange.value.end));
      }

      // Sắp xếp dữ liệu theo dateFrom giảm dần
      //updateMemberWorkDays();
      sort();
      updateMemberWorkDays();
    } finally {
      isLoading.value = false;
    }
  }

  void sort() {
    bussinessDateList.sort((a, b) => b.dateFrom.compareTo(a.dateFrom));
  }

  void delete(int id) {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(MySizes.md),
        title: "Xóa ngày công tác",
        middleText: "",
        confirm: ElevatedButton(
            onPressed: () async {
              await _bussinessDayRepository.deleteBusinessDay(id);
              fetchBussinessDate(false);
              Navigator.of(Get.overlayContext!).pop();
              //bussinessDateList.removeWhere((item) => item.id == id);
              Loaders.successSnackBar(
                  title: "Thành công!", message: "Xóa ngày công tác");
            },
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                backgroundColor: Colors.red,
                side: const BorderSide(color: Colors.red)),
            child: const Text("Xóa")),
        cancel: OutlinedButton(
            style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: MySizes.md, vertical: 0)),
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: const Text("Quay lại")));
  }

  void updateMemberWorkDays() {
    memberWorkDays.clear();
    for (var businessTrip in bussinessDateList) {
      for (var member in businessTrip.memberList) {
        memberWorkDays.update(
          member.id,
          (value) => value + businessTrip.sumDay,
          ifAbsent: () => businessTrip.sumDay,
        );
      }
    }
  }

  void toggleShowChart() {
    isShowChart.value = !isShowChart.value;
  }
}
