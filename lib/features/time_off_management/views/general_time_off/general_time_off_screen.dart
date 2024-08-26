import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/time_off_management/controllers/general_time_off_controller.dart';
import 'package:hrm_aqtech/features/time_off_management/controllers/filter_controller.dart';
import 'package:hrm_aqtech/features/time_off_management/models/general_time_off_model.dart';
import 'package:hrm_aqtech/features/time_off_management/views/general_time_off/create_general_time_off.dart/create_general_time_off.dart';
import 'package:hrm_aqtech/features/time_off_management/views/general_time_off/widgets/filter_widget.dart';
import 'package:hrm_aqtech/features/time_off_management/views/general_time_off/widgets/time_off_tile.dart';
import 'package:hrm_aqtech/features/time_off_management/views/general_time_off_detail/general_time_off_detail.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class GeneralTimeOffScreen extends StatelessWidget {
  const GeneralTimeOffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GeneralTimeOffController controller =
        Get.put(GeneralTimeOffController());
    final FilterController filterController = Get.put(FilterController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text("Ngày nghỉ chung"),
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
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Get.to(
                () => CreateGeneralTimeOffScreen(
                  generalTimeOff: GeneralTimeOff.empty(),
                ),
              );
              controller.refreshTimeOffs();
              filterController.filter();
            },
          ),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (_, innerBoxIsScrolled) {
          return [
            const SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              floating: true,
              backgroundColor: Colors.white,
              expandedHeight: 150,
              bottom: FilterWidget(), // Customize as per your need
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 20),
              Obx(() {
                if (controller.isLoading.value) {
                  filterController.filter();
                  return const Center(
                      child: CircularProgressIndicator(
                    color: MyColors.primaryColor,
                  ));
                } else {
                  filterController.filter();

                  if (filterController.generalTimeOffs.isEmpty) {
                    controller.refreshTimeOffs();
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filterController.generalTimeOffs.length,
                    itemBuilder: (context, index) {
                      final timeOff = filterController.generalTimeOffs[index];
                      return Dismissible(
                        key: ValueKey(timeOff.id),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) async {
                          await controller.delete(timeOff.id);

                          controller.refreshTimeOffs();
                          filterController.filter();
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        child: InkWell(
                          onTap: () async {
                            await Get.to(
                              () => GeneralTimeOffDetailScreen(
                                  generalTimeOff: timeOff),
                            );
                            controller.refreshTimeOffs();
                            filterController.filter();
                          },
                          child: TimeOffTile(timeOff: timeOff),
                        ),
                      );
                    },
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
