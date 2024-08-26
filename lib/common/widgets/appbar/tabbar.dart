import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/devices/device_utils.dart';

class MyTabbar extends StatelessWidget implements PreferredSizeWidget {
  const MyTabbar({super.key, this.onTap, required this.tabs});

  final ValueChanged<int>? onTap;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: TabBar(
        labelPadding: const EdgeInsets.only(left: MySizes.defaultSpace),
        onTap: onTap,
        tabs: tabs,
        isScrollable: true,
        indicatorColor: Colors.white,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white,
        tabAlignment: TabAlignment.start,
        dividerColor: MyColors.dividerColor,
        padding: const EdgeInsets.symmetric(vertical: 20),
        overlayColor: const WidgetStatePropertyAll(Colors.white),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(MyDeviceUtils.getAppBarHeight() * 3);
}

class MyTab extends StatelessWidget {
  const MyTab({super.key, required this.role});

  final String role;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: (EmployeeController.instance.filteredRole.value == role)
                  ? MyColors.dartPrimaryColor
                  : MyColors.accentColor,
              border: Border.all(
                  color:
                      (EmployeeController.instance.filteredRole.value == role)
                          ? MyColors.dartPrimaryColor
                          : MyColors.accentColor),
              borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Text(
              role.toString().split('.').last,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
