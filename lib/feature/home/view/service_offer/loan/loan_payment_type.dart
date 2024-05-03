import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/feature/home/view/payback_loan/payment_type/bank_transfer_payment.dart';
import 'package:zeeh_mobile/feature/home/view/payback_loan/payment_type/linked_account_payment.dart';
import 'package:zeeh_mobile/feature/home/view/payback_loan/payment_type/ussd_tranfer_payment.dart';
import 'package:zeeh_mobile/feature/home/view/widgets/home_header_widget_two.dart';
import 'package:zeeh_mobile/feature/home/view/widgets/loan_payment_tile.dart';

import '../../../../../common/components/button.dart';
import '../../../../../common/components/text_widget.dart';
import '../../../../../common/utils/navigator.dart';
import '../../../../../constants/colors.dart';

class LoanPaymentType extends StatefulWidget {
  const LoanPaymentType({Key? key}) : super(key: key);

  @override
  State<LoanPaymentType> createState() => _LoanPaymentTypeState();
}

class _LoanPaymentTypeState extends State<LoanPaymentType> {
  PaymentType _paymentType = PaymentType.none;

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
                        text: 'How do you want to pay',
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
                        body: GroteskText(
                          text: 'Linked Account',
                          fontSize: 14.sp,
                        ),
                        groupValue: _paymentType,
                        value: PaymentType.linkedAccount,
                        onChanged: (PaymentType value) {
                          setState(() {
                            _paymentType = value;
                          });
                        },
                      ),
                      SizedBox(height: 16.h),
                      LoanPaymentTile(
                        body: GroteskText(
                          text: 'Bank Transfer',
                          fontSize: 14.sp,
                        ),
                        groupValue: _paymentType,
                        value: PaymentType.bankTransfer,
                        onChanged: (PaymentType value) {
                          setState(() {
                            _paymentType = value;
                          });
                        },
                      ),
                      SizedBox(height: 16.h),
                      LoanPaymentTile(
                        body: GroteskText(
                          text: 'USSD Transfer',
                          fontSize: 14.sp,
                        ),
                        groupValue: _paymentType,
                        value: PaymentType.uSSDTransfer,
                        onChanged: (PaymentType value) {
                          setState(() {
                            _paymentType = value;
                          });
                        },
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
                    onClick: () => handleClick(),
                    text: "Proceed",
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void handleClick() {
    switch (_paymentType) {
      case PaymentType.bankTransfer:
        navigate(context, const BankTransferPayment());
        break;
      case PaymentType.linkedAccount:
        navigate(context, const LinkedAccountPayment());
        break;
      case PaymentType.uSSDTransfer:
        navigate(context, const USSDTransferPayment());
        break;
      default:
        // Handle any other cases or provide a default action if needed.
        break;
    }
  }
}

enum PaymentType { none, linkedAccount, bankTransfer, uSSDTransfer }
