import 'package:get/get.dart';

class CheckboxController extends GetxController {
  var isActive = false.obs;
  var isLeader = false.obs;
  var isLunch = false.obs;

  void toggleIsActive() {
    isActive.value = !isActive.value;
  }

  void toggle(int value) {
    switch (value) {
      case 0:
        isLeader.value = !isLeader.value;
        break;
      case 1:
        isLunch.value = !isLunch.value;
        break;
      default:
        isActive.value = !isActive.value;
    }
  }

  void toggleIsLunch() {
    isLunch.value = !isLunch.value;
  }

  void toggleIsLeader() {
    isLeader.value = !isLeader.value;
  }
}
