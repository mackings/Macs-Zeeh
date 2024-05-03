import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/button.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/auth/data/state/auth_notifier.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/authenticated_user.dart';
import 'package:zeeh_mobile/feature/auth/view/login/login_screen.dart';
import 'package:zeeh_mobile/feature/auth/view/sign_up/verify_identity.dart';
import 'package:zeeh_mobile/feature/auth/view/widgets/header_widget.dart';
import 'package:zeeh_mobile/feature/provider.dart';

class CreateAccountSuccessScreen extends ConsumerStatefulWidget {
  const CreateAccountSuccessScreen({super.key});

  @override
  ConsumerState<CreateAccountSuccessScreen> createState() =>
      _CreateAccountSuccessScreenState();
}

class _CreateAccountSuccessScreenState
    extends ConsumerState<CreateAccountSuccessScreen> {
  AuthenticatedUser authUser = AuthenticatedUser();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateNotifierProvider);

    if (authState is CreatePinSuccess) {
      authUser = authState.authenticatedUser;
    }

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
                          children: [
                            // Success
                            const HeaderWidget(
                              showBackButton: false,
                              screenTitle: "Success",
                              showCancelButton: true,
                            ),

                            SizedBox(height: 100.h),

                            // Confetti Image
                            Image.asset(
                              ZeehAssets.confettiIcon,
                              height: 100.h,
                              width: 100.w,
                            ),

                            // Congrats David
                            SizedBox(height: 20.h),

                            SizedBox(
                              width: 240.w,
                              child: DMSanText(
                                text:
                                    "Congratulations ${authUser.firstName}! Your account has been successfully created.",
                                fontSize: 16.sp,
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w600,
                                maxLines: 3,
                              ),
                            ),

                            SizedBox(height: 40.h),

                            SizedBox(
                              width: 305.w,
                              child: DMSanText(
                                text:
                                    "To get your credit score, manage your finances and get personalized offers, you need to link your bank account(s)",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                textAlign: TextAlign.center,
                                maxLines: 4,
                              ),
                            ),

                            SizedBox(height: 60.h),

                            Column(
                              children: [
                                ZeehButton(
                                  onClick: () => navigate(
                                    context,
                                    const VerifyIdentityScreen(
                                      isSignUp: true,
                                    ),
                                  ),
                                  text: "Link Account",
                                ),
                                SizedBox(height: 20.h),
                                AppOutlinedButton(
                                  text: "Take Me Home",
                                  onPressed: () => navigate(
                                    context,
                                    const LoginScreen(),
                                  ),
                                ),
                              ],
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

    //  WillPopScope(
    //   onWillPop: () async {
    //     return false;
    //   },
    //   child: Scaffold(
    //     backgroundColor: ZeehColors.onboardingBackground,
    //     body: SingleChildScrollView(
    //       child: SizedBox(
    //         height: 812.h,
    //         width: 375.w,
    //         child: Stack(
    //           children: [
    //             const BackgroundModal(),

    //             // Login
    //             Positioned(
    //               bottom: 0,
    //               child: Container(
    //                 height: 744.h,
    //                 width: 375.w,
    //                 decoration: BoxDecoration(
    //                   color: const Color(0xffF8F9FD),
    //                   borderRadius: BorderRadius.only(
    //                     topLeft: Radius.circular(16.r),
    //                     topRight: Radius.circular(16.r),
    //                   ),
    //                 ),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     // Bar Level
    //                     const BarHeaderWidget(
    //                       blackBars: 1,
    //                       greyBars: 3,
    //                     ),

    //                     // Credentials
    //                     SizedBox(height: 16.h),

    //                     // We've sent a mail
    //                     Container(
    //                       width: 375.w,
    //                       decoration: const BoxDecoration(
    //                         color: Colors.white,
    //                       ),
    //                       padding: EdgeInsets.symmetric(horizontal: 24.0.w),
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           SizedBox(height: 16.h),

    //                           // Info!
    //                           SizedBox(
    //                             child: Column(
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: [
    //                                 GroteskText(
    //                                   text:
    //                                       "Congratulations ${authUser.firstName}! 🎉",
    //                                   fontSize: 18.sp,
    //                                   fontWeight: FontWeight.w500,
    //                                   maxLines: 2,
    //                                 ),
    //                                 GroteskText(
    //                                   text:
    //                                       "Your account has been successfully created.",
    //                                   fontSize: 18.sp,
    //                                   fontWeight: FontWeight.w500,
    //                                   maxLines: 2,
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                           SizedBox(height: 16.h),
    //                         ],
    //                       ),
    //                     ),

    //                     SizedBox(height: 16.h),

    //                     // Your Code
    //                     Container(
    //                       width: 375.w,
    //                       decoration: const BoxDecoration(
    //                         color: Colors.white,
    //                       ),
    //                       padding: EdgeInsets.symmetric(horizontal: 24.0.w),
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           SizedBox(height: 24.h),

    //                           // Full Name
    //                           Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               GroteskText(
    //                                 text:
    //                                     "Hollup! To get you started,  you need to setup your credit score to help you manage your finances and personalize your experience by tailoring interesting service offers that you are likely eligible for. Don’t want to miss out ?",
    //                                 fontSize: 14.sp,
    //                                 fontWeight: FontWeight.w400,
    //                                 maxLines: 6,
    //                               ),
    //                               SizedBox(height: 8.h),
    //                             ],
    //                           ),

    //                           SizedBox(height: 24.h),
    //                         ],
    //                       ),
    //                     ),

    //                     SizedBox(height: 16.h),

    //                     const Spacer(),

    //                     Center(
    //                       child: Column(
    //                         children: [
    //                           ZeehButton(
    //                             onClick: () => navigate(
    //                               context,
    //                               const VerifyIdentityScreen(),
    //                             ),
    //                             text: "Setup my credit score",
    //                           ),
    //                           SizedBox(height: 16.h),
    //                           ZeehButton(
    //                             onClick: () => navigateReplace(
    //                                 context, const LoginScreen()),
    //                             text: "Skip for later",
    //                             textColor: ZeehColors.blackColor,
    //                             buttonColor: Colors.transparent,
    //                             isOutline: true,
    //                             borderColor: ZeehColors.greyColor,
    //                           ),
    //                         ],
    //                       ),
    //                     ),

    //                     SizedBox(
    //                       height: 31.h,
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
