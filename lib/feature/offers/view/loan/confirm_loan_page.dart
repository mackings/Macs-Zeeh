import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/currency_function.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/feature/offers/data/state/offer_state_notifier.dart';
import 'package:zeeh_mobile/feature/offers/model/claim_offer_body.dart';
import 'package:zeeh_mobile/feature/offers/model/service_offer_detail.dart';
import 'package:zeeh_mobile/feature/offers/view/success_page.dart';
import 'package:zeeh_mobile/feature/provider.dart';

import '../../../../common/components/button.dart';
import '../../../../common/components/text_widget.dart';
import '../../../../constants/colors.dart';
import '../../../home/view/service_offer/investment/investment_offer_details.dart';
import '../../../home/view/widgets/home_header_widget_two.dart';

class ConfirmLoanWidget extends ConsumerStatefulWidget {
  const ConfirmLoanWidget({
    super.key,
    required this.serviceOfferDetail,
    required this.amount,
  });

  final ServiceOfferDetail serviceOfferDetail;
  final String amount;

  @override
  ConsumerState<ConfirmLoanWidget> createState() => _ConfirmLoanWidgetState();
}

class _ConfirmLoanWidgetState extends ConsumerState<ConfirmLoanWidget> {
  // Handle Claim Offer
  void handleClaimOffer(WidgetRef ref) {
    ServiceOfferDetail serviceOfferDetail = widget.serviceOfferDetail;

    ref.read(offerStateNotifierProvider.notifier).claimOffers(
          ClaimOfferBody(
            service: serviceOfferDetail.serviceTypeId,
            offer: serviceOfferDetail.id,
            loanAmount: int.parse(widget.amount),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    ServiceOfferDetail serviceOfferDetail = widget.serviceOfferDetail;

    final offerState = ref.watch(offerStateNotifierProvider);

    ref.listen(
      offerStateNotifierProvider,
      (previous, next) {
        if (next is ClaimOfferSuccess) {
          navigate(
            context,
            SuccessPage(
              contentText:
                  "You have successfully applied for a loan of ₦${widget.amount}. The Loaner will get back to you in due time for the status of your loan application",
              headerText: "${serviceOfferDetail.name}",
            ),
          );
        }
      },
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 812.h,
          width: 375.w,
          decoration: const BoxDecoration(color: ZeehColors.scaffoldBackground),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeaderWidgetTwo(title: serviceOfferDetail.name),
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
                    // Loan Details
                    ListInvestmentWidget(
                      headerLeft: "Loan Amount",
                      descriptionLeft: "₦ ${widget.amount}",
                      headerRight: "Loan Tenure",
                      descriptionRight:
                          "${amountFormatter(serviceOfferDetail.duration!.toDouble())} ${serviceOfferDetail.repaymentPlan == "monthly" ? "months" : (serviceOfferDetail.repaymentPlan == "weekly" && serviceOfferDetail.duration == 1) ? "week" : "weeks"}",
                    ),
                    SizedBox(
                      height: 14.h,
                    ),

                    // Interest Rate and Repayment Plan
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Interest Rate and Repayment Plan
                        SizedBox(
                          width: 180.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GroteskText(
                                maxLines: 2,
                                text: "Interest Rate",
                                textColor: ZeehColors.grayColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                              ),
                              SizedBox(height: 9.h),
                              GroteskText(
                                maxLines: 2,
                                text: "${serviceOfferDetail.interest}%",
                                fontWeight: FontWeight.w500,
                                fontSize: 17.sp,
                              )
                            ],
                          ),
                        ),

                        // Repayment Plan
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GroteskText(
                              maxLines: 2,
                              text: "Repayment Plan",
                              textColor: ZeehColors.grayColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                            SizedBox(height: 8.h),
                            GroteskText(
                              maxLines: 2,
                              text:
                                  serviceOfferDetail.repaymentPlan == "monthly"
                                      ? "Monthly"
                                      : "Weekly",
                              fontWeight: FontWeight.w500,
                              fontSize: 17.sp,
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 40.h),

                    // Loan Summary
                    GroteskText(
                      text:
                          "Your loan repayment amount is ₦${amountFormatter((double.parse(widget.amount)) / serviceOfferDetail.duration!.toDouble())}/${serviceOfferDetail.repaymentPlan == "monthly" ? "months" : (serviceOfferDetail.repaymentPlan == "weekly" && serviceOfferDetail.duration == 1) ? "week" : "weeks"} over a spread of ${amountFormatter(serviceOfferDetail.duration!.toDouble())} ${serviceOfferDetail.repaymentPlan == "monthly" ? "months" : (serviceOfferDetail.repaymentPlan == "weekly" && serviceOfferDetail.duration == 1) ? "week" : "weeks"}",
                      textColor: ZeehColors.grayColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      maxLines: 4,
                    ),
                    SizedBox(height: 30.h),
                    GroteskText(
                      text:
                          "Total loan repayment at ${serviceOfferDetail.interest}% interest rate is N${((serviceOfferDetail.interest! / 100) * double.parse(widget.amount)) + double.parse(widget.amount)} at ${amountFormatter(serviceOfferDetail.duration!.toDouble())} ${serviceOfferDetail.repaymentPlan == "monthly" ? "monthly" : (serviceOfferDetail.repaymentPlan == "weekly" && serviceOfferDetail.duration == 1) ? "week" : "weeks"} term",
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp,
                      maxLines: 2,
                    ),
                    SizedBox(height: 150.h),
                  ],
                ),
              ),
              SizedBox(height: 30.h),

              // Loan

              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 24.h),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    //
                    if (offerState is ClaimOfferLoading)
                      const AppLoadingButton()
                    else
                      Column(
                        children: [
                          ZeehButton(
                            onClick: () => handleClaimOffer(ref),
                            text: "Take loan",
                          ),

                          SizedBox(height: 20.h),

                          // Go Back
                          ZeehButton(
                            onClick: () => Navigator.pop(context),
                            isOutline: true,
                            borderColor: ZeehColors.greyColor,
                            buttonColor: Colors.white,
                            text: "Go back",
                            fontWeight: FontWeight.w500,
                            textColor: ZeehColors.blackColor,
                          ),
                        ],
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
