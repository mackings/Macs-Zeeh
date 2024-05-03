import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/auth/view/widgets/background_modal.dart';
import 'package:zeeh_mobile/feature/auth/view/widgets/bar_header_widget.dart';
import 'package:zeeh_mobile/feature/connect_account/view/widget/top_up_radio.dart';

import '../../../common/components/currency_function.dart';

class ConnectAccountScreen extends StatefulWidget {
  const ConnectAccountScreen({super.key});

  @override
  State<ConnectAccountScreen> createState() => _ConnectAccountScreenState();
}

class _ConnectAccountScreenState extends State<ConnectAccountScreen> {
  AccountChoice _accountChoice = AccountChoice.none;

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

                      SizedBox(height: 16.h),

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
                              text: "Select an account",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 10.h),

                            // Enter your email to sign in
                            SizedBox(
                              width: 310.w,
                              child: GroteskText(
                                text:
                                    "Choose the account you would like to use to setup your credit score.",
                                maxLines: 3,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                textColor: const Color(0xff101828),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Email Address
                      SizedBox(height: 16.h),

                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 24.h),

                              // Account Name
                              const Row(
                                children: [
                                  GroteskText(
                                    text: "Account Name:",
                                  ),
                                  Spacer(),
                                  GroteskText(
                                    text: "David Adebola",
                                    fontWeight: FontWeight.w500,
                                  )
                                ],
                              ),

                              SizedBox(height: 40.h),

                              // Account Number
                              Row(
                                children: [
                                  SvgPicture.asset(ZeehAssets.gtbankIcon),
                                  SizedBox(width: 8.w),
                                  GroteskText(
                                    text: "Guaranty Trust Bank",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ],
                              ),

                              SizedBox(height: 24.h),

                              // Savings, Current, Others

                              Wrap(
                                runSpacing: 16.h,
                                children: [
                                  Container(
                                    height: 80.h,
                                    padding: EdgeInsets.all(16.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(
                                        color: const Color(0xffCBD5E4),
                                      ),
                                    ),
                                    child: ProductLabeledRadio(
                                      title: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const GroteskText(
                                              text: "Savings",
                                              textColor:
                                                  ZeehColors.greyColor900,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            const Spacer(),
                                            GroteskText(
                                              text: "0123127823",
                                              fontSize: 14.sp,
                                            )
                                          ],
                                        ),
                                        SizedBox(width: 70.w),
                                        Padding(
                                          padding: EdgeInsets.only(top: 20.0.h),
                                          child: SpaceGroteskText(
                                            text:
                                                "₦ ${amountFormatter(280520.80)}",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                      groupValue: _accountChoice,
                                      value: AccountChoice.none,
                                      onChanged: (AccountChoice value) {
                                        setState(() {
                                          _accountChoice = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 80.h,
                                    padding: EdgeInsets.all(16.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(
                                        color: const Color(0xffCBD5E4),
                                      ),
                                    ),
                                    child: ProductLabeledRadio(
                                      title: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const GroteskText(
                                              text: "Current",
                                              textColor:
                                                  ZeehColors.greyColor900,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            const Spacer(),
                                            GroteskText(
                                              text: "0123127823",
                                              fontSize: 14.sp,
                                            )
                                          ],
                                        ),
                                        SizedBox(width: 70.w),
                                        Padding(
                                          padding: EdgeInsets.only(top: 20.0.h),
                                          child: SpaceGroteskText(
                                            text:
                                                "₦ ${amountFormatter(280520.80)}",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                      groupValue: _accountChoice,
                                      value: AccountChoice.none,
                                      onChanged: (AccountChoice value) {
                                        setState(() {
                                          _accountChoice = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 80.h,
                                    padding: EdgeInsets.all(16.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(
                                        color: const Color(0xffCBD5E4),
                                      ),
                                    ),
                                    child: ProductLabeledRadio(
                                      title: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const GroteskText(
                                              text: "Others",
                                              textColor:
                                                  ZeehColors.greyColor900,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            const Spacer(),
                                            GroteskText(
                                              text: "0123127823",
                                              fontSize: 14.sp,
                                            )
                                          ],
                                        ),
                                        SizedBox(width: 70.w),
                                        Padding(
                                          padding: EdgeInsets.only(top: 20.0.h),
                                          child: SpaceGroteskText(
                                            text:
                                                "₦ ${amountFormatter(280520.80)}",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                      groupValue: _accountChoice,
                                      value: AccountChoice.none,
                                      onChanged: (AccountChoice value) {
                                        setState(() {
                                          _accountChoice = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 65.h),

                              // Linked Account Button
                              // ZeehButton(
                              //   onClick: () => navigate(
                              //     context,
                              //      ConnectAccountSuccessScreen(userId: ,),
                              //   ),
                              //   text: "Link Account",
                              // ),
                            ],
                          ),
                        ),
                      )
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

enum AccountChoice { none, savings, current, other }
