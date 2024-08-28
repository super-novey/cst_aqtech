import 'package:flutter/material.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';

class MyVerticalImageText extends StatelessWidget {
  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;

  const MyVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = MyColors.primaryTextColor,
    this.backgroundColor = Colors.white,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: MySizes.spaceBtwItems),
        child: Column(
          children: [
            // circular icon
            Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(MySizes.sm),
              decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(100)),
              child: Center(
                child: Image(
                  width: 32,
                  height: 32,
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                  // color: Colors.white,
                ),
              ),
            ),

            // Text
            const SizedBox(
              height: MySizes.spaceBtwItems / 2,
            ),
            Text(
              textAlign: TextAlign.center,
              title,
              style: Theme.of(context).textTheme.labelMedium!.apply(
                    color: textColor,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
