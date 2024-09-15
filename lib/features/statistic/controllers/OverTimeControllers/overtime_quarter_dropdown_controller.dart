import 'package:get/get.dart';

class OvertimeQuarterDropdownController extends GetxController {
  static OvertimeQuarterDropdownController get instance => Get.find();
  var selectedQuarter = 'Q1'.obs;
  final List<String> quarters = ['Q1', 'Q2', 'Q3', 'Q4'];


  void updateSelectedQuarter(String quarter) {
    selectedQuarter.value = quarter;
  }
}
