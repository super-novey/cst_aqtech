import 'package:get/get.dart';

class FormatDayController extends GetxController {
  String formatDayController(double day) {
    if (day % 1 == 0) {
      return day.toInt().toString();
    } else {
      return day.toStringAsFixed(1);
    }
  }
}
