import 'package:get/get.dart';
import 'package:hrm_aqtech/data/employees/employee_repository.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/update_employee_controller.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/network_manager.dart';
import 'package:hrm_aqtech/features/employee_management/models/employee_data_chart.dart';
import 'package:hrm_aqtech/features/employee_management/models/employee_model.dart';
import 'package:hrm_aqtech/utils/constants/enums.dart';

class EmployeeController extends GetxController {
  RxString filteredRole = "All".obs; // mac dinh la loc tat ca
  final isLoading = false.obs;
  static EmployeeController get instance => Get.find();
  List<Employee> allEmployees = <Employee>[];
  List<Employee> searchResult = <Employee>[];
  List<EmployeeData> data = <EmployeeData>[].obs;
  var touchedIndex = (-1).obs;
  RxBool isEmployeeDataReady = false.obs;
  RxInt textSearchLength = 0.obs;
  final editableController = Get.put(UpdateEmployeeController());
  final _employeeRepository = Get.put(EmployeeRepository());

  @override
  void onInit() {
    fetchEmployees();
    super.onInit();
  }

  Future<void> fetchEmployees() async {
    try {
      // show loader while loading list
      isLoading.value = true;

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }
      // fetch employees from api
      final employees = await _employeeRepository.getAllEmployees();
      // update the employees list
      allEmployees.assignAll(employees);
      processEmployeeData();

      isEmployeeDataReady.value = true;
    } finally {
      // stop loader
      isLoading.value = false;
    }
  }

  Future<void> updateEmployeeInfor() async {}

  // Lọc danh sách nhân viên theo chức vụ
  List<Employee> get filteredEmployees {
    if (filteredRole.value == "All") {
      return allEmployees;
    } else {
      return allEmployees
          .where((employee) =>
              employee.role.name == filteredRole.value.toString().trim())
          .toList();
    }
  }

  // Tìm kiếm nhân viên
  void searchEmployee({String query = ''}) {
    textSearchLength.value = query.length;
    searchResult = filteredEmployees
        .where((employee) =>
            employee.fullName.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void changeFilteredRole(String role) {
    filteredRole.value = role; // cap nhat role de loc
  }

  String? getEmployeeNameById(int id) {
    final employee = allEmployees.firstWhereOrNull((e) => e.id == id);
    return employee?.fullName;
  }

  String? getTfsNameById(String id) {
    final employee =
        allEmployees.firstWhereOrNull((e) => e.id.toString() == id);
    return employee?.tfsName;
  }

  void processEmployeeData() {
    final employees = allEmployees;

    final roleCounts = <EmployeeRole, int>{};
    for (var employee in employees) {
      roleCounts[employee.role] = (roleCounts[employee.role] ?? 0) + 1;
    }

    data = roleCounts.entries.map((entry) {
      final percentage =
          ((entry.value / employees.length) * 100).toStringAsFixed(2);
      return EmployeeData(
        xData: entry.key.name,
        yData: double.parse(percentage),
        count: entry.value,
      );
    }).toList();
  }

  void updateTouchedIndex(int index) {
    touchedIndex.value = index;
  }
}
