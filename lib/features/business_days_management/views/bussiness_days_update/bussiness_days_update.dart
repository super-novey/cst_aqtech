import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/appbar/appbar.dart';
import 'package:hrm_aqtech/common/widgets/container/rounded_container.dart';
import 'package:hrm_aqtech/features/business_days_management/controllers/update_business_day_controller.dart';
import 'package:hrm_aqtech/features/business_days_management/models/business_date_model.dart';
import 'package:hrm_aqtech/features/business_days_management/views/bussiness_days_update/widgets/bussiness_date_field.dart';
import 'package:hrm_aqtech/features/employee_management/models/assigned_employee.dart';
import 'package:hrm_aqtech/features/employee_management/models/employee_model.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';

class BussinessDaysUpdate extends StatelessWidget {
  const BussinessDaysUpdate({super.key, required this.businessDate});

  final BusinessDate businessDate;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateBusinessDayController());
//     final formatDayController = Get.put(FormatDayController());
    

//     // Lấy giá trị `sumDay` từ controller và format nó
//     final double sumDayValue = controller.sumDay.value.text.isNotEmpty
//         ? double.parse(controller.sumDay.value.text)
//         : 0.0;
// final TextEditingController sumDayController = TextEditingController();
//     // Định dạng giá trị và gán cho TextEditingController
//     sumDayController.text = formatDayController.formatDayController(sumDayValue);

    controller.init(businessDate);

    return Scaffold(
        appBar: MyAppBar(
          showBackArrow: true,
          iconColor: MyColors.primaryTextColor,
          title: Text(
            "Thông tin ngày công tác",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  controller.save(businessDate);
                },
                icon: const Icon(
                  Icons.save,
                  color: MyColors.accentColor,
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(MySizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ngày bắt đầu - Ngày kết thúc",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(fontWeightDelta: 2),
                ),
                // Ngày bắt đầu - Ngày kết thúc
                Row(
                  children: [
                    Expanded(
                      child: MyRoundedContainer(
                        padding: const EdgeInsets.all(12),
                        borderColor: Colors.grey,
                        showBorder: true,
                        radius: MySizes.borderRadiusLg,
                        child: Obx(
                          () => Text(
                            "${MyFormatter.formatDateTime(controller.dateRangeController.dateRange.value.start)} - ${MyFormatter.formatDateTime(controller.dateRangeController.dateRange.value.end)}",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: MySizes.spaceBtwItems,
                    ),
                    MyRoundedContainer(
                      backgroundColor: MyColors.dartPrimaryColor,
                      child: IconButton(
                          onPressed: () {
                            controller.dateRangeController
                                .showRangeDatePicker();
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: MySizes.spaceBtwItems,
                ),

                // Số ngày công tác
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Số lượng ngày công tác",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(fontWeightDelta: 2),
                    ),
                    Obx(
                      () => TextField(
                        // keyboardType: const TextInputType.numberWithOptions(
                        //     decimal: true, signed: true),
                        controller: controller.sumDay.value,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,1}')),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: MySizes.spaceBtwItems,
                ),

                // Nôi dung công tác
                BussinessDateField(
                  title: "Nội dung công tác",
                  controller: controller.commissionContent,
                ),
                const SizedBox(
                  height: MySizes.spaceBtwItems,
                ),
                // Phương tiện
                BussinessDateField(
                  title: "Phương tiện",
                  controller: controller.transportation,
                ),
                const SizedBox(
                  height: MySizes.spaceBtwItems,
                ),
                // Danh sách đi công tác
                Text(
                  "Danh sách đi công tác",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(fontWeightDelta: 2),
                ),
                Obx(
                  () => ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller
                        .memberListController.memberNameController.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Row(
                          children: [
                            // Drop down
                            Expanded(
                              flex: 3,
                              child: MyRoundedContainer(
                                showBorder: true,
                                borderColor: Colors.grey,
                                radius: MySizes.borderRadiusLg,
                                child: DropdownButtonHideUnderline(
                                  child: Obx(
                                    () => DropdownButton(
                                      value: controller.memberListController
                                          .memberNameController[index],
                                      dropdownColor: MyColors.iconColor,
                                      items: controller
                                          .memberListController.allEmployees
                                          .map<DropdownMenuItem<AssignedEmployee>>(
                                              (AssignedEmployee value) {
                                        return DropdownMenuItem<AssignedEmployee>(
                                          value: value,
                                          child: Text(
                                            value.fullName,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (AssignedEmployee? value) {
                                        if (value != null) {
                                          controller.memberListController
                                                  .memberNameController[index] =
                                              value;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                flex: 1,
                                child: TextField(
                                  controller: controller.memberListController
                                      .memberExpensesController[index],
                                  //keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                                onPressed: () {
                                  controller.memberListController.remove(index);
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                )),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                Obx(
                  () => (controller.isLoading.value)
                      ? const Center(child: CircularProgressIndicator())
                      : SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                              onPressed: () {
                                controller.memberListController.add();
                              },
                              child: Text(
                                "Thêm nhân sự",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .apply(
                                        color: MyColors.dartPrimaryColor,
                                        fontWeightDelta: 3),
                              ))),
                ),

                const SizedBox(
                  height: MySizes.spaceBtwItems,
                ),

                // Chi phí công tác
                Text(
                  "Chi phí công tác",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(fontWeightDelta: 2),
                ),
                TextField(
                  controller: controller.commissionExpenses,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                ),
                const SizedBox(
                  height: MySizes.spaceBtwItems,
                ),

                // Ghi chú
                Text(
                  "Ghi chú",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(fontWeightDelta: 2),
                ),
                TextField(
                  controller: controller.note,
                  maxLines: 10,
                )

                // Ghi chú chi phí công tác
              ],
            ),
          ),
        ));
  }
}
