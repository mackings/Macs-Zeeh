import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/home/view/widgets/home_header_widget_two.dart';
import 'package:zeeh_mobile/feature/home/view/widgets/progress_bar_widget.dart';

import '../../../../../common/components/currency_function.dart';

class InvestmentOfferPage extends StatefulWidget {
  const InvestmentOfferPage({super.key});

  @override
  State<InvestmentOfferPage> createState() => _InvestmentOfferPageState();
}

class _InvestmentOfferPageState extends State<InvestmentOfferPage> {
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
                title: "Alico Insurance",
              ),
              SizedBox(height: 17.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 24.h),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 155.w,
                          height: 145.h,
                          child: Image.asset(ZeehAssets.sampleImage1),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GroteskText(
                                text: "Bajaj Auto Re 4s",
                                fontWeight: FontWeight.w500,
                                fontSize: 17.sp,
                              ),
                              SizedBox(height: 8.h),
                              GroteskText(
                                text: "MH321W468733",
                                textColor: ZeehColors.grayColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 13.sp,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20.h),
                    const ListInvestmentWidget(
                      headerLeft: "Insurance Type",
                      descriptionLeft: "Vehicle",
                      headerRight: "Insurance Policy",
                      descriptionRight: "Comprehensive",
                    ),
                    SizedBox(height: 20.h),
                    ListInvestmentWidget(
                      headerLeft: "Final Premium",
                      descriptionLeft: "₦ ${amountFormatter(20000)}",
                      headerRight: "Policy End Date",
                      descriptionRight: "08/05/2024",
                    ),
                    SizedBox(height: 20.h),
                    const ListInvestmentWidget(
                      headerLeft: "Good Driver Discount",
                      descriptionLeft: "6%",
                      headerRight: "NCB Discount",
                      descriptionRight: "8%",
                    ),
                    SizedBox(height: 20.h),
                    const ListInvestmentWidget(
                      headerLeft: "Add-ons",
                      descriptionLeft: "Loss of license & reg certificate",
                      headerRight: "Extra Coverage",
                      descriptionRight: "Damage to car only",
                    ),
                    SizedBox(height: 20.h),
                    const ListInvestmentWidget(
                      headerLeft: "Missed Payment",
                      descriptionLeft: "2months",
                      headerRight: "Insurance Claim",
                      descriptionRight: "1year",
                    ),
                    SizedBox(height: 20.h),
                    LoanProgressWidget(
                      imageAsset: ZeehAssets.sampleImage2,
                      textTop: "₦ ${amountFormatter(10000)}",
                      textBottomLeft: "₦ ${amountFormatter(0)}",
                      textBottomRight: "₦ ${amountFormatter(10000)}",
                      textBottomLeftDescription: "Low risk",
                      textBottomRightDescription: "High risk",
                      description:
                          "Amount you will receive in case of total damage/theft of your vehicle",
                    ),
                    SizedBox(height: 10.h),
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

class ListInvestmentWidget extends StatelessWidget {
  const ListInvestmentWidget({
    super.key,
    required this.headerLeft,
    required this.descriptionLeft,
    required this.headerRight,
    required this.descriptionRight,
  });

  final String headerLeft;
  final String descriptionLeft;
  final String headerRight;
  final String descriptionRight;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 162.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GroteskText(
                maxLines: 2,
                text: headerLeft,
                textColor: ZeehColors.grayColor,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
              SizedBox(height: 8.h),
              SpaceGroteskText(
                maxLines: 2,
                text: descriptionLeft,
                fontWeight: FontWeight.w500,
                fontSize: 17.sp,
              )
            ],
          ),
        ),
        SizedBox(width: 18.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GroteskText(
              maxLines: 2,
              text: headerRight,
              textColor: ZeehColors.grayColor,
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
            ),
            SizedBox(height: 8.h),
            SpaceGroteskText(
              maxLines: 2,
              text: descriptionRight,
              fontWeight: FontWeight.w500,
              fontSize: 17.sp,
            )
          ],
        )
      ],
    );
  }
}
