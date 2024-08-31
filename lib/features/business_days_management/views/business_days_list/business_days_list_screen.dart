import 'package:flutter/material.dart';
import 'package:hrm_aqtech/common/widgets/appbar/appbar.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class BusinessDaysListScreen extends StatelessWidget {
  const BusinessDaysListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        showBackArrow: true,
        iconColor: MyColors.primaryTextColor,
        title: Text(
          "Quản lý ngày công tác",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add,
                color: MyColors.primaryTextColor,
              ))
        ],
      ),
      body: Column(
        children: [
          // Lọc ngày

          // Listview hiển thị danh sách các ngày công tác

          // 
        ],
      ),
    );
  }
}
