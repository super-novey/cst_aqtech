import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/time_off_management/controllers/date_time_picker_controller.dart';
import 'package:hrm_aqtech/features/time_off_management/controllers/filter_controller.dart';
import 'package:intl/intl.dart';
import 'package:hrm_aqtech/utils/devices/device_utils.dart';

class FilterWidget extends StatelessWidget implements PreferredSizeWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTimePickerController dateTimePickerController =
        Get.put(DateTimePickerController());

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4, left: 4, right: 4),
            color: Colors.white,
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Lọc từ ngày:"),
                          Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8, bottom: 1),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Obx(() {
                                      return TextFormField(
                                        readOnly: true,
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          hintText: dateTimePickerController
                                                      .startDate.value ==
                                                  null
                                              ? 'Chọn ngày'
                                              : DateFormat('dd/MM/yyyy').format(
                                                  dateTimePickerController
                                                      .startDate.value!),
                                          hintStyle: TextStyle(
                                              color: Colors.grey[410]),
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                      );
                                    }),
                                  ),
                                  IconButton(
                                    onPressed: () => dateTimePickerController
                                        .selectStartDate(context),
                                    icon: const Icon(
                                        Icons.calendar_month_rounded),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: () =>
                                dateTimePickerController.clearDates(),
                            label: const Text("Clear",
                                style: TextStyle(color: Colors.black)),
                            icon: const Icon(Icons.filter_alt_off,
                                color: Colors.black),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: Colors.grey, width: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              
                            ),
                            
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text("Lọc đến ngày:"),
                          Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8, bottom: 1),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Obx(() {
                                      return TextFormField(
                                        readOnly: true,
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          hintText: dateTimePickerController
                                                      .endDate.value ==
                                                  null
                                              ? 'Chọn ngày'
                                              : DateFormat('dd/MM/yyyy').format(
                                                  dateTimePickerController
                                                      .endDate.value!),
                                          hintStyle: TextStyle(
                                              color: Colors.grey[410]),
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                      );
                                    }),
                                  ),
                                  IconButton(
                                    onPressed: () => dateTimePickerController
                                        .selectEndDate(context),
                                    icon: const Icon(
                                        Icons.calendar_month_rounded),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: () {
                              FilterController controller = Get.find();
                              controller.filter();
                            },
                            label: const Text("Tìm kiếm",
                                style: TextStyle(color: Colors.black)),
                            icon: const Icon(Icons.search, color: Colors.black),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: Colors.grey, width: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(MyDeviceUtils.getAppBarHeight() * 3);
}
