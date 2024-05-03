import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/button.dart';
import 'package:zeeh_mobile/common/components/numeric_keypad.dart/num_pad.dart';
import 'package:zeeh_mobile/common/components/pin_otp_field.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/feature/auth/view/widgets/header_widget.dart';
import 'package:zeeh_mobile/services/auth_manager/authmanager.dart';

import '../../../../../common/components/app_snackbar.dart';
import '../../../../../common/utils/navigator.dart';
import '../../../../../constants/colors.dart';
import '../../../../provider.dart';
import '../../../data/state/auth_notifier.dart';
import '../../../model/response_model.dart';
import '../success_create_account.dart';

class VerifyPinScreen extends ConsumerStatefulWidget {
  const VerifyPinScreen(this.pin, {super.key});

  final String pin;

  @override
  ConsumerState createState() => _VerifyPinScreenState();
}

class _VerifyPinScreenState extends ConsumerState<VerifyPinScreen> {
  final TextEditingController pinController = TextEditingController();

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

  handleVerifyPin(WidgetRef ref) {
    final pin2 = pinController.text.trim().substring(0, 4);
    if (pin2 == widget.pin) {
      ref
          .read(authStateNotifierProvider.notifier)
          .createPin(pin2, token: AuthManager.instance.user?.token);
    } else {
      AppSnackbar(context, isError: true).showToast(text: 'Mis-matched pins');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateNotifierProvider);

    ref.listen(
      authStateNotifierProvider,
      (previous, next) {
        if (next is CreatePinFailure) {
          AppSnackbar(context, isError: true)
              .showToast(text: next.failure.message);
        } else if (next is CreatePinSuccess) {
          popView(context);
          popView(context);

          navigateReplace(context, const CreateAccountSuccessScreen());
        }
      },
    );

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
                              screenTitle: "Confirm your pin",
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
                                  "Kindly confirm 4 digit pin of your account",
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

                                  /// Loading and Verify Button
                                  if (authState is CreatePinLoading)
                                    const AppLoadingButton()
                                  else
                                    ZeehButton(
                                      onClick: () => handleVerifyPin(ref),
                                      text: "Confirm pin",
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

    //  Scaffold(
    //   backgroundColor: ZeehColors.onboardingBackground,
    //   body: SingleChildScrollView(
    //     child: SizedBox(
    //       height: 812.h,
    //       width: 375.w,
    //       child: Stack(
    //         children: [
    //           // Create Pin Screen
    //           const BackgroundModal(),
    //           Positioned(
    //             bottom: 0,
    //             child: Container(
    //               height: 744.h,
    //               width: 375.w,
    //               decoration: BoxDecoration(
    //                 color: const Color(0xffF8F9FD),
    //                 borderRadius: BorderRadius.only(
    //                   topLeft: Radius.circular(16.r),
    //                   topRight: Radius.circular(16.r),
    //                 ),
    //               ),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   // Create Account
    //                   const HeaderWidget(
    //                     screenTitle: "Verify your pin",
    //                     showCancelButton: false,
    //                   ),

    //                   // Credentials
    //                   SizedBox(height: 16.h),

    //                   // Pin
    //                   Container(
    //                     width: 375.w,
    //                     height: 180.h,
    //                     decoration: const BoxDecoration(
    //                       color: Colors.white,
    //                     ),
    //                     child: Padding(
    //                       padding: EdgeInsets.symmetric(horizontal: 24.0.w),
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.center,
    //                         children: [
    //                           SizedBox(height: 16.h),

    //                           // Welcome Back!
    //                           GroteskText(
    //                             text: "Please re-enter the pin",
    //                             fontSize: 18.sp,
    //                             fontWeight: FontWeight.w500,
    //                           ),
    //                           SizedBox(height: 5.h),

    //                           // Enter your email to sign in
    //                           GroteskText(
    //                             text:
    //                                 "Re-enter the 4 digit pin to sign in to your account",
    //                             fontSize: 12.sp,
    //                             fontWeight: FontWeight.w400,
    //                           ),

    //                           // Email Address
    //                           SizedBox(height: 16.h),

    //                           // Pin Code
    //                           PinOTPFieldWidget(
    //                             controller: pinController,
    //                             length: 4,
    //                             obscureText: true,
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),

    //                   SizedBox(height: 16.h),

    //                   // Button Input
    //                   Container(
    //                     width: 375.w,
    //                     height: 340.h,
    //                     decoration: const BoxDecoration(
    //                       color: Colors.white,
    //                     ),
    //                     child: NumPad(
    //                       buttonSize: 50.w,
    //                       buttonColor: Colors.white,
    //                       iconColor: Colors.black,
    //                       controller: pinController,
    //                       delete: () {
    //                         pinController.text = pinController.text
    //                             .substring(0, pinController.text.length - 1);
    //                       },
    //                       // do something with the input numbers
    //                       onSubmit: () {
    //                         showDialog(
    //                           context: context,
    //                           builder: (_) => AlertDialog(
    //                             content: Text(
    //                               "You code is ${pinController.text}",
    //                               style: const TextStyle(fontSize: 30),
    //                             ),
    //                           ),
    //                         );
    //                       },
    //                     ),
    //                   ),

    //                   Container(
    //                     width: 375.w,
    //                     height: 102.h,
    //                     decoration: const BoxDecoration(
    //                       color: Colors.white,
    //                     ),
    //                     child: Column(
    //                       children: [
    //                         SizedBox(height: 14.h),
    //                         ZeehButton(
    //                           onClick: () => handleVerifyPin(ref),
    //                           text: "Continue",
    //                           buttonColor: isPinEntered
    //                               ? ZeehColors.buttonPurple
    //                               : ZeehColors.greyColor,
    //                         ),
    //                         SizedBox(height: 24.h),
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),

    //           if (authState is CreatePinLoading)
    //             const FinnacleLoadingWidget(
    //               loadingText: "Creating Pin...",
    //             ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
