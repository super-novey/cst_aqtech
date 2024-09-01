
import 'package:flutter/material.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:hrm_aqtech/utils/constants/texts.dart';
import 'package:hrm_aqtech/utils/formatter/formatter.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            // Phương tiện di chuyển
            children: [
              const Icon(Icons.motorcycle_sharp),
              const SizedBox(
                width: MySizes.sm,
              ),
              Expanded(
                child: Text(
                  MyTexts.lorem,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .apply(color: MyColors.accentColor),
                ),
              )
            ],
          ),
        ),
        // Công tác phí
        Text(
          MyFormatter.formatCurrency(2000000),
          style: Theme.of(context).textTheme.headlineSmall,
        )
      ],
    );
  }
}
