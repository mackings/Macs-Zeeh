import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/onboarding/view/widgets/onboarding1.dart';
import 'package:zeeh_mobile/routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const route = ScreenPaths.onboardingScreen;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZeehColors.onboardingBackground,
      body: SizedBox(
        height: 812.h,
        width: 375.w,
        child: Stack(
          children: [
            OnbaoardingPageView(controller: controller),
            Positioned(
              top: 70.h,
              left: 24.w,
              child: IndicatorWidget(
                controller: controller,
              ),
            ),
          ],
        ),
      ),
    );





    // V Code
    // Scaffold(
    //   backgroundColor: ZeehColors.onboar dingBackground,
    //   body: Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     children: [
    //       SizedBox(
    //         height: 80.h,
    //       ),
    //       Padding(
    //         padding: EdgeInsets.symmetric(horizontal: 24.0.w),
    //         child: Row(
    //           children: [
    //             IndicatorWidget(controller: controller),
    //             const Spacer(),
    //             TextButton(
    //               onPressed: () => navigate(context, const AlmostThereScreen()),
    //               child: const GroteskText(
    //                 text: "Skip",
    //                 textColor: Colors.white,
    //                 fontWeight: FontWeight.w500,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       SizedBox(
    //         height: 45.h,
    //       ),

    //       // Page View
    //       SizedBox(
    //         height: 500.h,
    //         child: OnbaoardingPageView(
    //           controller: controller,
    //         ),
    //       ),

    //       SizedBox(
    //         height: 45.h,
    //       ),

    //       ZeehButton(
    //         onClick: () => navigate(context, const AlmostThereScreen()),
    //         text: "Get Started",
    //       ),
    //     ],
    //   ),
    // );


    
  }
}

// Page View
class OnbaoardingPageView extends StatelessWidget {
  final PageController controller;

  const OnbaoardingPageView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      children: const [
       //OnboardingWidget(),

        OnboardingWidget(
         // image: ZeehAssets.amaz,
         image: ZeehAssets.amaze,
          title: "Easy way to generate", 
          title2: "your credit report",
          description:
              "Features that makes it easier for you to get individual and business credit report.",
        ),

        OnboardingWidget(
          image: ZeehAssets.onboardingImage2V2,
          title: "Easy way to manage",
          title2: "your finances",
          description:
              "Features that can make it easier for you to save and plan finances for the future",
        ),

        OnboardingWidget(
          image: ZeehAssets.onboardingImage3V2,
          title: "Investment got",
          title2: "Easier",
          description:
              "Enjoy commission free stock trading. Online investing has never been easy than it is right now",
        ),

      ],
    );
  }
}

// Indicator Widget
class IndicatorWidget extends StatelessWidget {
  const IndicatorWidget({
    super.key,
    required this.controller,
  });

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: 3,
      effect: ExpandingDotsEffect(
        activeDotColor: const Color(0xffD9D9D9),
        dotColor: const Color(0xff4F5057),
        dotHeight: 8.h,
        dotWidth: 8.h,
      ),
    );
  }
}
