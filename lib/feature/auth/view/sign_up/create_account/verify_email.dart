import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/app_snackbar.dart';
import 'package:zeeh_mobile/common/components/button.dart';
import 'package:zeeh_mobile/common/components/pin_otp_field.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/auth/data/state/auth_notifier.dart';
import 'package:zeeh_mobile/feature/auth/view/sign_up/create_account/create_pin.dart';
import 'package:zeeh_mobile/feature/auth/view/widgets/header_widget.dart';
import 'package:zeeh_mobile/feature/provider.dart';

class VerifyEmailScreen extends ConsumerStatefulWidget {
  const VerifyEmailScreen({
    super.key,
    required this.isInitialSignUp,
    required this.email,
  });

  final String email;
  final bool isInitialSignUp;

  @override
  ConsumerState<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends ConsumerState<VerifyEmailScreen> {
  TextEditingController codeController = TextEditingController();

  bool isCodeEntered = false;

  String email = "";

  @override
  void initState() {
    super.initState();
    codeController.addListener(
      () {
        setState(() {
          if (codeController.text.length == 6) {
            isCodeEntered = true;
          } else {
            isCodeEntered = false;
          }
        });
      },
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        resetTimer();
        startTimer();

        final authState = ref.watch(authStateNotifierProvider);

        if (authState is RegisterSuccessState) {
          email = authState.user.user?.email ?? "";
        }

        if (widget.isInitialSignUp == false) {
          ref.read(authStateNotifierProvider.notifier).resendForgotPin(email);

          debugPrint("running");
        }
      },
    );
  }

  bool startedTimer = false;

