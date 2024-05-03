import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/button.dart';
import 'package:zeeh_mobile/common/components/pin_otp_field.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/auth/view/forgot_pin/verify_forgot_pin_screen.dart';
import 'package:zeeh_mobile/feature/auth/view/widgets/header_widget.dart';

class SetNewPinScreen extends ConsumerStatefulWidget {
  const SetNewPinScreen({super.key});

  @override
  ConsumerState<SetNewPinScreen> createState() =>
      _ForgotPasswordVerifyCodeState();
}

class _ForgotPasswordVerifyCodeState extends ConsumerState<SetNewPinScreen> {
  TextEditingController pinController = TextEditingController();

  bool isPinEntered = false;

  late String pin;

  handleVerifyPin() {
    pin = pinController.text.trim().substring(0, 4);

    navigate(context, VerifyResetPinScreen(pin: pin));
  }

  @override
  void initState() {
    super.initState();

    pinController.addListener(() {
      setState(() {
        if (pinController.text.length == 4) {
          isPinEntered = true;
        } else {
          isPinEntered = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 812.h,
          width: 375.w,
          child: Stack(
            children: [
              Container(
                width: 375.w,
                decoration: BoxDecoration(
                  color: ZeehColors.onboardingBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    // Create Account
                    const HeaderWidget(
                      showBackButton: false,
                      screenTitle: "Enter New Pin",
                      showCancelButton: false,
                    ),

                    // Credentials
                    SizedBox(height: 10.h),

                    Divider(
                      height: 1.h,
                      color: ZeehColors.greyColor.withOpacity(0.5),
                    ),

                    // Pin
                    Container(
                      width: 375.w,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 48.h),
                            Image.asset(
                              ZeehAssets.shieldIcon,
                              height: 70.h,
                              width: 70.w,
                            ),

                            SizedBox(height: 16.h),

                            // Welcome Back!

                            // Enter your email to sign in
                            Column(
                              children: [
                                DMSanText(
                                  text:
                                      "Select a new 4 digit pin to Login to your account",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),

                            // Email Address
                            SizedBox(height: 16.h),

                            // Pin Code
                            PinOTPFieldWidget(
                              controller: pinController,
                              length: 4,
                              
                              obscureText: true,
                              fieldHeight: 56.h,
                              fieldWidth: 56.w,
                            ),

                            SizedBox(height: 24.h),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    Container(
                      width: 375.w,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 14.h),
                          ZeehButton(
                            onClick: () => handleVerifyPin(),
                            text: "Verify",
                            buttonColor: isPinEntered
                                ? ZeehColors.buttonPurple
                                : ZeehColors.greyColor,
                          ),
                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
