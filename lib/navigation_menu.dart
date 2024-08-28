import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/employee_management/views/employee_list/employee_list_screen.dart';
import 'package:hrm_aqtech/features/home/home_screen.dart';
import 'package:hrm_aqtech/features/time_off_management/views/general_time_off/general_time_off_screen.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            backgroundColor: Colors.white,
            indicatorColor: MyColors.lightPrimaryColor,
            elevation: 0,
            destinations: const [
              NavigationDestination(
                  icon: Icon(
                    Icons.home,
                    color: MyColors.accentColor,
                  ),
                  label: 'Trang chủ'),
              NavigationDestination(
                  icon: Icon(
                    Iconsax.timer,
                    color: MyColors.accentColor,
                  ),
                  label: 'Nghỉ phép'),
              NavigationDestination(
                  icon: Icon(
                    Iconsax.timer,
                    color: MyColors.accentColor,
                  ),
                  label: 'Home'),
              NavigationDestination(
                  icon: Icon(
                    Iconsax.chart,
                    color: MyColors.accentColor,
                  ),
                  label: 'Thống kê'),
            ]),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const EmployeeListScreen(),
    const GeneralTimeOffScreen(),
    Container(
      color: Colors.black,
    ),
    // Container(
    //   color: Colors.blue,
    // ),
  ];
}
