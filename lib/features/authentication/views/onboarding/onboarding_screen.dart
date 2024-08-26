import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/features/authentication/controllers/onboarding_controller.dart';
import 'package:hrm_aqtech/features/authentication/views/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:hrm_aqtech/features/authentication/views/onboarding/widgets/onboarding_next.dart';
import 'package:hrm_aqtech/features/authentication/views/onboarding/widgets/onboarding_page.dart';
import 'package:hrm_aqtech/features/authentication/views/onboarding/widgets/onboarding_skip.dart';
import 'package:hrm_aqtech/utils/constants/image_paths.dart';
import 'package:hrm_aqtech/utils/constants/texts.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    return Scaffold(
      body: Stack(
        children: [
          // Page View
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: MyImagePaths.onBoardingImage1,
                title: MyTexts.onBoardingTitle1,
                subTitle: MyTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: MyImagePaths.onBoardingImage2,
                title: MyTexts.onBoardingTitle2,
                subTitle: MyTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: MyImagePaths.onBoardingImage3,
                title: MyTexts.onBoardingTitle3,
                subTitle: MyTexts.onBoardingSubTitle3,
              ),
            ],
          ),

          // Smooth Indicator
          const OnBoardingDotNavigation(),
          // Next button
          const OnBoardingNext(),
          // Skip button
          const OnBoardingSkip()
        ],
      ),
    );
  }
}
