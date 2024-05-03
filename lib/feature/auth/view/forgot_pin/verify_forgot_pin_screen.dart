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
import 'package:zeeh_mobile/feature/auth/view/forgot_pin/reset_pin_success.dart';
import 'package:zeeh_mobile/feature/auth/view/widgets/background_modal.dart';
import 'package:zeeh_mobile/feature/auth/view/widgets/header_widget.dart';
import 'package:zeeh_mobile/feature/provider.dart';

class VerifyResetPinScreen extends ConsumerStatefulWidget {
  const VerifyResetPinScreen({super.key, required this.pin});

  final String pin;

  @override
  ConsumerState<VerifyResetPinScreen> createState() =>
      _VerifyForgotPinCodeState();
}

class _VerifyForgotPinCodeState extends ConsumerState<VerifyResetPinScreen> {
  TextEditingController codeController = TextEditingController();

  bool isPinEntered = false;

  String token = "";

  void handleResetPin(WidgetRef ref) {
    final checkAccountState = ref.watch(checkAccountStateNotifierProvider);

    if (checkAccountState is CheckAccountSuccess) {
      token = checkAccountState.responseModel.data["access_token"];
    }

    final pin = codeController.text.trim().substring(0, 4);

    if (pin == widget.pin && token != "") {
      ref.read(authStateNotifierProvider.notifier).createPin(
            codeController.text.trim().substring(0, 4),
            token: token,
          );
    } else {
      AppSnackbar(context, isError: true).showToast(text: 'Mis-matched pin');
    }
  }

  @override
  void initState() {
    super.initState();
    codeController.addListener(
      () {
        setState(
          () {
            if (codeController.text.length == 4) {
              setState(() {
                isPinEntered = true;
              });
            } else {
              setState(() {
                isPinEntered = false;
              });
            }
          },
        );
      },
    );
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
          navigateReplace(
            context,
            const ResetPinSuccessScreen(),
          );
        }
      },
    );

    return Scaffold(
      backgroundColor: ZeehColors.onboardingBackground,
      body: SingleChildScrollView(
        child: SizedBox(
          height: 812.h,
          width: 375.w,
          child: Stack(
            children: [
              const BackgroundModal(),

              // Login
              Positioned(
                bottom: 0,
                child: Container(
                  height: 744.h,
                  width: 375.w,
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
                      // Login
                      const HeaderWidget(
                        screenTitle: "Confirm New Pin",
                        showCancelButton: false,
                      ),

                      // Credentials
                      SizedBox(height: 16.h),

                      // We've sent a mail
                      Container(
                        width: 375.w,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
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

                              // Info!
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  DMSanText(
                                    text:
                                        "Re-Enter the 4 Digit Pin to Reset Pin",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),

                              // Pin Code
                              PinOTPFieldWidget(
                                controller: codeController,
                                length: 4,
                                obscureText: true,
                                fieldHeight: 56.h,
                                fieldWidth: 56.w,
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      Container(
                        width: 375.w,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 14.h),
                            if (authState is CreatePinLoading)
                              const AppLoadingButton()
                            else
                              ZeehButton(
                                onClick: () => handleResetPin(ref),
                                text: "Confirm Pin",
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
            ],
          ),
        ),
      ),
    );
  }
}
