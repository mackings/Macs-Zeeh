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
import 'package:zeeh_mobile/feature/connect_account/view/allow_access_screen.dart';

class SelectBankScreen extends StatefulWidget {
  const SelectBankScreen({super.key});

  @override
  State<SelectBankScreen> createState() => _SelectBankScreenState();
}

class _SelectBankScreenState extends State<SelectBankScreen> {
  int tabToggleValue = 1;

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
                              GroteskText(
                                text: "Select your bank",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),

                              SizedBox(height: 16.h),

                              Container(
                                height: 54.h,
                                padding:
                                    EdgeInsets.symmetric(horizontal: 8.0.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                    color: ZeehColors.greyColor,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Banks
                                    ZeehButton(
                                      onClick: () {
                                        toggleTabs("banks");
                                      },
                                      text: "Banks",
                                      textColor: tabToggleValue == 2
                                          ? ZeehColors.grayColor
                                          : Colors.white,
                                      height: 38.h,
                                      width: 145.w,
                                      radius: 2.r,
                                      buttonColor: tabToggleValue == 1
                                          ? ZeehColors.blackColor
                                          : Colors.white,
                                    ),
                                    ZeehButton(
                                      onClick: () {
                                        toggleTabs("fintech");
                                      },
                                      text: "Fintech",
                                      textColor: tabToggleValue == 1
                                          ? ZeehColors.grayColor
                                          : Colors.white,
                                      height: 38.h,
                                      width: 145.w,
                                      radius: 2.r,
                                      buttonColor: tabToggleValue == 2
                                          ? ZeehColors.blackColor
                                          : Colors.white,
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 16.h),

                              // Textfield
                              const TextFieldBox(
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: ZeehColors.greyColor,
                                ),
                                hintText: "Search by name",
                              ),

                              SizedBox(height: 32.h),
                            ],
                          ),
                        ),
                      ),
                      const Divider(),

                      Container(
                        color: Colors.white,
                        height: 280.h,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              if (tabToggleValue == 1)
                                ...List.generate(
                                  5,
                                  (index) => SizedBox(
                                    child: InkWell(
                                      onTap: () => navigate(
                                        context,
                                        const AllowAccessScreen(),
                                      ),
                                      child: Column(
                                        children: [
                                          const Divider(),
                                          SizedBox(height: 5.w),
                                          Row(
                                            children: [
                                              SizedBox(width: 24.w),
                                              SvgPicture.asset(
                                                  ZeehAssets.firstBankIcon),
                                              SizedBox(width: 16.w),
                                              GroteskText(
                                                text: "First Bank of Nigeria",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.sp,
                                              ),
                                              const Spacer(),
                                              const Icon(
                                                Icons.chevron_right_rounded,
                                                color: ZeehColors.grayColor,
                                              ),
                                              SizedBox(width: 24.w),
                                            ],
                                          ),
                                          SizedBox(height: 5.w),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              if (tabToggleValue == 2)
                                ...List.generate(
                                  5,
                                  (index) => SizedBox(
                                    child: InkWell(
                                      onTap: () => navigate(
                                        context,
                                        const AllowAccessScreen(),
                                      ),
                                      child: Column(
                                        children: [
                                          const Divider(),
                                          SizedBox(height: 5.w),
                                          Row(
                                            children: [
                                              SizedBox(width: 24.w),
                                              SvgPicture.asset(
                                                  ZeehAssets.zenithBankIcon),
                                              SizedBox(width: 16.w),
                                              GroteskText(
                                                text: "Zenith Bank",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.sp,
                                              ),
                                              const Spacer(),
                                              const Icon(
                                                Icons.chevron_right_rounded,
                                                color: ZeehColors.grayColor,
                                              ),
                                              SizedBox(width: 24.w),
                                            ],
                                          ),
                                          SizedBox(height: 5.w),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                      const Divider(),
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

  // Toggle Tabs
  void toggleTabs(item) {
    if (item == "banks") {
      setState(() {
        tabToggleValue = 1;
      });
    } else if (item == "fintech") {
      setState(() {
        tabToggleValue = 2;
      });
    }
  }
}
