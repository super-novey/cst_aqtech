import 'package:get/get.dart';
import 'package:hrm_aqtech/utils/http/http_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final _storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await HttpHelper.post(
        "TFSAccount/login",
        {
          'username': username,
          'password': password,
        },
      );

      await _storage.write(key: 'KEY_USERNAME', value: username);
      await _storage.write(key: 'KEY_PASSWORD', value: password);
      return response;
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<String?> getAuthToken() async {
    final username = await _storage.read(key: 'KEY_USERNAME');
    // final password = await _storage.read(key: 'KEY_PASSWORD');

    return username;
  }

  Future<void> logout() async {
    await _storage.delete(key: 'KEY_USERNAME');
    await _storage.delete(key: 'KEY_PASSWORD');
  }
}