  ///////////////// Countdown Timer /////////////////////
  Timer? countdownTimer;
  Duration myDuration = const Duration(minutes: 1);

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountdown());

    Future.delayed(
      const Duration(seconds: 2),
      () => setState(
        () {
          startedTimer = true;
        },
      ),
    );
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel);
  }

  void resetTimer() {
    setState(() => myDuration = const Duration(minutes: 1));
  }

  void setCountdown() {
    int reduceSecondsBy = 1;
    if (mounted) {
      setState(() {
        final seconds = myDuration.inSeconds - reduceSecondsBy;

        if (seconds < 0) {
          countdownTimer!.cancel();
        } else {
          myDuration = Duration(seconds: seconds);
        }
      });
    }
  }

  // verify email
  void verifyEmail(WidgetRef ref) {
    if (isCodeEntered) {
      ref
          .read(authStateNotifierProvider.notifier)
          .accountVerification(codeController.text);
    }
  }

  // resend verification code
  void handleResendCode(WidgetRef ref) {
    ref.read(authStateNotifierProvider.notifier).resendVerification(email);
  }

  @override
  Widget build(BuildContext context) {
    final registerState = ref.watch(registerUserStateNotifierProvider);

    // Countdoewn Timer Strings
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(myDuration.inMinutes.remainder(2));

    final seconds = strDigits(myDuration.inSeconds.remainder(60));

    final authState = ref.watch(authStateNotifierProvider);

    if (registerState is RegisterSuccessState) {
      email = registerState.user.user?.email ?? "";
    }

    ref.listen(
      authStateNotifierProvider,
      (previous, next) {
        if (next is AccountVerificationFailure) {
          stopTimer();
          resetTimer();
          AppSnackbar(context, isError: true)
              .showToast(text: next.failure.message);
        } else if (next is AccountVerificationSuccess) {
          stopTimer();
          resetTimer();
          startTimer();
          navigateReplace(context, const CreatePinScreen());
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
                            // OTP Verification
                            const HeaderWidget(
                              screenTitle: "Verify your email",
                              showCancelButton: true,
                              showSignUpBars: true,
                              step: 2,
                            ),

                            SizedBox(height: 50.h),

                            // Shield Icon
                            Image.asset(
                              ZeehAssets.shieldIcon,
                              height: 70.h,
                              width: 70.w,
                            ),

                            SizedBox(height: 10.h),

                            SizedBox(
                              width: 288.w,
                              child: DMSanText(
                                text:
                                    "We’ve sent the code to your email address ${widget.email}.",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                textColor: const Color(0xff242739),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              ),
                            ),

                            SizedBox(height: 20.h),

                            // Pin Code
                            PinOTPFieldWidget(
                              width: 325.w,
                              controller: codeController,
                              length: 6,
                              obscureText: false,
                              fieldHeight: 48.h,
                              fieldWidth: 48.w,
                            ),

                            SizedBox(height: 30.h),

                            // Didn't receive code? Resend
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DMSanText(
                                  text: "Didn't receive code?",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  textColor: const Color(0xff5F6D7E),
                                ),
                                SizedBox(width: 5.w),
                                if (minutes != "00" && seconds != "00")
                                  DMSanText(
                                    text: "$minutes:$seconds",
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                    textColor: const Color(0xff6936F5),
                                  )
                                else
                                  InkWell(
                                    onTap: () => handleResendCode(ref),
                                    child: DMSanText(
                                      text: "Resend Code",
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: 20.h),

                            // Verify
                            if (authState is AccountVerificationLoading)
                              const AppLoadingButton()
                            else
                              ZeehButton(
                                onClick: () => verifyEmail(ref),
                                text: "Verify",
                                buttonColor: isCodeEntered
                                    ? ZeehColors.buttonPurple
                                    : const Color(0xffB4B2B9),
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

    // Scaffold(
    //   backgroundColor: ZeehColors.onboardingBackground,
    //   body: SingleChildScrollView(
    //     child: SizedBox(
    //       height: 812.h,
    //       width: 375.w,
    //       child: Stack(
    //         children: [
    //           const BackgroundModal(),

    //           // Login
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
    //                   // Login
    //                   const HeaderWidget(
    //                     screenTitle: "Verify your email",
    //                     showCancelButton: false,
    //                   ),

    //                   // Credentials
    //                   SizedBox(height: 16.h),

    //                   // We've sent a mail
    //                   Container(
    //                     width: 375.w,
    //                     decoration: const BoxDecoration(
    //                       color: Colors.white,
    //                     ),
    //                     padding: EdgeInsets.symmetric(horizontal: 24.0.w),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         SizedBox(height: 16.h),

    //                         // Info!
    //                         SizedBox(
    //                           width: 250.w,
    //                           child: Column(
    //                             crossAxisAlignment:
    //                                 CrossAxisAlignment.start,
    //                             children: [
    //                               GroteskText(
    //                                 text:
    //                                     "We’ve sent your 6-digit code to!",
    //                                 fontSize: 16.sp,
    //                                 fontWeight: FontWeight.w400,
    //                                 maxLines: 2,
    //                               ),
    //                               GroteskText(
    //                                 text: "${widget.email}!",
    //                                 fontSize: 16.sp,
    //                                 fontWeight: FontWeight.w500,
    //                                 maxLines: 2,
    //                                 textColor: ZeehColors.grayColor,
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                         SizedBox(height: 16.h),
    //                       ],
    //                     ),
    //                   ),

    //                   SizedBox(height: 16.h),

    //                   // Your Code
    //                   Container(
    //                     width: 375.w,
    //                     decoration: const BoxDecoration(
    //                       color: Colors.white,
    //                     ),
    //                     padding: EdgeInsets.symmetric(horizontal: 24.0.w),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         SizedBox(height: 24.h),

    //                         // Full Name
    //                         Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             GroteskText(
    //                               text: "Your Code",
    //                               fontSize: 14.sp,
    //                               fontWeight: FontWeight.w500,
    //                             ),
    //                             SizedBox(height: 8.h),
    //                             TextFieldBox(
    //                               keyboardType: TextInputType.number,
    //                               inputFormatters: [
    //                                 LengthLimitingTextInputFormatter(6),
    //                                 FilteringTextInputFormatter.digitsOnly,
    //                               ],
    //                               controller: codeController,
    //                               hintText: "*** ***",
    //                             ),
    //                           ],
    //                         ),

    //                         SizedBox(height: 24.h),
    //                       ],
    //                     ),
    //                   ),

    //                   SizedBox(height: 16.h),

    //                   // Resend Code in email
    //                   Container(
    //                     width: 375.w,
    //                     decoration: const BoxDecoration(
    //                       color: Colors.white,
    //                     ),
    //                     padding: EdgeInsets.symmetric(horizontal: 24.0.w),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         SizedBox(height: 16.h),

    //                         // Resend Code
    //                         InkWell(
    //                           onTap: () => handleResendCode(ref),
    //                           child: SizedBox(
    //                             child: GroteskText(
    //                               text: "Resend code via email",
    //                               textColor: ZeehColors.buttonPurple,
    //                               fontSize: 14.sp,
    //                               fontWeight: FontWeight.w500,
    //                             ),
    //                           ),
    //                         ),

    //                         SizedBox(height: 16.h),
    //                       ],
    //                     ),
    //                   ),

    //                   SizedBox(height: 16.h),

    //                   // Resend Code in email
    //                   Container(
    //                     width: 375.w,
    //                     decoration: const BoxDecoration(
    //                       color: Colors.white,
    //                     ),
    //                     padding: EdgeInsets.symmetric(horizontal: 24.0.w),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         SizedBox(height: 16.h),

    //                         // Full Name
    //                         GroteskText(
    //                           text: "Resend code via phone number",
    //                           textColor: ZeehColors.buttonPurple,
    //                           fontSize: 14.sp,
    //                           fontWeight: FontWeight.w500,
    //                         ),

    //                         SizedBox(height: 16.h),
    //                       ],
    //                     ),
    //                   ),

    //                   const Spacer(),

    //                   Center(
    //                     child: ZeehButton(
    //                       onClick: () => verifyEmail(ref),
    //                       text: "Verify",
    //                       buttonColor: isCodeEntered
    //                           ? ZeehColors.buttonPurple
    //                           : const Color(0xffB4B2B9),
    //                     ),
    //                   ),

    //                   SizedBox(
    //                     height: 31.h,
    //                   )
    //                 ],
    //               ),
    //             ),
    //           ),

    //           if (authState is AccountVerificationLoading)
    //             const FinnacleLoadingWidget(
    //               loadingText: "Verifying...",
    //             )
    //           else if (authState is ResendVerificationLoading)
    //             const FinnacleLoadingWidget(
    //               loadingText: "Resending...",
    //             )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
