// AuthenticationRepository.dart
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/authentication/models/user.dart';
import 'package:hrm_aqtech/utils/http/http_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

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

      if (response.containsKey('error')) {
        Get.snackbar(
          'Login Failed',
          response['error'],
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        await _storage.write(
          key: 'KEY_USER',
          value: jsonEncode(User.fromJson(response)),
        );
      }

      await _storage.write(
          key: 'KEY_USER', value: jsonEncode(User.fromJson(response)));

      return response;
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<User?> getAuthToken() async {
    final storedUser = await _storage.read(key: 'KEY_USER');

    if (storedUser != null) {
      return User.fromJson(jsonDecode(storedUser));
    }
    return null;
  }

  Future<void> logout() async {
    await _storage.delete(key: 'KEY_USER');
  }
}
