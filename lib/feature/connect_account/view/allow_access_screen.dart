import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/button.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/auth/view/widgets/background_modal.dart';
import 'package:zeeh_mobile/feature/auth/view/widgets/bar_header_widget.dart';
import 'package:zeeh_mobile/feature/connect_account/view/select_method_screen.dart';


class AllowAccessScreen extends StatefulWidget {
  const AllowAccessScreen({super.key});

  @override
  State<AllowAccessScreen> createState() => _AllowAccessScreenState();
}

class _AllowAccessScreenState extends State<AllowAccessScreen> {
  bool isSwitch = false;

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

              // Login
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
                      // Login
                      const BarHeaderWidget(
                        blackBars: 3,
                        greyBars: 1,
                      ),

                      // Credentials
                      SizedBox(height: 16.h),

                      // Full Name, Email Address, Phone Number
                      Container(
                        width: 375.w,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 24.h),

                              // Welcome Back!
                              GroteskText(
                                text: "Connect your account",
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(height: 10.h),

                              // Enter your email to sign in
                              SizedBox(
                                width: 310.w,
                                child: GroteskText(
                                  text:
                                      "Hi David, your identity has been verified. Now connect your account.",
                                  maxLines: 2,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                              // Email Address
                              SizedBox(height: 16.h),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 10.h),

                      Container(
                        width: 375.w,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 24.h),

                              // Welcome Back!
                              Column(
                                children: [
                                  AllowAccessWidget(
                                    title: "Check Balance",
                                    description: "Sync account balance",
                                    isSwitch: isSwitch,
                                  ),
                                  SizedBox(height: 16.h),
                                  AllowAccessWidget(
                                    title: "Check transactions",
                                    description: "Sync trancastion history",
                                    isSwitch: isSwitch,
                                  ),
                                ],
                              ),

                              SizedBox(height: 220.h),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GroteskText(
                                    text:
                                        "By clicking “Allow access”, you agree to ZeeH’s",
                                    fontSize: 12.sp,
                                  ),
                                  GroteskText(
                                    text: "Privacy policy",
                                    textColor: ZeehColors.buttonPurple,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                  ),
                                ],
                              ),

                              SizedBox(height: 10.h),

                              ZeehButton(
                                onClick: () => navigate(
                                    context, const SelectMethodScreen()),
                                text: "Continue",
                              ),

                              SizedBox(height: 30.h),
                            ],
                          ),
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

class AllowAccessWidget extends StatelessWidget {
  const AllowAccessWidget({
    super.key,
    required this.isSwitch,
    required this.title,
    required this.description,
  });

  final bool isSwitch;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0.w,
        vertical: 16.0.h,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: ZeehColors.greyColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(12.0.r),
      ),
      width: 375.w,
      height: 76.h,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GroteskText(
                text: title,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              GroteskText(
                text: description,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          const Spacer(),
          Switch.adaptive(
            value: isSwitch,
            onChanged: (_) {},
          ),
        ],
      ),
    );
  }
}
