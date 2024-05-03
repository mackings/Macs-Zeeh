import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/button.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/components/textfield_box.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/Wallet/Transactions/completetransaction.dart';

class SendTransaction extends ConsumerStatefulWidget {
  const SendTransaction({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SendTransactionState();
}

class _SendTransactionState extends ConsumerState<SendTransaction> {
  String _selectedCurrency = 'NGN';

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFCFC),
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: DMSanText(
                    text: "Send to a new recipient wallet",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DMSanText(
                      text: "Amount to send",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 10.h),
                    TextFieldBox(
                      hintText: "Enter amount",
                      // prefixText: "Naira",
                      prefixIcon: Icon(Icons.attach_money),
        
                      suffixIcon: DropdownButton<String>(
                        icon: Icon(Icons.arrow_drop_down),
                        value: _selectedCurrency,
                        underline: Container(),
                        items: <String>['NGN', 'USD'].map((String value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: DMSanText(
                                text: value,
                                fontSize: 14,
                              ));
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedCurrency = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DMSanText(
                      text: "Recipient's account number",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 10.h),
                    TextFieldBox(
                      hintText: "Acount number",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DMSanText(
                      text: "Recipient's account name",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 10.h),
                    TextFieldBox(
                      hintText: "Accont name",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 210.h,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                child: ZeehButton(
                    onClick: () {
                      navigate(context, Completetransaction());
                    },
                    text: "Continue"),
              )
            ],
          ),
        ));
  }
}
