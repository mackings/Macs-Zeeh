import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/button.dart';
import 'package:zeeh_mobile/common/components/pin_otp_field.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/components/textfield_box.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/Wallet/Transactions/successdialog.dart';

class Completetransaction extends ConsumerStatefulWidget {
  const Completetransaction({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CompletetransactionState();
}

class _CompletetransactionState extends ConsumerState<Completetransaction> {
  TextEditingController pinController = TextEditingController();
  bool _isChecked = false;
  @override
  void dispose() {
    pinController; 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFCFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DMSanText(
                    text: "Complete your transaction",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  DMSanText(
                    text:
                        "Type in your transaction PIN to authorise this transaction",
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 45.h,
                  ),
                  PinOTPFieldWidget(
                    controller: pinController,
                    length: 4,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 45.h,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Theme(
                            data: ThemeData(
                              unselectedWidgetColor: ZeehColors
                                  .greyColor,
                            ),
                            child: Checkbox(
                              value: _isChecked,
                              activeColor: Colors
                                  .blue,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked = value!;
                                });
                              },
                            ),
                          ),
                          DMSanText(
                            text: "Remember PIN for this device",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 230.h,
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: ZeehButton(
                        onClick: () {
                          navigate(context, Successdialog());
                        },
                        text: "Continue"),
                  )


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
