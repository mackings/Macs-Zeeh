import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/currency_function.dart';
import 'package:zeeh_mobile/common/components/loading_indicator.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/feature/credit/data/state/credit_state_notifier.dart';
import 'package:zeeh_mobile/feature/credit/model/credit_report_model.dart';
import 'package:zeeh_mobile/feature/linked_accounts/view/linked_account.dart';
import 'package:zeeh_mobile/feature/provider.dart';

import '../../../constants/colors.dart';
import '../../home/view/widgets/home_header_widget_two.dart';

class CreditReport extends ConsumerStatefulWidget {
  const CreditReport({super.key});

  @override
  ConsumerState<CreditReport> createState() => _CreditReportState();

  static CreditReport? fromJson(Map<String, dynamic> data) {}
}

class _CreditReportState extends ConsumerState<CreditReport> {
  CreditReportModel creditReportModel = CreditReportModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.read(creditReportStateNotifierProvider.notifier).getCreditReport();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final creditReportState = ref.watch(creditReportStateNotifierProvider);

    if (creditReportState is GetCreditReportSuccess) {
      creditReportModel = creditReportState.creditReportModel;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: 375.w,
          decoration: const BoxDecoration(color: ZeehColors.scaffoldBackground),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeaderWidgetTwo(title: "Credit Report"),
              SizedBox(
                height: 17.h,
              ),

              // Your Credit Report
              if (creditReportState is GetCreditReportLoading)
                Column(
                  children: [
                    SizedBox(height: 200.h),
                    Center(
                      child: LoadingIndicatorWidget(
                        height: 40.h,
                        width: 40.w,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),

                    // SizedBox(
                    //   height: 320.h,
                    //   child: Center(
                    //     child: SvgPicture.asset(ZeehAssets.creditChart),
                    //   ),
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     GroteskText(
                    //       text: "Credit history",
                    //       fontWeight: FontWeight.w500,
                    //       fontSize: 18.sp,
                    //     ),
                    //     GroteskText(
                    //       text: "See all",
                    //       fontWeight: FontWeight.w500,
                    //       fontSize: 14.sp,
                    //     )
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 16.h,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     CreditReportCard(
                    //       bgColor: const Color(0xffE3F1F9),
                    //       imageAsset1: ZeehAssets.sampleImage4,
                    //       imageAsset2: ZeehAssets.arrowUpGreen,
                    //       text1: "Fairmoney",
                    //       text2: "Last reported in april",
                    //       text3: "by ₦${amountFormatter(10000)} ",
                    //     ),
                    //     CreditReportCard(
                    //       bgColor: const Color.fromARGB(38, 144, 0, 255),
                    //       imageAsset1: ZeehAssets.sampleImage9,
                    //       imageAsset2: ZeehAssets.arrowDownRed,
                    //       text1: "Palmpay",
                    //       text2: "Last reported in april",
                    //       text3: "by ₦${amountFormatter(5000)} ",
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 26.h,
                    // ),
                  ],
                )
              else if (creditReportState is GetCreditReportSuccess)
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 26.w, vertical: 24.h),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: DMSanText(
                          text:
                              "See how we have analyzed your credit to generate the report below .",
                          fontWeight: FontWeight.w400,
                          textColor: ZeehColors.grayColor,
                          fontSize: 14.sp,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Credit Report Table
                      Container(
                        width: 327.w,
                        height: 450.h,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 16.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: ZeehColors.greyColor),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DMSanText(
                                text: "Your Credit report",
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                              ),
                              DMSanText(
                                text: "Based on your linked accounts",
                                fontWeight: FontWeight.w400,
                                textColor: ZeehColors.grayColor,
                                fontSize: 16.sp,
                              ),
                              SizedBox(height: 25.h),
                              AccountDataSet(
                                dataKey: "Salary Confidence Level",
                                value:
                                    '${creditReportModel.salaryConfidenceLevel?.toInt().toString()}%',
                              ),
                              AccountDataSet(
                                dataKey: "Mean Income",
                                value:
                                    "₦${amountFormatter(creditReportModel.medianIncome!.toDouble()) ?? ''}",
                              ),
                              AccountDataSet(
                                dataKey: "Expected Salary date",
                                value:
                                    "${creditReportModel.expectedSalaryDay ?? ''}",
                              ),
                              AccountDataSet(
                                dataKey: "Last Salary date",
                                value: creditReportModel.lastSalaryDate ?? '',
                              ),
                              AccountDataSet(
                                dataKey: "Average Salary",
                                value:
                                    "₦${amountFormatter(creditReportModel.averageSalary!.toDouble()) ?? ''}",
                              ),
                              AccountDataSet(
                                dataKey: "Salary Frequency",
                                value:
                                    "${creditReportModel.salaryFrequencyInDays}",
                              ),
                              AccountDataSet(
                                dataKey: "Number of Salary Payments",
                                value:
                                    "${creditReportModel.numberOfSalaryPayments}",
                              ),
                              AccountDataSet(
                                dataKey: "Number of Other Income Payments",
                                value:
                                    "${creditReportModel.numberOfOtherIncomePayments}",
                                showBottomDivider: false,
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 50.h),
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

// Credit Report Widget
class CreditReportCard extends StatelessWidget {
  const CreditReportCard({
    super.key,
    required this.bgColor,
    required this.imageAsset1,
    required this.imageAsset2,
    required this.text1,
    required this.text2,
    required this.text3,
  });

  final Color bgColor;
  final String imageAsset1;
  final String imageAsset2;
  final String text1;
  final String text2;
  final String text3;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 152.w,
      height: 182.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32.w,
            height: 32.h,
            child: CircleAvatar(
              maxRadius: 32,
              minRadius: 32,
              backgroundImage: AssetImage(imageAsset1),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          GroteskText(
            text: text1,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(
            height: 8.h,
          ),
          GroteskText(
            text: text2,
            textColor: ZeehColors.grayColor,
            fontSize: 14.sp,
          ),
          SizedBox(
            height: 14.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 16.w,
                height: 16.h,
                child: Image.asset(imageAsset2),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: SpaceGroteskText(
                  text: text3,
                  fontSize: 14.sp,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
