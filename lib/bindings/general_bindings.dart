import 'package:get/get.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
  }
}
