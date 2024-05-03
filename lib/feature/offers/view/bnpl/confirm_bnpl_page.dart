import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/feature/offers/view/success_page.dart';

import '../../../../common/components/button.dart';
import '../../../../common/components/text_widget.dart';
import '../../../../common/utils/navigator.dart';
import '../../../../constants/asset_paths.dart';
import '../../../../constants/colors.dart';
import '../../../home/view/service_offer/investment/investment_offer_details.dart';
import '../../../home/view/widgets/home_header_widget_two.dart';

class ConfirmBnplPage extends StatefulWidget {
  const ConfirmBnplPage({super.key});

  @override
  State<ConfirmBnplPage> createState() => _ConfirmBnplPageState();
}

class _ConfirmBnplPageState extends State<ConfirmBnplPage> {
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
                title: "Cred Pal",
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 155.w,
                          height: 145.h,
                          child: Image.asset(ZeehAssets.sampleImage3),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    const ListInvestmentWidget(
                      headerLeft: "Brand",
                      descriptionLeft: "Dell Inspiron 15’ inches 1TB SSD",
                      headerRight: "Grade",
                      descriptionRight: "New",
                    ),
                    SizedBox(height: 20.h),
                    const ListInvestmentWidget(
                      headerLeft: "Color",
                      descriptionLeft: "Silver",
                      headerRight: "Interest",
                      descriptionRight: "2%",
                    ),
                    SizedBox(height: 20.h),
                    const ListInvestmentWidget(
                      headerLeft: "Price",
                      descriptionLeft: "₦250,000",
                      headerRight: "Purchase plan",
                      descriptionRight: "6 months",
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GroteskText(
                          maxLines: 2,
                          text: "Repayment plan",
                          textColor: ZeehColors.grayColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 13.sp,
                        ),
                        SizedBox(height: 8.h),
                        GroteskText(
                          maxLines: 2,
                          text: "Weekly",
                          fontWeight: FontWeight.w500,
                          fontSize: 17.sp,
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    SpaceGroteskText(
                      text:
                          "Your weekly loan repayment amount is ₦1,165.38/week over a spread of 6months",
                      textColor: ZeehColors.grayColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      maxLines: 2,
                    ),
                    SizedBox(height: 30.h),
                    SpaceGroteskText(
                      text:
                          "Total Loan repayment at 2% interest rate is  ₦30,300 at 6 months term",
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      maxLines: 2,
                    ),
                    SizedBox(height: 25.h),
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
                          "You have successfully applied for a loan of ₦30,000. The Loaner will get back to you in due time for the status of your loan application",
                      headerText: "Cred Pal",
                    ),
                  ),
                  text: "Buy Now",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
