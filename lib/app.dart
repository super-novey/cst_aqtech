import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:hrm_aqtech/bindings/general_bindings.dart';
import 'package:hrm_aqtech/features/authentication/controllers/authentication_controller.dart';
import 'package:hrm_aqtech/features/authentication/views/login/login_screen.dart';
import 'package:hrm_aqtech/utils/themes/theme.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final authenticationController = Get.put(AuthenticationController());

    return GetMaterialApp(
      initialBinding: GeneralBindings(),
      themeMode: ThemeMode.system,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      locale: const Locale('vi'),
      supportedLocales: const [
        Locale('en'), // English
        Locale('vi'), // Vietnamese
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        MonthYearPickerLocalizations
            .delegate, // Thêm delegate của month_year_picker
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
