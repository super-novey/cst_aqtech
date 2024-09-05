import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/online_work_management/controllers/date_range_online_work_controller.dart';
import 'package:hrm_aqtech/features/online_work_management/controllers/online_work_day_controller.dart';

class DateRangeOnlineWorkWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const DateRangeOnlineWorkWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final dateRangeOnlineWorkController =
        Get.put(DateRangeOnlineWorkController()); // Lấy controller
    final onlineWorkDayController = Get.put(OnlineWorkDayController());

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
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
                                          hintText:
                                              "${dateRangeOnlineWorkController.dateRange.value.start.day}/${dateRangeOnlineWorkController.dateRange.value.start.month}/${dateRangeOnlineWorkController.dateRange.value.start.year}",
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
                                    onPressed: () =>
                                        dateRangeOnlineWorkController
                                            .pickDateRange(context),
                                    icon: const Icon(
                                        Icons.calendar_month_rounded),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: () {
                              dateRangeOnlineWorkController.updateDateRange(
                                DateTimeRange(
                                  start: DateTime(DateTime.now().year, 1, 1),
                                  end: DateTime.now(),
                                ),
                              );
                            },
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4), // Điều chỉnh padding
                              minimumSize: const Size(130, 40),
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
                                          hintText:
                                              "${dateRangeOnlineWorkController.dateRange.value.end.day}/${dateRangeOnlineWorkController.dateRange.value.end.month}/${dateRangeOnlineWorkController.dateRange.value.end.year}",
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
                                    onPressed: () =>
                                        dateRangeOnlineWorkController
                                            .pickDateRange(context),
                                    icon: const Icon(
                                        Icons.calendar_month_rounded),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: () async {
                              await onlineWorkDayController
                                  .fetchFilteredOnlineWorkDays();
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4), // Điều chỉnh padding
                              minimumSize: const Size(130, 40),
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
  Size get preferredSize => const Size.fromHeight(150);
}
