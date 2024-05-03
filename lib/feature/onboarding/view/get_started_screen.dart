import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zeeh_mobile/common/components/button.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/auth/view/login/login_screen.dart';
import 'package:zeeh_mobile/feature/auth/view/sign_up/create_account/create_account.dart';
import 'package:zeeh_mobile/feature/onboarding/view/widgets/almost_there_top_widget.dart';

class AlmostThereScreen extends StatefulWidget {
  const AlmostThereScreen({super.key});

  @override
  State<AlmostThereScreen> createState() => _AlmostThereScreenState();
}

class _AlmostThereScreenState extends State<AlmostThereScreen> {
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
              Positioned(
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      topRight: Radius.circular(16.r),
                    ),
                  ),
                  height: 679.h,
                  width: 375.w,
                  child: Column(
                    children: [
                      SizedBox(height: 16.h),
                      const AlmosThereTopWidget(),

                      SizedBox(height: 10.h),

                      // Sign Up Button
                      ZeehButton(
                        onClick: () => navigate(
                          context,
                          const CreateAccountScreen(),
                        ),
                        text: "Sign Up",
                      ),

                      SizedBox(height: 15.h),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                        child: Column(
                          children: [
                            // - or -
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 140.w,
                                  child: const Divider(
                                    thickness: 1,
                                    color: ZeehColors.greyColor,
                                  ),
                                ),
                                const Spacer(),
                                const GroteskText(
                                  text: "or",
                                  textColor: ZeehColors.blackColor,
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 140.w,
                                  child: const Divider(
                                    thickness: 1,
                                    color: ZeehColors.greyColor,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 16.h),

                            // Login
                            ZeehButton(
                              onClick: () => navigate(
                                context,
                                const LoginScreen(),
                              ),
                              isOutline: true,
                              borderColor: ZeehColors.greyColor,
                              buttonColor: Colors.white,
                              text: "Login",
                              fontWeight: FontWeight.w500,
                              textColor: ZeehColors.blackColor,
                            ),

                            SizedBox(height: 24.h),

                            // Terms and Condition
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GroteskText(
                                  text:
                                      "By clicking “SIgn up”, you agree to ZeeH’s ",
                                  fontSize: 14.sp,
                                ),
                                InkWell(
                                  onTap: () => launchUrl(
                                    Uri.parse(
                                        "https://www.zeeh.africa/legal/terms-of-use"),
                                  ),
                                  child: GroteskText(
                                    text: "T&C",
                                    textColor: ZeehColors.buttonPurple,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GroteskText(
                                  text: "and ",
                                  fontSize: 14.sp,
                                ),
                                InkWell(
                                  onTap: () {
                                    launchUrl(
                                      Uri.parse(
                                          "https://www.zeeh.africa/legal/privacy-policy"),
                                    );
                                  },
                                  child: GroteskText(
                                    text: "Privacy policy",
                                    textColor: ZeehColors.buttonPurple,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 16.h),

                            GroteskText(
                              text:
                                  "We use your data to offer you a personalized experience and to better understand and improve our services to you.",
                              textColor: ZeehColors.blackColor,
                              fontSize: 12.sp,
                              maxLines: 4,
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
