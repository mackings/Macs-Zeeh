import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/button.dart';
import 'package:zeeh_mobile/common/components/numeric_keypad.dart/num_pad.dart';
import 'package:zeeh_mobile/common/components/pin_otp_field.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/auth/model/response_model.dart';
import 'package:zeeh_mobile/feature/auth/view/sign_up/create_account/verify%20pin.dart';
import 'package:zeeh_mobile/feature/auth/view/widgets/header_widget.dart';

class CreatePinScreen extends ConsumerStatefulWidget {
  const CreatePinScreen({super.key});

  @override
  ConsumerState<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends ConsumerState<CreatePinScreen> {
  final TextEditingController pinController = TextEditingController();

  late String pin;

  ResponseModel responseModel = ResponseModel();

  bool isPinEntered = false;

  @override
  void initState() {
    super.initState();

    pinController.addListener(() {
      setState(() {
        if (pinController.text.length == 4) {
          isPinEntered = true;
        } else {
          isPinEntered = false;
        }
      });
    });
  }

  handleVerifyPin() {
    pin = pinController.text.trim().substring(0, 4);

    navigate(context, VerifyPinScreen(pin));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZeehColors.onboardingBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: 812.h,
                width: 375.w,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 406.h,
                      width: double.infinity,
                      child: FittedBox(
                        child: Image.asset(
                          ZeehAssets.onboardingImageBgV2,
                        ),
                      ),
                    ),

                    // OTP Verification
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 700.h,
                        width: 375.w,
                        decoration: BoxDecoration(
                          color: const Color(0xffF8F9FD),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.r),
                            topRight: Radius.circular(16.r),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Verify Pin
                            const HeaderWidget(
                              screenTitle: "Enter your pin",
                              showCancelButton: true,
                              showSignUpBars: true,
                              step: 3,
                            ),

                            SizedBox(height: 20.h),

                            // Password Icon
                            Image.asset(
                              ZeehAssets.passwordIcon,
                              height: 80.h,
                              width: 80.w,
                            ),

                            SizedBox(height: 10.h),

                            // Select a 4 digit password
                            DMSanText(
                              text:
                                  "Select a 4 digit pin to Login to your account",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),

                            SizedBox(height: 20.h),

                            // Pin Field
                            PinOTPFieldWidget(
                              controller: pinController,
                              length: 4,
                              obscureText: true,
                            ),

                            // Button Container
                            Container(
                              width: 375.w,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  NumPad(
                                    buttonSize: 50.w,
                                    buttonColor: Colors.white,
                                    iconColor: Colors.black,
                                    controller: pinController,
                                    delete: () {
                                      pinController.text = pinController.text
                                          .substring(
                                              0, pinController.text.length - 1);
                                    },
                                    // do something with the input numbers
                                    onSubmit: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          content: Text(
                                            "You code is ${pinController.text}",
                                            style:
                                                const TextStyle(fontSize: 30),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 30.h),
                                  ZeehButton(
                                    onClick: () => handleVerifyPin(),
                                    text: "Create pin",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
