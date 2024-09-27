import 'package:get/get.dart';
import 'package:hrm_aqtech/features/employee_management/models/assigned_employee.dart';
import 'package:hrm_aqtech/features/employee_management/models/employee_model.dart';
import 'package:hrm_aqtech/features/employee_management/models/employee_tfs_name.dart';
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

  Future<Employee> getById(int id) async {
    try {
      final snapshot = await HttpHelper.get("ThongTinCaNhan/$id");
      final list = (snapshot["data"] as List)
          .map((employee) => Employee.fromJson(employee))
          .toList();
      return list[0];
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<List<AssignedEmployee>> getAssignedEmployeeList() async {
    try {
      final snapshot = await HttpHelper.get("ThongTinCaNhan/NhanVienCongTac");
      final ls = (snapshot["data"] as List)
          .map((employee) => AssignedEmployee.fromJson(employee))
          .toList();
      return ls;
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<List<EmployeeTFSName>> getEmployeeWithTfsNameList() async {
    try {
      final snapshot = await HttpHelper.get("ThongTinCaNhan/NhanVienTFSName");
      final list = (snapshot["data"] as List)
          .map((employee) => EmployeeTFSName.fromJson(employee))
          .toList();
      return list;
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> uploadAvatar(int employeeId, String base64Avatar) async {
    try {
      await HttpHelper.put(
        "ThongTinCaNhan/avatar/$employeeId",
        {
          'id': employeeId,
          'avatar': base64Avatar,
        },
      );
    } on Exception catch (_) {
      rethrow;
    }
  }
}
