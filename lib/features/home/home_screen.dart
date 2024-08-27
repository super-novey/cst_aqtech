import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hrm_aqtech/common/widgets/container/rounded_container.dart';
import 'package:hrm_aqtech/common/widgets/header/circular_container.dart';
import 'package:hrm_aqtech/common/widgets/header/primary_header_container.dart';
import 'package:hrm_aqtech/common/widgets/texts/section_heading.dart';
import 'package:hrm_aqtech/features/employee_management/views/employee_list/employee_list_screen.dart';
import 'package:hrm_aqtech/features/home/widgets/home_appbar.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MyPrimaryHeaderContainer(
                child: Column(
              children: [
                MyHomeAppBar(),
                SizedBox(
                  height: MySizes.spaceBtwItems,
                ),
                Padding(
                  padding: EdgeInsets.all(MySizes.defaultSpace),
                  child: MyRoundedContainer(
                    width: double.infinity,
                    padding: EdgeInsets.all(MySizes.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MySectionHeading(
                            textColor: MyColors.dartPrimaryColor,
                            title: "Kết quả định lượng công việc trong năm"),
                        SizedBox(
                          height: MySizes.spaceBtwItems,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.workspace_premium_sharp,
                              color: MyColors.secondaryTextColor,
                            ),
                            Expanded(
                              child: Text(
                                'Tổng số ngày làm việc trong tuần (cố định):',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: MySizes.spaceBtwItems,
                            ),
                            MyCicularContainer(
                              width: 25,
                              height: 25,
                              child: Center(child: Text("2")),
                            )
                          ],
                        ),
                        SizedBox(
                          height: MySizes.spaceBtwItems,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.lock_clock,
                              color: MyColors.secondaryTextColor,
                            ),
                            Expanded(
                              child: Text(
                                'Tổng số giờ làm việc trong ngày (Theo cá nhân):',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: MySizes.spaceBtwItems,
                            ),
                            MyCicularContainer(
                              width: 25,
                              height: 25,
                              child: Center(child: Text("2")),
                            )
                          ],
                        ),
                        SizedBox(
                          height: MySizes.spaceBtwItems,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.beach_access,
                              color: MyColors.secondaryTextColor,
                            ),
                            Expanded(
                              child: Text(
                                'Tổng số ngày nghỉ phép cá nhân, lễ, tết, nghỉ chung:',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: MySizes.spaceBtwItems,
                            ),
                            MyCicularContainer(
                              width: 25,
                              height: 25,
                              child: Center(child: Text("2")),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MySizes.spaceBtwSections,
                )
              ],
            )),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: MySizes.defaultSpace),
              child: Column(
                children: [
                  MySectionHeading(
                    title: "Danh sách nhân viên",
                    showActionButton: true,
                    onPressed: () {
                      Get.to(const EmployeeListScreen());
                    },
                  ),
                  const Divider(
                    color: MyColors.dividerColor,
                  ),
                  const MySectionHeading(title: "Quản lý ngày nghỉ")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
