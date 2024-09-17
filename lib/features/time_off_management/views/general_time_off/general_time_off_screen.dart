import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/shimmers/shimmer_list_tile.dart';
import 'package:hrm_aqtech/features/time_off_management/controllers/general_time_off_controller.dart';
import 'package:hrm_aqtech/features/time_off_management/models/general_time_off_model.dart';
import 'package:hrm_aqtech/features/time_off_management/views/create_general_time_off.dart/create_general_time_off.dart';
import 'package:hrm_aqtech/features/time_off_management/views/general_time_off/widgets/filter_widget.dart';
import 'package:hrm_aqtech/features/time_off_management/views/general_time_off/widgets/time_off_tile.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class GeneralTimeOffScreen extends StatelessWidget {
  const GeneralTimeOffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GeneralTimeOffController controller =
        Get.put(GeneralTimeOffController());

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
            onPressed: () {
              Get.to(
                () => CreateGeneralTimeOffScreen(
                  generalTimeOff: GeneralTimeOff.empty(),
                ),
              );
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
              bottom: FilterWidget(),
            ),
          ];
        },
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: ShimmerListTile());
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.generalTimeOffs.length,
              itemBuilder: (context, index) {
                final timeOff = controller.generalTimeOffs[index];
                return Dismissible(
                  key: ValueKey(timeOff.id),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) async {
                    await controller.delete(timeOff.id);
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
                  child: TimeOffTile(timeOff: timeOff),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
