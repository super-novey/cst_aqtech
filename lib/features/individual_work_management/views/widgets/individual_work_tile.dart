import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/individual_work_management/controllers/individual_work_controller.dart';
import 'package:hrm_aqtech/features/individual_work_management/models/individual_work_model.dart';
import 'package:hrm_aqtech/features/individual_work_management/views/individual_work_detail_screen.dart';
import 'package:hrm_aqtech/utils/constants/image_paths.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';

class IndividualWorkTile extends StatelessWidget {
  const IndividualWorkTile({super.key, required this.weekNumber});
  final int weekNumber;

  @override
  Widget build(BuildContext context) {
    IndividualWork individualWork =
        IndividualWorkController.instance.individualWork.value;

    int itemIndex = weekNumber - 1;
    double soGioLamViecTrongNgay = 0;
    int soLuongCaseThucHienTrongTuan = 0;

    if (itemIndex >= 0 &&
        itemIndex < individualWork.soGioLamViecTrongTuan.length) {
      soGioLamViecTrongNgay = individualWork.soGioLamViecTrongTuan[itemIndex];
    }

    if (itemIndex >= 0 &&
        itemIndex < individualWork.soLuongCaseThucHienTrongTuan.length) {
      soLuongCaseThucHienTrongTuan =
          individualWork.soLuongCaseThucHienTrongTuan[itemIndex];
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () => {
          Get.to(() => IndividualWorkDetailScreen(
                weekNumber: weekNumber,
              ))
        },
        child: Card(
          color: Colors.white,
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(MySizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tuần $weekNumber',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Icon(Icons.calendar_month_outlined),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      MyImagePaths.iconClock,
                      width: 24, // Set a suitable size for the icon
                      height: 24,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      'Số giờ làm việc',
                      style: TextStyle(
                          fontSize: MySizes.fontSizeSm,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      '${MyFormatter.formatDouble(soGioLamViecTrongNgay)} giờ',
                      style: const TextStyle(
                          fontSize: MySizes.fontSizeSm,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      MyImagePaths.iconWorkCase,
                      width: 24, // Set a suitable size for the icon
                      height: 24,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      'Số case thực hiện',
                      style: TextStyle(
                          fontSize: MySizes.fontSizeSm,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      '$soLuongCaseThucHienTrongTuan case',
                      style: const TextStyle(
                          fontSize: MySizes.fontSizeSm,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
