import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hrm_aqtech/bindings/general_bindings.dart';
import 'package:hrm_aqtech/features/authentication/views/onboarding/onboarding_screen.dart';
import 'package:hrm_aqtech/utils/themes/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GeneralBindings(),
      themeMode: ThemeMode.system,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const OnboardingScreen(),
    );
  }
}
