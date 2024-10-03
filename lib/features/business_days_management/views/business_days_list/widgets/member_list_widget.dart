import 'package:flutter/material.dart';
import 'package:hrm_aqtech/common/widgets/container/rounded_container.dart';
import 'package:hrm_aqtech/features/business_days_management/models/member_model.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';

class MemberListWidget extends StatelessWidget {
  const MemberListWidget({
    super.key,
    required this.memberList,
  });

  final List<Member> memberList;

  @override
  Widget build(BuildContext context) {
    final a = memberList[0].getNameById();
    print(a);
    return SizedBox(
      width: double.infinity,
      height: 30,
      child: ListView.builder(
          itemCount: memberList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return FutureBuilder(
                future: memberList[index].getNameById(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // add shimmer
                  } else if (snapshot.hasData) {
                    return MyRoundedContainer(
                      margin: const EdgeInsets.only(right: MySizes.sm),
                      padding:
                          const EdgeInsets.symmetric(horizontal: MySizes.sm),
                      backgroundColor: MyColors.primaryColor,
                      child: Center(
                        child: Text(
                          snapshot.data.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .apply(color: Colors.white),
                        ),
                      ),
                    );
                  } else {
                    return const Text('...');
                  }
                });
          }),
    );
  }
}
