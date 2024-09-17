import 'package:get/get.dart';
import 'package:hrm_aqtech/data/employees/employee_repository.dart';
import 'package:hrm_aqtech/data/individual_work/individual_work_repository.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/network_manager.dart';
import 'package:hrm_aqtech/features/employee_management/models/employee_tfs_name.dart';
import 'package:hrm_aqtech/features/individual_work_management/controllers/filter_controller.dart';
import 'package:hrm_aqtech/features/individual_work_management/models/individual_work_model.dart';

class IndividualWorkController extends GetxController {
  static IndividualWorkController get instance => Get.find();
  final IndividualWorkRepository repository =
      Get.put(IndividualWorkRepository());
  final EmployeeRepository employeeRepository = Get.put(EmployeeRepository());
  // final EmployeeController employeeController = Get.find();
  final FilterController filterController = Get.find();

  List<EmployeeTFSName> employees = <EmployeeTFSName>[];

  var isLoading = false.obs;
  var isEmployeeDataReady = false.obs;
  var isChartReady = false.obs;

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

  @override
  onInit() {
    super.onInit();
    fetchEmployees();
  }

  Future<void> fetchEmployees() async {
    try {
      isEmployeeDataReady.value = false;
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }
      employees = await employeeRepository.getEmployeeWithTfsNameList();
    } finally {
      isEmployeeDataReady.value = true;
    }
  }

  Future<void> fetchIndividualWork(String user, String year) async {
    try {
      isLoading.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }
      var tfsName = getTfsNameById(user);
      var data = await repository.fetchIndividualWork(tfsName ?? '', year);
      individualWork.value = data;
    } finally {
      isLoading.value = false;
      isChartReady.value = true;
    }
  }

  String? getTfsNameById(String id) {
    final employee = employees.firstWhereOrNull((e) => e.id.toString() == id);
    return employee?.tfsName;
  }
}
