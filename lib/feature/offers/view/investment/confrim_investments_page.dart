import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/feature/home/view/service_offer/investment/investment_offer_details.dart';
import 'package:zeeh_mobile/feature/home/view/widgets/home_header_widget_two.dart';
import 'package:zeeh_mobile/feature/home/view/widgets/progress_bar_widget.dart';
import 'package:zeeh_mobile/feature/offers/view/success_page.dart';

import '../../../../common/components/button.dart';
import '../../../../common/components/text_widget.dart';
import '../../../../common/utils/navigator.dart';
import '../../../../constants/asset_paths.dart';
import '../../../../constants/colors.dart';

class ConfrimInvestmentPage extends StatefulWidget {
  const ConfrimInvestmentPage({super.key});

  @override
  State<ConfrimInvestmentPage> createState() => _ConfrimInvestmentPageState();
}

class _ConfrimInvestmentPageState extends State<ConfrimInvestmentPage> {
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
                    const ListInvestmentWidget(
                      headerLeft: "Final Premium",
                      descriptionLeft: "₦20,000",
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
                    const LoanProgressWidget(
                      imageAsset: ZeehAssets.sampleImage2,
                      textTop: "₦10,000",
                      textBottomLeft: "₦0.00",
                      textBottomRight: "₦10,000",
                      textBottomLeftDescription: "Low risk",
                      textBottomRightDescription: "High risk",
                      description:
                          "Amount you will receive in case of total damage/theft of your vehicle",
                    ),
                    SizedBox(height: 10.h),
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
                  onClick: () => navigate(
                    context,
                    const SuccessPage(
                      contentText:
                          "You have successfully applied for an insurance policy of ₦20,000. The issuer will get back to you in due time for the status of your insurance application",
                      headerText: "Alico Investment",
                    ),
                  ),
                  text: "Claim insurance",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
