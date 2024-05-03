import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/currency_function.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/home/view/service_offer/investment/investment_offer_details.dart';
import 'package:zeeh_mobile/feature/home/view/widgets/home_header_widget_two.dart';
import 'package:zeeh_mobile/feature/home/view/widgets/progress_bar_widget.dart';

class BnplOfferPage extends StatefulWidget {
  const BnplOfferPage({super.key});

  @override
  State<BnplOfferPage> createState() => _BnplOfferPageState();
}

class _BnplOfferPageState extends State<BnplOfferPage> {
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 155.w,
                          height: 145.h,
                          child: Image.asset(ZeehAssets.sampleImage3),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: SizedBox(
                            width: 150.w,
                            child: GroteskText(
                              text: "Dell Inspiron Laptop15’ inches 1TB SSD",
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                              maxLines: 3,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20.h),
                    ListInvestmentWidget(
                      headerLeft: "Grade",
                      descriptionLeft: "New",
                      headerRight: "Price",
                      descriptionRight: "₦ ${amountFormatter(250000)}",
                    ),
                    SizedBox(height: 20.h),
                    const ListInvestmentWidget(
                      headerLeft: "Purchase plan",
                      descriptionLeft: "6 months",
                      headerRight: "Interest rate",
                      descriptionRight: "2%",
                    ),
                    SizedBox(height: 20.h),
                    ListInvestmentWidget(
                      headerLeft: "Repayment plan",
                      descriptionLeft: "₦${amountFormatter(10000)} /week",
                      headerRight: "Missed payment",
                      descriptionRight: "2 weeks",
                    ),
                    SizedBox(height: 25.h),
                    GroteskText(
                      text: "Payment progress",
                      fontWeight: FontWeight.w400,
                      fontSize: 17.sp,
                      textColor: ZeehColors.grayColor,
                    ),
                    SizedBox(height: 20.h),
                    LoanProgressWidget(
                      textTop: "₦ ${amountFormatter(100000)}",
                      textBottomLeft: "₦ ${amountFormatter(0)}",
                      textBottomRight: "₦ ${amountFormatter(250000)}",
                      description:
                          "You have defaulted your payment twice. Your repayment has not been consistent, and this could impact your borrowing power and credit score negatively. Make sure you are consistent with payment",
                    ),
                    SizedBox(height: 20.h),
                    GroteskText(
                      text: "Purchase length",
                      fontWeight: FontWeight.w400,
                      fontSize: 17.sp,
                    ),
                    SizedBox(height: 20.h),
                    const LoanProgressWidget(
                      textTop: "16 weeks",
                      textBottomLeft: "0 week",
                      textBottomRight: "24 weeks",
                    ),
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
