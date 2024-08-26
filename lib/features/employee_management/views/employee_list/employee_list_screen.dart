import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/shimmers/shimmer_list_tile.dart';
import 'package:hrm_aqtech/common/widgets/appbar/tabbar.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/features/employee_management/models/employee_model.dart';
import 'package:hrm_aqtech/features/employee_management/views/employee_details/employee_detail.dart';
import 'package:hrm_aqtech/features/employee_management/views/employee_list/widgets/employee_tile.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/enums.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Khởi tạo employee controller
    final controller = Get.put(EmployeeController());

    return DefaultTabController(
      length: EmployeeRole.values.length + 1, // do co tab All nen +1
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: MyColors.primaryColor,
            title: const Text("Danh sách nhân sự AQTech"),
            actions: [
              IconButton(
                  onPressed: () {
                    controller.editableController.isAdd.value = true;
                    controller.editableController.toggleEditting();
                    Get.to(() => EmployeeDetailScreen(
                          selectedEmployee: Employee(),
                        ));
                  },
                  icon: const Icon(Icons.person_add))
            ],
          ),
          body: NestedScrollView(
              headerSliverBuilder: (_, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                      automaticallyImplyLeading: false,
                      pinned: true,
                      floating: true,
                      backgroundColor: Colors.white,
                      expandedHeight: 150,
                      flexibleSpace: Padding(
                          padding: const EdgeInsets.all(MySizes.defaultSpace),
                          child: TextField(
                            onChanged: (value) {
                              controller.searchEmployee(query: value);
                            },
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.search_normal),
                                hintText: "Tìm kiếm nhân viên"),
                          )),
                      bottom: MyTabbar(
                          onTap: (index) {
                            if (index == 0) {
                              controller.changeFilteredRole("All");
                            } else {
                              controller.changeFilteredRole(
                                  EmployeeRole.values[index - 1].name);
                            }
                          },
                          tabs: createTabs())),
                ];
              },
              body: Obx(() => (controller.isLoading.value)
                  ? const ShimmerListTile()
                  : ListView.builder(
                      itemCount: (controller.textSearchLength.value == 0)
                          ? controller.filteredEmployees.length
                          : controller.searchResult.length,
                      itemBuilder: (context, index) {
                        final employee =
                            (controller.textSearchLength.value == 0)
                                ? controller.filteredEmployees[index]
                                : controller.searchResult[index];
                        return Padding(
                          padding: const EdgeInsets.all(MySizes.sm),
                          child: EmployeeTile(employee: employee),
                        );
                      },
                    )))),
    );
  }

  List<MyTab> createTabs() {
    List<MyTab> tabs = [];
    tabs.add(const MyTab(role: "All"));
    tabs.addAll(EmployeeRole.values.map((role) {
      return MyTab(role: role.name);
    }).toList());
    return tabs;
  }
}
