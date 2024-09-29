import 'package:get/get.dart';
import 'package:hrm_aqtech/data/authentication/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:hrm_aqtech/features/authentication/views/login/login_screen.dart';
import 'package:hrm_aqtech/features/home/home_screen.dart';
import 'package:hrm_aqtech/features/authentication/models/user.dart';
import 'package:hrm_aqtech/utils/popups/loaders.dart';

class AuthenticationController extends GetxController {
  var isLoading = false.obs;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  User currentUser = User();

  RxBool isPasswordVisible = false.obs;

  final AuthenticationRepository repository =
      Get.put(AuthenticationRepository());
  static AuthenticationController get instance => Get.find();

  @override
  void onInit() {
    checkAuthStatus();
    super.onInit();
  }

  Future<void> checkAuthStatus() async {
    final user = await repository.getAuthToken();
    if (user != null) {
      currentUser = user;
      Get.to(() => const HomeScreen());
    }
  }

  Future<void> login() async {
    final username = usernameController.text;
    final password = passwordController.text;
    try {
      isLoading.value = true;

      if (username.isEmpty || password.isEmpty) {
        Loaders.errorSnackBar(
            title: "Thất bại!", message: 'Vui lòng nhập username và password');
        return;
      }
      final response = await repository.login(username, password);
      if (!response.containsKey('error')) {
        currentUser = User.fromJson(response);
        Get.to(() => const HomeScreen());
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await repository.logout();
    Get.offAll(() => const LoginScreen());
  }
}
