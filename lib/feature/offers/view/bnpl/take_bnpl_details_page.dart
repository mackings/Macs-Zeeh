import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/feature/offers/view/bnpl/confirm_bnpl_page.dart';

import '../../../../common/components/button.dart';
import '../../../../common/components/text_widget.dart';
import '../../../../common/utils/navigator.dart';
import '../../../../constants/asset_paths.dart';
import '../../../../constants/colors.dart';
import '../../../home/view/service_offer/investment/investment_offer_details.dart';
import '../../../home/view/widgets/home_header_widget_two.dart';

class TakeBnplPage extends StatefulWidget {
  const TakeBnplPage({super.key});

  @override
  State<TakeBnplPage> createState() => _TakeBnplPageState();
}

class _TakeBnplPageState extends State<TakeBnplPage> {
  bool _isCheckedWeekly = false;
  bool _isCheckedMonthly = false;
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
                    Row(
                      children: [
                        SizedBox(
                          width: 162.w,
                          child: Row(
                            children: [
                              Container(
                                width: 20.w,
                                height: 20.h,
                                decoration: const BoxDecoration(
                                  color: Color(0xff131313),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Container(
                                width: 20.w,
                                height: 20.h,
                                decoration: const BoxDecoration(
                                  color: Color(0xff666666),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Container(
                                width: 20.w,
                                height: 20.h,
                                decoration: const BoxDecoration(
                                  color: Color(0xffCFC8C8),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Container(
                                width: 20.w,
                                height: 20.h,
                                decoration: const BoxDecoration(
                                  color: Color(0xffE39E8D),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GroteskText(
                              maxLines: 2,
                              text: "Interest rate",
                              textColor: ZeehColors.grayColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 13.sp,
                            ),
                            SizedBox(height: 8.h),
                            GroteskText(
                              maxLines: 2,
                              text: "2%",
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20.h),
                    const ListInvestmentWidget(
                      headerLeft: "Price",
                      descriptionLeft: "₦250,000",
                      headerRight: "Purchase plan",
                      descriptionRight: "6 months",
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 180.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GroteskText(
                                maxLines: 2,
                                text: "Availability quantity",
                                textColor: ZeehColors.grayColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 13.sp,
                              ),
                              SizedBox(height: 9.h),
                              SizedBox(
                                width: 100.w,
                                child: GroteskText(
                                  maxLines: 2,
                                  text: "2 quantity left for sale",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                ),
                              )
                            ],
                          ),
                        ),
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20.h,
                                  child: Row(
                                    children: [
                                      Transform.scale(
                                        scale: 1.2,
                                        child: Checkbox(
                                          side: const BorderSide(width: 0.9),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                          ),
                                          checkColor: Colors.white,
                                          activeColor: ZeehColors.buttonPurple,
                                          value: _isCheckedWeekly,
                                          onChanged: (bool? value) {
                                            setState(
                                              () {
                                                _isCheckedWeekly =
                                                    value ?? false;
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      GroteskText(
                                        text: "Weekly",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                SizedBox(
                                  height: 20.h,
                                  child: Row(
                                    children: [
                                      Transform.scale(
                                        scale: 1.2,
                                        child: Checkbox(
                                          side: const BorderSide(width: 0.9),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                          ),
                                          checkColor: Colors.white,
                                          activeColor: ZeehColors.buttonPurple,
                                          value: _isCheckedMonthly,
                                          onChanged: (bool? value) {
                                            setState(
                                              () {
                                                _isCheckedMonthly =
                                                    value ?? false;
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      GroteskText(
                                        text: "Monthly",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 45.h),
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
                  onClick: () => navigate(context, const ConfirmBnplPage()),
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
