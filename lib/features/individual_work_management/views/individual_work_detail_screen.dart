import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/individual_work_management/controllers/individual_work_controller.dart';
import 'package:hrm_aqtech/features/individual_work_management/models/individual_work_model.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';

class IndividualWorkDetailScreen extends StatelessWidget {
  final int weekNumber;

  const IndividualWorkDetailScreen({
    super.key,
    required this.weekNumber,
  });

  @override
  Widget build(BuildContext context) {
    final IndividualWork individualWork =
        IndividualWorkController.instance.individualWork.value;
    final index = weekNumber - 1;

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      'Tuần $weekNumber',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: MyColors.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildDetailRow(
                      'Số giờ làm việc trong tuần',
                      MyFormatter.formatDouble(
                          individualWork.soGioLamViecTrongTuan[index]),
                      true),
                  _buildDetailRow(
                      'Số lượng case thực hiện trong tuần',
                      individualWork.soLuongCaseThucHienTrongTuan[index]
                          .toString(),
                      true),
                  _buildDetailRow(
                      'Số lượt case bị mở lại',
                      individualWork.soLuotCaseBiMoLai[index].toString(),
                      false),
                  _buildDetailRow(
                      'Số giờ ước lượng case',
                      MyFormatter.formatDouble(
                          individualWork.soGioUocLuongCase[index]),
                      true),
                  _buildDetailRow(
                      'Số giờ thực tế làm case',
                      MyFormatter.formatDouble(
                          individualWork.soGioThucTeLamCase[index]),
                      true),
                  _buildDetailRow(
                      'Số giờ tham gia meeting',
                      MyFormatter.formatDouble(
                          individualWork.soGioThamGiaMeeting[index]),
                      true),
                  _buildDetailRow(
                      'Phần trăm tỉ lệ mở case',
                      '${MyFormatter.formatDouble(individualWork.phanTramTiLeMoCase[index])}%',
                      false),
                  _buildDetailRow(
                      'Phần trăm tỉ lệ chênh lệch giờ thực tế và giờ ước lượng',
                      '${MyFormatter.formatDouble(individualWork.phanTramTiLeChenhLechUocLuongVaThucTe[index])}%',
                      true),
                  _buildDetailRow(
                      'Số giờ làm thiếu',
                      MyFormatter.formatDouble(
                          individualWork.soGioLamThieu[index]),
                      false),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value, bool isGood) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: MyColors.primaryTextColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 80),
          Container(
            decoration: BoxDecoration(
              color: isGood
                  ? MyColors.primaryColor.withOpacity(0.2)
                  : Colors.red.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: 12.0, vertical: 4.0), // Added vertical padding
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: isGood ? MyColors.primaryColor : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
