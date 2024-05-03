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
import 'package:zeeh_mobile/feature/auth/view/forgot_pin/enter_reset_pin_screen.dart';
import 'package:zeeh_mobile/feature/auth/view/widgets/header_widget.dart';
import 'package:zeeh_mobile/feature/profile/data/state/profile_state_notifier.dart';
import 'package:zeeh_mobile/feature/provider.dart';

class ResetPinScreen extends ConsumerStatefulWidget {
  const ResetPinScreen({super.key});

  @override
  ConsumerState<ResetPinScreen> createState() => _ResetPinScreenState();
}

class _ResetPinScreenState extends ConsumerState<ResetPinScreen> {
  final TextEditingController pinController = TextEditingController();

  bool isPinEntered = false;

  String email = "";

  String accessToken = "";

  void resetPin(WidgetRef ref) {
    ref.read(authStateNotifierProvider.notifier).resetPin(
          pinController.text.trim().substring(0, 6),
          accessToken,
        );
  }

  void handleResendCode(WidgetRef ref) {
    ref.read(authStateNotifierProvider.notifier).resendVerification(email);
  }

  @override
  void initState() {
    super.initState();

    resetTimer();
    startTimer();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final checkUserState = ref.watch(checkAccountStateNotifierProvider);

        final userState = ref.watch(profileStateNotifierProvider);

        if (checkUserState is CheckAccountSuccess) {
          email = checkUserState.responseModel.data["user"]["email"];
          accessToken = checkUserState.responseModel.data["access_token"];
        } else if (userState is UserDetailsSuccess) {
          email = userState.userDetails.email.toString();
          
        }

        if (email != "") {
          ref.read(authStateNotifierProvider.notifier).resendForgotPin(email);
        }
      },
    );

    pinController.addListener(
      () {
        setState(() {
          if (pinController.text.length == 6) {
            setState(() {
              isPinEntered = true;
            });
          } else {
            setState(() {
              isPinEntered = false;
            });
          }
        });
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

  @override
  Widget build(BuildContext context) {
    final checkUserState = ref.watch(checkAccountStateNotifierProvider);

    final authState = ref.watch(authStateNotifierProvider);

    if (checkUserState is CheckAccountSuccess) {
      email = checkUserState.responseModel.data["user"]["email"];
    }

    ref.listen(
      authStateNotifierProvider,
      (previous, next) {
        if (next is ResendVerificationPinSuccess) {
          AppSnackbar(context).showToast(
            text: next.responseModel.message.toString(),
          );
        }
      },
    );

    // Countdoewn Timer Strings
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(myDuration.inMinutes.remainder(2));

    final seconds = strDigits(myDuration.inSeconds.remainder(60));

    ref.listen(
      authStateNotifierProvider,
      (previous, next) {
        // Check Account Failure and Success
        if (next is ResetPinFailure) {
          AppSnackbar(context, isError: true).showToast(
            text: next.failure.message,
          );
        }
        if (next is ResetPinSuccess) {
          navigateReplace(context, const SetNewPinScreen());
        }
      },
    );

    return Scaffold(
      backgroundColor: ZeehColors.onboardingBackground,
      body: SingleChildScrollView(
        child: SizedBox(
          height: 812.h,
          width: 375.w,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                  child: Row(
                    children: [
                      Image.asset(
                        ZeehAssets.roundedZeehLogo,
                        height: 35.h,
                        width: 35.w,
                      ),
                    ],
                  ),
                ),
                // Create Account
                const HeaderWidget(
                  showBackButton: false,
                  screenTitle: "Reset Pin",
                  showCancelButton: false,
                ),

                // Credentials
                SizedBox(height: 10.h),

                Divider(
                  height: 1.h,
                  color: ZeehColors.greyColor.withOpacity(0.5),
                ),

                // Pin
                Container(
                  width: 375.w,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 48.h),
                        Image.asset(
                          ZeehAssets.shieldIcon,
                          height: 70.h,
                          width: 70.w,
                        ),

                        SizedBox(height: 16.h),

                        // Welcome Back!

                        // Enter your email to sign in
                        Column(
                          children: [
                            GroteskText(
                              text: "We’ve sent the code to your email address",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            GroteskText(
                              text: email,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),

                        // Email Address
                        SizedBox(height: 16.h),

                        // Pin Code
                        PinOTPFieldWidget(
                          width: 325.w,
                          controller: pinController,
                          length: 6,
                          obscureText: false,
                          fieldHeight: 48.h,
                          fieldWidth: 48.w,
                        ),

                        SizedBox(height: 24.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DMSanText(
                              text: "Didn't receive code?",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
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
                                  textColor: const Color(0xFF6936F5),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                Container(
                  width: 375.w,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 14.h),
                      if (authState is ResetPinLoading)
                        const AppLoadingButton()
                      else
                        ZeehButton(
                          onClick: () => resetPin(ref),
                          text: "Verify",
                          buttonColor: isPinEntered
                              ? ZeehColors.buttonPurple
                              : ZeehColors.greyColor,
                        ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
