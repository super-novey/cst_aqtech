//format lại tổng số ngày nghỉ
import 'package:get/get.dart';

class FormatSumDayController extends GetxController {
  String formatLeaveDay(double sumDay) {
    if (sumDay % 1 == 0) {
      return sumDay.toInt().toString();
    } else {
      return sumDay.toStringAsFixed(1);
    }
  }
}
