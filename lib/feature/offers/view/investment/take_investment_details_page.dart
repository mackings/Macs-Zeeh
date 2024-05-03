import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/feature/home/view/service_offer/investment/investment_offer_details.dart';
import 'package:zeeh_mobile/feature/offers/view/investment/get_investments_details.dart';

import '../../../../common/components/button.dart';
import '../../../../common/components/text_widget.dart';
import '../../../../common/utils/navigator.dart';
import '../../../../constants/colors.dart';
import '../../../home/view/widgets/home_header_widget_two.dart';

class TakeInvestmentPage extends StatefulWidget {
  const TakeInvestmentPage({super.key});

  @override
  State<TakeInvestmentPage> createState() => _TakeInvestmentPageState();
}

class _TakeInvestmentPageState extends State<TakeInvestmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // height: 812.h,
          width: 375.w,
          decoration: const BoxDecoration(
            color: ZeehColors.scaffoldBackground,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeaderWidgetTwo(
                title: "Alico insurance",
              ),
              SizedBox(
                height: 17.h,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 24.h),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ListInvestmentWidget(
                      headerLeft: "Insurance Type",
                      descriptionLeft: "Vehicle",
                      headerRight: "Insurance Policy",
                      descriptionRight: "Comprehensive",
                    ),
                    SizedBox(height: 25.h),
                    const ListInvestmentWidget(
                      headerLeft: "Insured value",
                      descriptionLeft: "Vehicle",
                      headerRight: "Insurance claim",
                      descriptionRight: "1 year",
                    ),
                    SizedBox(height: 25.h),
                    const ListInvestmentWidget(
                      headerLeft: "Good driver discount",
                      descriptionLeft: "6%",
                      headerRight: "NCB Discount",
                      descriptionRight: "8%",
                    ),
                    SizedBox(height: 25.h),
                    GroteskText(
                      text: "Extra coverage",
                      textColor: ZeehColors.grayColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        GroteskText(
                          text: "Return invoice",
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 14.w),
                          child: Container(
                            width: 180.w,
                            height: 35.h,
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: ZeehColors.greyColor),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Center(
                              child: SpaceGroteskText(
                                text: "Add coverage for ₦20,000",
                                fontSize: 13.sp,
                                textColor: ZeehColors.buttonPurple,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    SizedBox(
                      width: 130.sp,
                      child: GroteskText(
                        text: "Covers damage to your car only",
                        textColor: ZeehColors.grayColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(height: 25.h),
                    GroteskText(
                      text: "Add-ons",
                      textColor: ZeehColors.grayColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        SizedBox(
                          width: 130.w,
                          child: GroteskText(
                            text:
                                "Loss of drivers license/registration certificate",
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp,
                            maxLines: 5,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 14.w),
                          child: Container(
                            width: 60.w,
                            height: 35.h,
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: ZeehColors.greyColor),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Center(
                              child: GroteskText(
                                text: "Add",
                                fontSize: 13.sp,
                                textColor: ZeehColors.buttonPurple,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    SizedBox(
                      width: 130.sp,
                      child: SpaceGroteskText(
                        text: "Cost ₦20,000 only",
                        textColor: ZeehColors.grayColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 24.h),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: ZeehButton(
                  onClick: () =>
                      navigate(context, const GetInvestmentDetails()),
                  text: "Continue",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
