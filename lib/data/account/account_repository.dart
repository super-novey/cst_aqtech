import 'package:get/get.dart';
import 'package:hrm_aqtech/utils/http/http_client.dart';
import 'package:hrm_aqtech/utils/popups/loaders.dart';

class AccountRepository extends GetxController {
  Future<bool> changePassword(int id, String currentPassword,
      String newPassword, String confirmPassword) async {
    try {
      final response = await HttpHelper.put(
        "TFSAccount/changePassword",
        {
          'id': id,
          'currentPassword': currentPassword,
          'newPassword': newPassword,
          'confirmPassword': confirmPassword
        },
      );

      if (response.containsKey('error')) {
        Loaders.errorSnackBar(title: "Thất bại!", message: response['error']);
        return false;
      }
      Get.back();
      Loaders.successSnackBar(
          title: "Thành công!", message: "Mật khẩu đã được cập nhật");

      return true;
    } catch (error) {
      Get.snackbar(
        'Error',
        'An error occurred while changing password',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }
}
