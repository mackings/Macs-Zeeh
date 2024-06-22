import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zeeh_mobile/common/components/button.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/auth/view/login/login_screen.dart';
import 'package:zeeh_mobile/feature/auth/view/sign_up/create_account/create_account.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          "assets/images/onboarding_image1.svg",
          height: 340.h,
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
          child: Column(
            children: [
              GroteskText(
                text: "Easy way to manage your finances",
                textColor: Colors.white,
                fontSize: 32.sp,
                fontWeight: FontWeight.w500,
                maxLines: 2,
              ),
              SizedBox(height: 10.h),
              GroteskText(
                text:
                    "Features that can make it easier for you to save and plan finances for the future",
                textColor: const Color(0xffCECECE),
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget({
    super.key,
    this.title,
    this.title2,
    this.description,
    this.image,
  });

  final String? image;
  final String? title;
  final String? title2;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 812.h,
      width: 375.w,
      child: Stack(
        children: [
          // SizedBox(
          //   height: 406.h,
          //   width: double.infinity,
          //   child: FittedBox(
          //     fit: BoxFit.fill,
          //     child: Image.asset(
          //       image ?? ZeehAssets.thecc
          //     ),
          //   ),
          // ),
           SizedBox(
            height: 406.h,
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image.asset(
                image ?? ZeehAssets.thecc
              ),
            ),
          ),

          // Onboarding Image 1
          Positioned(
            top: 363.h,
            left: 24.w,
            child: Container(
              width: 327.w,
              height: 414.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(40.r),
                ),
                border: Border.all(
                  color: const Color(0xffEBEBEB),
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 40.h),
                    DMSanText(
                      text: title ?? "Easy way to generate",
                      textColor: Colors.black,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      maxLines: 2,
                    ),

                    // More Merit
                    DMSanText(
                      text: title2 ?? "your credit report",
                      textColor: Colors.black,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      maxLines: 3,
                    ),

                    SizedBox(height: 10.h),

                    // By connecting
                    SizedBox(
                      width: 280.w,
                      child: DMSanText(
                        text: description ??
                            "Features that makes it easier for you to get individual and business credit report.",
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        textColor: const Color(0xff5F6D7E),
                      ),
                    ),

                    SizedBox(height: 15.h),

                    // Sign Up
                    ZeehButton(
                      onClick: () => navigate(
                        context,
                        const CreateAccountScreen(),
                      ),
                      text: "Sign up",
                      width: 280.w,
                      height: 50.h,
                    ),

                    SizedBox(height: 15.h),

                    // Sign Up
                    AppOutlinedButton(
                      onPressed: () => navigate(
                        context,
                        const LoginScreen(),
                      ),
                      text: "Login",
                      width: 280.w,
                      height: 50.h,
                    ),

                    SizedBox(height: 40.h),

                    // By Clicking
                    Column(
                      children: [
                        DMSanText(
                          text: "By clicking “SIgn up”, you agree to ZeeH’s",
                          textColor: const Color(0x995F6D7E),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () => launchUrl(
                                Uri.parse(
                                    "https://www.zeeh.africa/legal/terms-of-use"),
                              ),
                              child: DMSanText(
                                text: "T&C ",
                                textColor: ZeehColors.buttonPurple,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            DMSanText(
                              text: "and",
                              textColor: const Color(0x995F6D7E),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            InkWell(
                              onTap: () => launchUrl(
                                Uri.parse(
                                    "https://www.zeeh.africa/legal/privacy-policy"),
                              ),
                              child: DMSanText(
                                text: " Privacy policy",
                                textColor: ZeehColors.buttonPurple,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
