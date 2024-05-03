import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/button.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/auth/view/login/login_screen.dart';
import 'package:zeeh_mobile/feature/auth/view/widgets/header_widget.dart';

class ResetPinSuccessScreen extends StatefulWidget {
  const ResetPinSuccessScreen({super.key});

  @override
  State<ResetPinSuccessScreen> createState() => _ResetPinSuccessScreenState();
}

class _ResetPinSuccessScreenState extends State<ResetPinSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: 812.h,
          width: 375.w,
          child: Column(
            children: [
              SizedBox(height: 60.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                child: Row(
                  children: [
                    Image.asset(
                      ZeehAssets.roundedZeehLogo,
                      height: 35.h,
                      width: 35.w,
                    ),
                  ],
                ),
              ),
              const HeaderWidget(
                showBackButton: false,
                screenTitle: "Enter New Pin",
                showCancelButton: false,
              ),
              SizedBox(height: 10.h),
              Divider(
                height: 1.h,
                color: ZeehColors.greyColor.withOpacity(0.5),
              ),
              SizedBox(height: 150.h),
              Image.asset(
                ZeehAssets.successIcon,
                height: 100.h,
                width: 100.w,
              ),
              SizedBox(height: 30.h),
              DMSanText(
                text: "Reset successfully",
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 15.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: SizedBox(
                  width: double.infinity,
                  child: DMSanText(
                    text:
                        "Your pin has been changed successfully. Return to the login screen to login withyour new pin.",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    maxLines: 4,
                    textColor: const Color(0xFF242739),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 150.h),
              ZeehButton(
                onClick: () => {
                  navigateReplace(
                    context,
                    const LoginScreen(),
                  ),
                },
                text: "Login",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
