import 'package:get/get.dart';

class FormatTimeController extends GetxController {
  String formatTimeController(double time) {
    if (time % 1 == 0) {
      return time.toInt().toString();
    } else {
      return time.toStringAsFixed(1);
    }
  }
}
