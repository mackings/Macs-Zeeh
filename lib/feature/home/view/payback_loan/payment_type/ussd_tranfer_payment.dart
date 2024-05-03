import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/components/button.dart';
import '../../../../../common/components/text_widget.dart';
import '../../../../../constants/colors.dart';
import '../../widgets/home_header_widget_two.dart';
import '../../widgets/loan_payment_widget.dart';

class USSDTransferPayment extends StatelessWidget {
  const USSDTransferPayment({Key? key}) : super(key: key);

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
                    text: 'USSD transfer to Bank',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 8.h),
                  GroteskText(
                    text: 'Dial the code to make payment. Your loan '
                        'payment will be updated instantly',
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
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 24.h),
                      child: const CustomUSSDTransferTile(
                        bank: 'GTBank',
                        number: '*737*1*4000*0552*****#',
                      ),
                    );
                  },
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

class CustomUSSDTransferTile extends StatelessWidget {
  const CustomUSSDTransferTile({
    Key? key,
    required this.bank,
    required this.number,
    this.onTap,
  }) : super(key: key);

  final String bank;
  final String number;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return LoanPaymentWidget(
      headerLeft: bank,
      descriptionLeft: number,
      spacing: 8,
      rightWidget: Padding(
        padding: EdgeInsets.only(right: 29.w),
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: 56.w,
            height: 38.h,
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: ZeehColors.greyColor),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: GroteskText(
                text: "Dial",
                fontSize: 14.sp,
                textColor: ZeehColors.buttonPurple,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
