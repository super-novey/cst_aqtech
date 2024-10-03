import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/data/bussiness_days/bussiness_day_repository.dart';
import 'package:hrm_aqtech/data/employees/employee_repository.dart';

import 'package:hrm_aqtech/features/business_days_management/controllers/bussiness_day_list_controller.dart';

import 'package:hrm_aqtech/features/business_days_management/controllers/member_list_controller.dart';
import 'package:hrm_aqtech/features/business_days_management/controllers/new_date_range_controller.dart';
import 'package:hrm_aqtech/features/business_days_management/models/business_date_model.dart';
import 'package:hrm_aqtech/features/business_days_management/models/member_model.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/network_manager.dart';
import 'package:hrm_aqtech/utils/constants/image_paths.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';
import 'package:hrm_aqtech/utils/popups/full_screen_loader.dart';
import 'package:hrm_aqtech/utils/popups/loaders.dart';

class UpdateBusinessDayController extends GetxController {
  static UpdateBusinessDayController get instance => Get.find();
  final dateRangeController = Get.put(NewDateRangeController());
  final memberListController = Get.put(MemberListController());
  final _employeeRepository = Get.put(EmployeeRepository());

  var isLoading = false.obs;

  var sumDay = TextEditingController().obs;
  var commissionContent = TextEditingController();
  var transportation = TextEditingController();
  var commissionExpenses = TextEditingController();
  var note = TextEditingController();
  var isAdd = false.obs;

  @override
  void dispose() {
    sumDay.value.dispose();
    commissionContent.dispose();
    transportation.dispose();
    commissionExpenses.dispose();
    note.dispose();
    super.dispose();
  }

  Future<void> init(BusinessDate businessDay) async {
    try {
      isLoading.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }
      // Load du lieu
      memberListController.memberNameController.clear();
      memberListController.memberExpensesController.clear();

      sumDay.value.text = MyFormatter.formatDouble(businessDay.sumDay);

      commissionContent.text = businessDay.commissionContent;
      transportation.text = businessDay.transportation;
      commissionExpenses.text = businessDay.commissionExpenses.toString();
      note.text = businessDay.note;
      dateRangeController.dateRange.value = DateTimeRange(
          start: businessDay.dateFrom.toLocal(),
          end: businessDay.dateTo.toLocal());
      businessDay.dateFrom;

      final employees = await _employeeRepository.getAssignedEmployeeList();
      
      memberListController.allEmployees.assignAll(employees);

      for (var x in businessDay.memberList) {
        final foundEmployee = employees.firstWhere(
          (employee) => employee.id == x.id,
        );
        memberListController.memberNameController.add(foundEmployee);
        memberListController.memberExpensesController
            .add(TextEditingController(text: x.memberExpenses.toString()));
      }
    } finally {
      isLoading.value = false;
    }
  }

  void save(BusinessDate businessDay) async {
    try {
      // start loading
      FullScreenLoader.openDialog("Đang xử lý...", MyImagePaths.docerAnimation);

      // // check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      // Form validator
      // ...........

      _getBusinessDayFromForm(businessDay);
      if (isAdd.value) {
        // Xu ly them

        await BussinessDayRepository.instance.addBusinessDay(businessDay);
        BussinessDayListController.instance.fetchBussinessDate(true);
        // BussinessDayListController.instance.bussinessDateList.add(businessDay);
        // BussinessDayListController.instance.sort();
        Get.back();
        Loaders.successSnackBar(
            title: "Thành công!", message: "Đã thêm ngày công tác");

        isAdd.value = false; // cap nhat truong idAdd
      } else {
        // Goi API
        await BussinessDayRepository.instance.updateBusinessDay(businessDay);
        BussinessDayListController.instance.fetchBussinessDate(true);

        // cap nhat giao dien
        // int index = BussinessDayListController.instance.bussinessDateList
        //     .indexWhere((item) => item.id == businessDay.id);
        // BussinessDayListController.instance.bussinessDateList[index] =
        //     businessDay;
        Get.back();
        // Hien thi tb load thanh cong
        Loaders.successSnackBar(
            title: "Thành công!", message: "Cập nhật ngày công tác");
      }
    } catch (e) {
      Loaders.errorSnackBar(title: "Oops", message: e.toString());
    } finally {
      FullScreenLoader.stopLoading();
    }
  }

  void _getBusinessDayFromForm(BusinessDate businessDay) {
    businessDay.dateFrom = dateRangeController.dateRange.value.start;
    businessDay.dateTo = dateRangeController.dateRange.value.end;
    businessDay.sumDay = double.parse(sumDay.value.text);
    businessDay.commissionContent = commissionContent.text;
    businessDay.transportation = transportation.text;
    var memberlist = <Member>[];
    for (int i = 0; i < memberListController.memberNameController.length; i++) {
      final member = Member(
          id: memberListController.memberNameController[i].id,
          memberExpenses:
              int.parse(memberListController.memberExpensesController[i].text));
      memberlist.add(member);
    }
    businessDay.memberList = memberlist;
    businessDay.commissionExpenses = int.parse(commissionExpenses.text);
  }
}
