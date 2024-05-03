import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zeeh_mobile/common/components/currency_function.dart';

import '../../../../../common/components/button.dart';
import '../../../../../common/components/text_widget.dart';
import '../../../../../constants/asset_paths.dart';
import '../../../../../constants/colors.dart';
import '../../../../connect_account/view/connect_screen.dart';
import '../../../../connect_account/view/widget/top_up_radio.dart';
import '../../widgets/home_header_widget_two.dart';

class LinkedAccountPayment extends StatefulWidget {
  const LinkedAccountPayment({Key? key}) : super(key: key);

  @override
  State<LinkedAccountPayment> createState() => _LinkedAccountPaymentState();
}

class _LinkedAccountPaymentState extends State<LinkedAccountPayment> {
  AccountChoice _accountChoice = AccountChoice.none;

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
                    text: 'Select an account',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 8.h),
                  GroteskText(
                    text: 'Choose the account you would like to use to '
                        'pay back your loan',
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GroteskText(text: 'Account Name:'),
                        GroteskText(
                          text: 'David Adebola',
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),

                    SizedBox(height: 40.h),

                    // Account Number
                    Row(
                      children: [
                        SvgPicture.asset(ZeehAssets.gtbankIcon),
                        SizedBox(width: 8.w),
                        GroteskText(
                          text: "Guaranty Trust Bank",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h),

                    Container(
                      height: 80.h,
                      padding: EdgeInsets.fromLTRB(16.w, 16.h, 0, 16.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: const Color(0xffCBD5E4),
                        ),
                      ),
                      child: ProductLabeledRadio(
                        title: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const GroteskText(
                                text: "Savings",
                                textColor: ZeehColors.greyColor900,
                                fontWeight: FontWeight.w700,
                              ),
                              const Spacer(),
                              GroteskText(
                                text: "0123127823",
                                fontSize: 14.sp,
                              )
                            ],
                          ),
                          SizedBox(width: 70.w),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0.h),
                            child: SpaceGroteskText(
                              text: "₦ ${amountFormatter(280520.80)}",
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                        groupValue: _accountChoice,
                        value: AccountChoice.savings,
                        onChanged: (AccountChoice value) {
                          setState(() {
                            _accountChoice = value;
                          });
                        },
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
                  onClick: () => {},
                  text: "Make Payment",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
