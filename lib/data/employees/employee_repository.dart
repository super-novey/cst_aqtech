import 'package:get/get.dart';
import 'package:hrm_aqtech/features/employee_management/models/employee_model.dart';
import 'package:hrm_aqtech/utils/http/http_client.dart';

class EmployeeRepository extends GetxController {
  static EmployeeRepository get instance => Get.find();

  // Get all employee
  Future<List<Employee>> getAllEmployees() async {
    try {
      final snapshot = await HttpHelper.get("ThongTinCaNhan");
      final list = (snapshot["data"] as List)
          .map((employee) => Employee.fromJson(employee))
          .toList();
      return list;
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> updateEmployeeInfor(Employee newEmployee) async {
    try {
      await HttpHelper.put(
          "ThongTinCaNhan/${newEmployee.id}", newEmployee.toJson());
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> addEmployee(Employee newEmployee) async {
    try {
      await HttpHelper.post("ThongTinCaNhan", [newEmployee.toJson()]);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> deleteEmployee(String id) async {
    try {
      await HttpHelper.delete("ThongTinCaNhan/$id");
    } on Exception catch (_) {
      rethrow;
    }
  }
}
