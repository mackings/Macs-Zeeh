import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeeh_mobile/common/components/button.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/components/textfield_box.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/auth/view/widgets/background_modal.dart';
import 'package:zeeh_mobile/feature/auth/view/widgets/bar_header_widget.dart';
import 'package:zeeh_mobile/feature/connect_account/view/connect_screen.dart';

class EnterCredentialsScreen extends StatefulWidget {
  const EnterCredentialsScreen({super.key});

  @override
  State<EnterCredentialsScreen> createState() => _EnterCredentialsScreenState();
}

class _EnterCredentialsScreenState extends State<EnterCredentialsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZeehColors.onboardingBackground,
      body: SingleChildScrollView(
        child: SizedBox(
          height: 812.h,
          width: 375.w,
          child: Stack(
            children: [
              const BackgroundModal(),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 750.h,
                  width: 375.w,
                  decoration: BoxDecoration(
                    color: const Color(0xffF8F9FD),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      topRight: Radius.circular(16.r),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Enter your credentials
                      const BarHeaderWidget(
                        blackBars: 4,
                        greyBars: 0,
                      ),

                      // Credentials
                      SizedBox(height: 16.h),

                      // Full Name, Email Address, Phone Number
                      Container(
                        width: 375.w,
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 24.h),

                            // Welcome Back!
                            GroteskText(
                              text: "Enter your credentials",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 10.h),

                            // Enter your email to sign in
                            SizedBox(
                              width: 310.w,
                              child: GroteskText(
                                text:
                                    "By entering your GTBank credentials here, you’re authorising ZeeH to share your financial data with Pinnacky.",
                                maxLines: 3,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                textColor: const Color(0xff101828),
                              ),
                            ),

                            // Email Address
                            SizedBox(height: 16.h),
                          ],
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // Credentials
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                          child: Column(
                            children: [
                              SizedBox(height: 24.h),

                              //
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GroteskText(
                                    text: "Email",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),

                                  // Textfield
                                  SizedBox(height: 10.h),

                                  // Textfield
                                  const TextFieldBox(
                                    hintText: "David@pinnaky.com",
                                  ),
                                ],
                              ),

                              SizedBox(height: 16.h),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GroteskText(
                                    text: "Password or PIN",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),

                                  // Textfield
                                  SizedBox(height: 10.h),

                                  // Textfield
                                  const TextFieldBox(
                                    hintText: "*****",
                                  ),
                                ],
                              ),

                              SizedBox(height: 220.h),

                              // Buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    ZeehAssets.padlockIcon,
                                    color: ZeehColors.grayColor,
                                    height: 12.h,
                                    width: 11.w,
                                  ),
                                  GroteskText(
                                    text: "Secured by ",
                                    fontSize: 12.sp,
                                  ),
                                  GroteskText(
                                    text: "ZeeH",
                                    fontSize: 12.sp,
                                    textColor: ZeehColors.buttonPurple,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),

                              SizedBox(height: 10.h),

                              ZeehButton(
                                onClick: () => navigate(
                                    context, const ConnectAccountScreen()),
                                text: "Continue",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
