import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/constants/colors.dart';

import '../../../../../common/components/button.dart';
import '../../widgets/home_header_widget_two.dart';
import '../../widgets/loan_payment_widget.dart';

class BankTransferPayment extends StatelessWidget {
  const BankTransferPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 375.w,
        child: Column(
          children: [
            const HomeHeaderWidgetTwo(title: "Loan Payment"),
            SizedBox(height: 16.h),
            Container(
              width: 375.w,
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GroteskText(
                    text: 'Bank Transfer',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 8.h),
                  GroteskText(
                    text: 'Copy the account number to make payment.'
                        ' Your loan payment will be updated instantly',
                    maxLines: 2,
                    fontSize: 14.sp,
                    textColor: ZeehColors.grayColor,
                  )
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(24.r),
                color: Colors.white,
                width: 375.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LoanPaymentWidget(
                      headerLeft: 'Bank name',
                      descriptionLeft: 'GTBank',
                    ),
                    SizedBox(height: 16.h),
                    LoanPaymentWidget(
                      headerLeft: 'Account number',
                      descriptionLeft: '0552*******',
                      spacing: 8,
                      rightWidget: Padding(
                        padding: EdgeInsets.only(right: 29.w),
                        child: Container(
                          width: 56.w,
                          height: 38.h,
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: ZeehColors.greyColor),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Center(
                            child: GroteskText(
                              text: "Copy",
                              fontSize: 14.sp,
                              textColor: ZeehColors.buttonPurple,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    const LoanPaymentWidget(
                      headerLeft: 'Account name',
                      descriptionLeft: 'Fairmoney - [Your name]',
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
                  onClick: () => {},
                  text: "Return home",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
