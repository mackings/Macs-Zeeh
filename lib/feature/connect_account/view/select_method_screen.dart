import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeeh_mobile/common/components/button.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/auth/view/widgets/background_modal.dart';
import 'package:zeeh_mobile/feature/auth/view/widgets/bar_header_widget.dart';
import 'package:zeeh_mobile/feature/connect_account/view/widget/select_app_modal.dart';
import 'package:zeeh_mobile/feature/connect_account/view/widget/top_up_radio.dart';

class SelectMethodScreen extends StatefulWidget {
  const SelectMethodScreen({super.key});

  @override
  State<SelectMethodScreen> createState() => _SelectMethodScreenState();
}

class _SelectMethodScreenState extends State<SelectMethodScreen> {
  ProductChoice _productChoice = ProductChoice.none;

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
                                text: "Select your connection method",
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(height: 10.h),

                              // Enter your email to sign in
                              SizedBox(
                                width: 310.w,
                                child: GroteskText(
                                  text:
                                      "Choose the method you would like to use to connect your GTB account.",
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
                              Container(
                                height: 76.h,
                                padding: EdgeInsets.symmetric(horizontal: 13.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: ZeehColors.buttonPurple,
                                  ),
                                ),
                                child: ProductLabeledRadio(
                                  title: [
                                    SvgPicture.asset(ZeehAssets.mobileIcon),
                                    SizedBox(width: 10.w),
                                    const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GroteskText(
                                          text: "Mobile App",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                  ],
                                  groupValue: _productChoice,
                                  value: ProductChoice.none,
                                  onChanged: (ProductChoice value) {
                                    setState(() {
                                      _productChoice = value;
                                    });
                                  },
                                ),
                              ),

                              SizedBox(height: 320.h),

                              // End User Agreement
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GroteskText(
                                    text:
                                        "By clicking 'Continue', you agree to ZeeH’s ",
                                    fontSize: 10.sp,
                                  ),
                                  GroteskText(
                                    text: "End User Agreement",
                                    textColor: ZeehColors.buttonPurple,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10.sp,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.sp),
                              ZeehButton(
                                onClick: () => showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  builder: (context) =>
                                      const SelectAppContainer(),
                                ),
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

enum ProductChoice {
  none,

  mobile_app,
}
