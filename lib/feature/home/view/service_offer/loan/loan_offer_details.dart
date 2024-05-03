import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/currency_function.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/feature/home/view/widgets/home_header_widget_two.dart';
import 'package:zeeh_mobile/feature/home/view/widgets/progress_bar_widget.dart';
import 'package:zeeh_mobile/feature/offers/model/active_claim_model.dart';

import '../../../../../common/components/text_widget.dart';
import '../../../../../constants/colors.dart';

class LoanOffersDetailsPage extends StatefulWidget {
  const LoanOffersDetailsPage({super.key, required this.activeClaimModel});

  final ActiveClaimModel activeClaimModel;

  @override
  State<LoanOffersDetailsPage> createState() => _LoanOffersDetailsPageState();
}

class _LoanOffersDetailsPageState extends State<LoanOffersDetailsPage> {
  @override
  Widget build(BuildContext context) {
    ActiveClaimModel activeClaimMode = widget.activeClaimModel;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // height: 812.h,
          width: 375.w,
          decoration: const BoxDecoration(
            color: ZeehColors.scaffoldBackground,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            HomeHeaderWidgetTwo(
              title: activeClaimMode.offerName,
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
                  const GroteskText(
                    text: "Loan summary",
                    textColor: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  GroteskText(
                    text: "Date taken:  ${activeClaimMode.dateExpire}",
                    textColor: ZeehColors.grayColor,
                    fontSize: 13.sp,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  LoanListWidget(
                    textLeft: "Loan amount without interest",
                    textRight:
                        "₦${amountFormatter(activeClaimMode.amountDue!)}",
                  ),
                  const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                  LoanListWidget(
                    textLeft: "Interest rate",
                    textRight: "${activeClaimMode.interest} %",
                  ),
                  const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                  LoanListWidget(
                    textLeft: "Loan tenure",
                    textRight:
                        "${activeClaimMode.duration} ${activeClaimMode.repaymentPlan == "weekly" && activeClaimMode.duration!.toInt() > 1 ? "weeks" : activeClaimMode.repaymentPlan == "monthly" && activeClaimMode.duration!.toInt() > 1 ? "months" : activeClaimMode.repaymentPlan == "monthly" && activeClaimMode.duration!.toInt() == 1 ? "month" : "week"}",
                  ),
                  const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                  LoanListWidget(
                    textLeft: "Repayment plan",
                    textRight:
                        "₦${amountFormatter(activeClaimMode.repaymentAmount! / activeClaimMode.duration!.toInt())} / ${activeClaimMode.repaymentPlan == "weekly" && activeClaimMode.duration!.toInt() > 1 ? "weeks" : activeClaimMode.repaymentPlan == "monthly" && activeClaimMode.duration!.toInt() > 1 ? "months" : activeClaimMode.repaymentPlan == "monthly" && activeClaimMode.duration!.toInt() == 1 ? "month" : "week"}",
                  ),
                  const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                  const LoanListWidget(
                    textLeft: "Missed payment",
                    textRight: "",
                    imageAsset: ZeehAssets.exclamationIcon,
                  ),
                  const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: const Color(0xffEA1456),
                                  radius: 12.r,
                                  child: Image.asset(
                                    ZeehAssets.exclamationIcon,
                                    height: 15.h,
                                    width: 15.w,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 6.w),
                                  child: GroteskText(
                                    text: "Payment progress",
                                    textColor: Colors.black,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        LoanProgressWidget(
                          textTop: "${activeClaimMode.repaymentAmount}",
                          textBottomLeft: "₦0.00",
                          textBottomRight:
                              "₦${amountFormatter(activeClaimMode.repaymentAmount!.toDouble())}",
                          description:
                              "You have defaulted your payment twice. Your repayment has not been consistent, and this could impact your borrowing power and credit score negatively. Make sure you are consistent with payment",
                        ),
                      ],
                    ),
                  ),
                  const Divider(thickness: 1, color: Color(0xffD7D7D7)),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: const Color(0xffEA1456),
                                  radius: 12.r,
                                  child: Image.asset(
                                    ZeehAssets.exclamationIcon,
                                    height: 15.h,
                                    width: 15.w,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 6.w),
                                  child: GroteskText(
                                    text: "Loan progress",
                                    textColor: Colors.black,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        LoanProgressWidget(
                          textTop: "1 week",
                          textBottomLeft:
                              "0 ${activeClaimMode.repaymentPlan == "weekly" && activeClaimMode.duration!.toInt() > 1 ? "weeks" : activeClaimMode.repaymentPlan == "monthly" && activeClaimMode.duration!.toInt() > 1 ? "months" : activeClaimMode.repaymentPlan == "monthly" && activeClaimMode.duration!.toInt() == 1 ? "month" : "week"}",
                          textBottomRight:
                              "${activeClaimMode.duration} ${activeClaimMode.repaymentPlan == "weekly" ? "weeks" : activeClaimMode.repaymentPlan == "monthly" && activeClaimMode.duration!.toInt() > 1 ? "months" : activeClaimMode.repaymentPlan == "monthly" && activeClaimMode.duration!.toInt() == 1 ? "month" : "week"}",
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class LoanListWidget extends StatelessWidget {
  const LoanListWidget({
    super.key,
    required this.textRight,
    required this.textLeft,
    this.imageAsset,
  });

  final String textRight;
  final String textLeft;
  final String? imageAsset;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            if (imageAsset != null)
              CircleAvatar(
                backgroundColor: const Color(0xffEA1456),
                radius: 12.r,
                child: Image.asset(
                  ZeehAssets.exclamationIcon,
                  height: 15.h,
                  width: 15.w,
                ),
              )
            else
              CircleAvatar(
                backgroundColor: const Color(0xff2A9921),
                radius: 12.r,
                child: Icon(
                  Icons.check_circle_outline,
                  size: 17.sp,
                  color: Colors.black,
                ),
              ),
            Padding(
              padding: EdgeInsets.only(left: 6.w),
              child: GroteskText(
                text: textLeft,
                textColor: Colors.black,
                fontSize: 15.sp,
              ),
            ),
          ]),
          SpaceGroteskText(
            text: textRight,
            fontWeight: FontWeight.w500,
            fontSize: 15.sp,
          )
        ],
      ),
    );
  }
}
