import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/shimmers/shimmer_list_tile.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/features/individual_work_management/controllers/filter_controller.dart';
import 'package:hrm_aqtech/features/individual_work_management/controllers/individual_work_controller.dart';
import 'package:hrm_aqtech/features/individual_work_management/views/individual_work_chart.dart';
import 'package:hrm_aqtech/features/individual_work_management/views/widgets/filter_widget.dart';
import 'package:hrm_aqtech/features/individual_work_management/views/widgets/individual_work_tile.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class IndividualWorkScreen extends StatelessWidget {
  const IndividualWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EmployeeController employeeController = Get.put(EmployeeController());
    final FilterController filterController = Get.put(FilterController());
    final IndividualWorkController controller =
        Get.put(IndividualWorkController());

    // Observe changes in employeeController and fetch data when ready
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text("Kết quả làm việc cá nhân"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          Obx(() {
            return IconButton(
              icon: const Icon(Icons.bar_chart_rounded),
              onPressed: controller.isChartReady.value
                  ? () {
                      Get.to(() => const IndividualWorkChart());
                    }
                  : null, // Disable the button until ready
              color: controller.isChartReady.value
                  ? Colors.white
                  : MyColors
                      .primaryColor, // Change color to indicate disabled state
            );
          }),
        ],
      ),
      body: Obx(() {
        if (employeeController.isEmployeeDataReady.value &&
            !filterController.isFilterDataReady.value) {
          String? initialEmployeeId = employeeController.allEmployees.isNotEmpty
              ? employeeController.allEmployees.first.id.toString()
              : null;
          if (initialEmployeeId != null) {
            controller.fetchIndividualWork(
              initialEmployeeId,
              filterController.year.value.toString(),
            );
            filterController.isFilterDataReady.value = true;
          }
        }

        if (!employeeController.isEmployeeDataReady.value ||
            !controller.isChartReady.value) {
          return const ShimmerListTile();
        }

        return NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              const SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: Colors.white,
                expandedHeight: 100,
                bottom: Filter(),
              )
            ];
          },
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: controller.isLoading.value
                ? const ShimmerListTile()
                : ListView.builder(
                    itemCount:
                        controller.individualWork.value.soGioLamThieu.length,
                    itemBuilder: (context, index) {
                      final weekNumber =
                          controller.individualWork.value.soGioLamThieu.length -
                              index;

                      return IndividualWorkTile(
                        weekNumber: weekNumber,
                      );
                    },
                  ),
          ),
        );
      }),
    );
  }
}
