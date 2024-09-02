import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/appbar/appbar.dart';
import 'package:hrm_aqtech/common/widgets/container/rounded_container.dart';
import 'package:hrm_aqtech/features/business_days_management/controllers/member_list_controller.dart';
import 'package:hrm_aqtech/features/business_days_management/controllers/new_date_range_controller.dart';
import 'package:hrm_aqtech/features/business_days_management/views/bussiness_days_update/widgets/bussiness_date_field.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';

class BussinessDaysUpdate extends StatelessWidget {
  const BussinessDaysUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    final dateRangeController = Get.put(NewDateRangeController());
    final memberListController = Get.put(MemberListController());

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
              onPressed: () {},
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
                          "${MyFormatter.formatDateTime(dateRangeController.dateRange.value.start)} - ${MyFormatter.formatDateTime(dateRangeController.dateRange.value.end)}",
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
                          dateRangeController.showRangeDatePicker();
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
                  TextField(
                    // keyboardType: const TextInputType.numberWithOptions(
                    //     decimal: true, signed: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,1}')),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: MySizes.spaceBtwItems,
              ),

              // Nôi dung công tác
              const BussinessDateField(
                title: "Nội dung công tác",
              ),
              const SizedBox(
                height: MySizes.spaceBtwItems,
              ),
              // Phương tiện
              const BussinessDateField(
                title: "Phương tiện",
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
                  itemCount:
                      memberListController.memberExpensesController.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Row(
                        children: [
                          // Drop down
                          Expanded(
                            child: MyRoundedContainer(
                              showBorder: true,
                              borderColor: Colors.grey,
                              radius: MySizes.borderRadiusLg,
                              child: DropdownButtonHideUnderline(
                                child: Obx(
                                  () => DropdownButton(
                                    value: memberListController
                                        .memberNameController[index],
                                    dropdownColor: MyColors.iconColor,
                                    items: memberListController.names
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      if (value != null) {
                                        memberListController
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
                              child: TextField(
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
                                memberListController.remove(index);
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

              SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                      onPressed: () {
                        memberListController.add();
                      },
                      child: Text(
                        "Thêm nhân sự",
                        style: Theme.of(context).textTheme.headlineSmall!.apply(
                            color: MyColors.dartPrimaryColor,
                            fontWeightDelta: 3),
                      ))),
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
              const TextField(
                maxLines: 10,
              )

              // Ghi chú chi phí công tác
            ],
          ),
        ),
      ),
    );
  }
}
