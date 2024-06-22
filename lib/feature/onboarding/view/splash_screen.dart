import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/onboarding/view/onboarding_screen1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
     const Duration(seconds: 3),
   //  const Duration(minutes: 2),
      () {
        navigateReplace(context, const OnboardingScreen());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZeehColors.onboardingBackground,
      body: SizedBox(
        height: 812.h,
        width: 375.w,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                ZeehAssets.finnacleIcon,
                height: 120.h,
                width: 216.w,
              ),
              SizedBox(height: 8.h),
              GroteskText(
                text: "Finnacle",
                fontSize: 40.sp,
                textColor: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
