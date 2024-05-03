import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/currency_function.dart';
import 'package:zeeh_mobile/common/components/textfield_box.dart';
import 'package:zeeh_mobile/feature/offers/model/service_offer_detail.dart';
import 'package:zeeh_mobile/feature/offers/view/loan/confirm_loan_page.dart';

import '../../../../common/components/button.dart';
import '../../../../common/components/text_widget.dart';
import '../../../../common/utils/navigator.dart';
import '../../../../constants/colors.dart';
import '../../../home/view/widgets/home_header_widget_two.dart';

class TakeLoanDetails extends ConsumerStatefulWidget {
  const TakeLoanDetails({super.key, required this.serviceOfferDetail});

  final ServiceOfferDetail serviceOfferDetail;

  @override
  ConsumerState<TakeLoanDetails> createState() => _TakeLoanDetailsState();
}

class _TakeLoanDetailsState extends ConsumerState<TakeLoanDetails> {
  bool _isCheckedWeekly = false;
  bool _isCheckedMonthly = false;

  TextEditingController amountController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Validator
  String? validator(String? value, String field) {
    ServiceOfferDetail serviceOfferDetail = widget.serviceOfferDetail;

    if (value!.trim().isEmpty) {
      return "$field cannot be empty";
    } else if (field == "Amount" &&
            double.parse(amountController.text) >
                serviceOfferDetail.loanAmount["maximum"] ||
        double.parse(amountController.text) <
            serviceOfferDetail.loanAmount["minimum"]) {
      return "";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    ServiceOfferDetail serviceOfferDetail = widget.serviceOfferDetail;

    if (serviceOfferDetail.repaymentPlan == "weekly") {
      _isCheckedWeekly = true;
    } else if (serviceOfferDetail.repaymentPlan == "monthly") {
      _isCheckedMonthly = true;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: 375.w,
          decoration: const BoxDecoration(color: ZeehColors.scaffoldBackground),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeaderWidgetTwo(title: serviceOfferDetail.name),
                SizedBox(
                  height: 17.h,
                ),
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
                      // Loan Limit and Loan Tenure
                      ListInvestmentWidget(
                        headerLeft: "Loan Limit",
                        descriptionLeft:
                            "₦${amountFormatter(double.parse(serviceOfferDetail.loanAmount["minimum"].toString()))} - ₦${amountFormatter(double.parse(serviceOfferDetail.loanAmount["maximum"].toString()))}",
                        headerRight: "Loan Tenure",
                        descriptionRight:
                            "${amountFormatter(serviceOfferDetail.duration!.toDouble())} ${serviceOfferDetail.repaymentPlan == "monthly" ? "months" : (serviceOfferDetail.repaymentPlan == "weekly" && serviceOfferDetail.duration == 1) ? "week" : "weeks"}",
                      ),
                      SizedBox(
                        height: 14.h,
                      ),

                      // Interest Rate
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
                                  text: "Interest Rate",
                                  textColor: ZeehColors.grayColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.sp,
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20.h,
                                    child: Row(
                                      children: [
                                        // Weekly
                                        Transform.scale(
                                          scale: 1.2,
                                          child: Checkbox(
                                            side: const BorderSide(width: 0.9),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.r),
                                            ),
                                            checkColor: Colors.white,
                                            activeColor:
                                                ZeehColors.buttonPurple,
                                            value: _isCheckedWeekly,
                                            onChanged: (bool? value) {},
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

                                  // Monthly
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
                                            activeColor:
                                                ZeehColors.buttonPurple,
                                            value: _isCheckedMonthly,
                                            onChanged: (bool? value) {},
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
                      SizedBox(height: 20.h),

                      // Extra Loan
                      GroteskText(
                        text: "Extra loan consideration",
                        textColor: ZeehColors.grayColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          GroteskText(
                            text: "Not Available",
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp,
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
                                  text: "Apply",
                                  fontSize: 14.sp,
                                  textColor: ZeehColors.buttonPurple,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 18.h),

                      // Extra Loan Amount Details
                      SizedBox(
                        width: 130.w,
                        child: SpaceGroteskText(
                          text: "Up to ₦20,000 above maximum loan limit.",
                          textColor: ZeehColors.grayColor,
                          maxLines: 2,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Loan Amount
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GroteskText(
                            text: "Loan Amount",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),

                          // Loan Amount
                          SizedBox(height: 8.h),
                          TextFieldBox(
                            controller: amountController,
                            hintText: "Enter loan amount",
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) => validator(value, "Amount"),
                            prefixText: '₦ ',
                          ),
                          SizedBox(height: 15.h),
                          GroteskText(
                            text:
                                "Your loan amount must be within the loan range the issuer is offering to your kind of credit worthiness. If you want a loan above this limit, you can apply for consideration with the loaner if they have a provision for extra loan consideration.",
                            textColor: ZeehColors.grayColor,
                            maxLines: 5,
                            fontSize: 14.sp,
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),

                // Continue Button
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 26.w, vertical: 24.h),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: ZeehButton(
                    onClick: () => {
                      if (_formKey.currentState!.validate())
                        navigate(
                          context,
                          ConfirmLoanWidget(
                            serviceOfferDetail: serviceOfferDetail,
                            amount: amountController.text,
                          ),
                        ),
                    },
                    text: "Continue",
                  ),
                )
              ],
            ),
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
      children: [
        SizedBox(
          width: 180.w,
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
            GroteskText(
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
