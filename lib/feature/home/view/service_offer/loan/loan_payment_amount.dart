import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/home/view/service_offer/loan/loan_payment_type.dart';
import 'package:zeeh_mobile/feature/home/view/widgets/home_header_widget_two.dart';
import 'package:zeeh_mobile/feature/home/view/widgets/loan_payment_tile.dart';

import '../../../../../common/components/button.dart';
import '../../../../../common/components/currency_function.dart';
import '../../../../../common/utils/navigator.dart';

class LoanPaymentAmount extends StatefulWidget {
  const LoanPaymentAmount({Key? key}) : super(key: key);

  @override
  State<LoanPaymentAmount> createState() => _LoanPaymentAmountState();
}

class _LoanPaymentAmountState extends State<LoanPaymentAmount> {
  PaymentAmount _paymentAmount = PaymentAmount.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: 375.w,
          child: Column(
            children: [
              const HomeHeaderWidgetTwo(title: "Loan Payment"),
              SizedBox(height: 16.h),
              Container(
                color: Colors.white,
                height: 569.h,
                width: 375.w,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 48.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const GroteskText(
                        text: 'How much do you want to pay',
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 8.h),
                      GroteskText(
                        text: 'How much do you want to pay',
                        fontSize: 12.sp,
                        textColor: ZeehColors.grayColor,
                      ),
                      SizedBox(height: 16.h),
                      LoanPaymentTile(
                          groupValue: _paymentAmount,
                          value: PaymentAmount.full,
                          onChanged: (PaymentAmount value) {
                            setState(() {
                              _paymentAmount = value;
                            });
                          },
                          body: Row(
                            children: [
                              GroteskText(
                                text: 'Full loan payment',
                                fontSize: 14.sp,
                              ),
                              SizedBox(width: 10.w),
                              SpaceGroteskText(
                                text: "₦ ${amountFormatter(-300000)}",
                                fontSize: 14.sp,
                                textColor: const Color(0xffE2352A),
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          )),
                      SizedBox(height: 16.h),
                      LoanPaymentTile(
                        groupValue: _paymentAmount,
                        value: PaymentAmount.part,
                        onChanged: (value) {
                          setState(() {
                            _paymentAmount = value;
                          });
                        },
                        body: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GroteskText(
                              text: 'Part payment ',
                              fontSize: 14.sp,
                            ),
                            SizedBox(
                              width: 140.w,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 15.sp),
                                decoration: InputDecoration(
                                  hintText: 'Enter amount',
                                  hintStyle: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.black12,
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ZeehColors.greyColor,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                color: Colors.white,
                height: 100.h,
                width: double.infinity,
                child: Center(
                  child: ZeehButton(
                    onClick: () => navigate(
                      context,
                      const LoanPaymentType(),
                    ),
                    text: "Continue",
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum PaymentAmount { none, full, part }
