import 'package:get/get.dart';
import 'package:hrm_aqtech/utils/constants/enums.dart';

class RoleController extends GetxController {
  var selectedDepartment = EmployeeRole.Dev.obs;

  void setSelectedDepartment(EmployeeRole department) {
    selectedDepartment.value = department;
  }
}
