import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zeeh_mobile/common/components/app_snackbar.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/auth/data/state/auth_notifier.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/token.dart';
import 'package:zeeh_mobile/feature/onboarding/view/onboarding_screen1.dart';
import 'package:zeeh_mobile/feature/profile/data/state/profile_state_notifier.dart';
import 'package:zeeh_mobile/feature/profile/model/user_details.dart';
import 'package:zeeh_mobile/feature/profile/view/account_security_screen.dart';
import 'package:zeeh_mobile/feature/profile/view/support_screen_webview.dart';
import 'package:zeeh_mobile/feature/profile/view/user_details_screen.dart';
import 'package:zeeh_mobile/feature/profile/view/widget/success_page_dialog.dart';
import 'package:zeeh_mobile/feature/provider.dart';
import 'package:zeeh_mobile/services/auth_manager/authmanager.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  UserDetails userDetails = UserDetails();

  bool isBiometricSwitch = false;

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(profileStateNotifierProvider);

    // final authState = ref.watch(authStateNotifierProvider);

    if (userState is UserDetailsSuccess) {
      userDetails = userState.userDetails;

      if (userDetails.biometrics == true) {
        isBiometricSwitch = true;
      } else if (userDetails.biometrics == false) {
        isBiometricSwitch = false;
      }
    }

    ref.listen(
      authStateNotifierProvider,
      (previous, next) {
        if (next is EnableBiometricSuccess) {
          if (next.responseModel.message == "Biometrics enabled") {
            AuthManager.instance.saveBiometricToken(
              Token(
                token: next.responseModel.data["token"],
              ),
            );
          }
          if (next.responseModel.message == "Biometrics disabled") {
            AuthManager.instance.clearBiometricToken();
          }
        }
      },
    );

    // Handle Delete Account
    ref.listen(
      profileStateNotifierProvider,
      (previous, next) {
        if (next is DeleteAccountLoading) {
          AppSnackbar(context, isError: true)
              .showToast(text: "Deleting Account in Progress...");
        } else if (next is DeleteAccountSuccess) {
          AuthManager.instance.clearAuthenticatedUser();
          AuthManager.instance.clearBiometricToken();

          pushUntil(context, const OnboardingScreen());

          // AppSnackbar(context, isError: true)
          //     .showToast(text: "Deleted Account Successfully");
        }
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50.h),

            // David Adebola
            Container(
              width: 375.w,
              height: 71.h,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFEBEBEB)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.0.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (userDetails.imageUrl != "")
                    Container(
                      width: 36.w,
                      height: 36.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ZeehColors.buttonPurple,
                        ),
                      ),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            userDetails.imageUrl.toString(),
                          ),
                        ),
                      ),
                    )
                  else if (userDetails.imageUrl == "")
                    SvgPicture.asset(
                      ZeehAssets.profileIcon,
                      height: 36.h,
                      width: 36.w,
                    ),
                  SizedBox(width: 8.w),
                  SizedBox(
                    height: 40.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DMSanText(
                          text:
                              '${userDetails.firstName} ${userDetails.lastName}',
                          textAlign: TextAlign.center,
                          textColor: const Color(0xFF242739),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        DMSanText(
                          text: 'Joined ${userDetails.createdAt}',
                          textColor: const Color(0xFF5F6D7E),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 2.h),

            Container(
              width: 375.w,
              height: 660.h,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DMSanText(
                    text: "Account",
                    fontSize: 14.sp,
                    textColor: const Color(0xFF5F6D7E),
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Divider(
                    thickness: 1.h,
                  ),

                  // Features
                  SizedBox(height: 20.h),
                  InkWell(
                    onTap: () => navigate(
                      context,
                      const UserDetailsScreen(),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(ZeehAssets.settingProfileIcon),
                        SizedBox(width: 20.w),
                        DMSanText(
                          text: "Personal information",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // InkWell(
                  //   onTap: () => navigate(
                  //     context,
                  //     const ActivityScreen(),
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       SvgPicture.asset(ZeehAssets.notificationsIcon),
                  //       SizedBox(width: 20.w),
                  //       DMSanText(
                  //         text: "Notifications",
                  //         fontWeight: FontWeight.w500,
                  //         fontSize: 14.sp,
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  // SizedBox(height: 20.h),

                  InkWell(
                    onTap: () => navigate(
                      context,
                      const AccountSecurityScreen(),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(ZeehAssets.squareLockIcon),
                        SizedBox(width: 20.w),
                        DMSanText(
                          text: "Account security",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  InkWell(
                    onTap: () => navigate(
                      context,
                      const SupportScreenWebView(),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(ZeehAssets.supportIconV2),
                        SizedBox(width: 20.w),
                        DMSanText(
                          text: "Support",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  InkWell(
                    onTap: () => navigate(
                      context,
                      const SupportScreenWebView(),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(ZeehAssets.bugIcon),
                        SizedBox(width: 20.w),
                        DMSanText(
                          text: "Report a bug",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30.h),

                  DMSanText(
                    text: "About us",
                    fontSize: 14.sp,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Divider(
                    thickness: 2.h,
                  ),

                  SizedBox(height: 20.h),

                  InkWell(
                    onTap: () => launchUrl(
                      Uri.parse("https://www.zeeh.africa/legal/privacy-policy"),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(ZeehAssets.privacyIcon),
                        SizedBox(width: 20.w),
                        DMSanText(
                          text: "Privacy policy",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  InkWell(
                    onTap: () => launchUrl(
                      Uri.parse("https://www.zeeh.africa/legal/terms-of-use"),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(ZeehAssets.termsIcon),
                        SizedBox(width: 20.w),
                        DMSanText(
                          text: "Terms of service",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  Divider(thickness: 2.h),

                  SizedBox(height: 20.h),

                  InkWell(
                    onTap: () => showCustomModalBottomSheet(
                      context,
                      child: SuccessPageDialog(
                        headerText: 'Delete Account',
                        bodyText:
                            'Are you sure you want to delete your account',
                        imagePath: ZeehAssets.failureSvgIcon,
                        twoButtons: true,
                        yesClick: () => {
                          ref
                              .read(profileStateNotifierProvider.notifier)
                              .deleteAccount(),
                        },
                        noClick: () => popView(context),
                      ),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(ZeehAssets.trashIcon),
                        SizedBox(width: 20.w),
                        DMSanText(
                          text: "Delete account",
                          fontWeight: FontWeight.w500,
                          textColor: const Color(0xFFE93131),
                          fontSize: 14.sp,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  InkWell(
                    onTap: () => showCustomModalBottomSheet(
                      context,
                      child: SuccessPageDialog(
                        headerText: 'Log out',
                        bodyText: 'Are you sure you want to log'
                            ' out from your account',
                        imagePath: ZeehAssets.failureSvgIcon,
                        twoButtons: true,
                        yesClick: () => {
                          pushUntil(context, const OnboardingScreen()),
                        },
                        noClick: () => popView(context),
                      ),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(ZeehAssets.logoutIcon),
                        SizedBox(width: 20.w),
                        DMSanText(
                          text: "Log out",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    // Scaffold(
    //   body: SingleChildScrollView(
    //     child: SizedBox(
    //       width: 375.w,
    //       child: Stack(
    //         children: [
    //           // Profile Screen
    //           Column(
    //             children: [
    //               const ProfileHeaderWidget(),
    //               SizedBox(height: 16.h),

    //               // Profile Information

    //               Container(
    //                 width: double.infinity,
    //                 decoration: const BoxDecoration(
    //                   color: Colors.white,
    //                 ),
    //                 child: Column(
    //                   children: [
    //                     SizedBox(height: 57.h),
    //                     SizedBox(
    //                       height: 64.h,
    //                       width: 64.w,
    //                       child: Column(
    //                         children: [
    //                           if (userDetails.imageUrl != "")
    //                             Container(
    //                               width: 64.w,
    //                               height: 64.h,
    //                               decoration: BoxDecoration(
    //                                 shape: BoxShape.circle,
    //                                 border: Border.all(
    //                                   color: ZeehColors.buttonPurple,
    //                                 ),
    //                               ),
    //                               child: FittedBox(
    //                                 fit: BoxFit.fill,
    //                                 child: CircleAvatar(
    //                                   backgroundImage: NetworkImage(
    //                                     userDetails.imageUrl.toString(),
    //                                   ),
    //                                 ),
    //                               ),
    //                             )
    //                           else if (userDetails.imageUrl == "")
    //                             SvgPicture.asset(
    //                               ZeehAssets.profileIcon,
    //                               height: 64.h,
    //                               width: 64.w,
    //                             ),
    //                         ],
    //                       ),
    //                     ),
    //                     SizedBox(height: 10.h),
    //                     Column(
    //                       children: [
    //                         GroteskText(
    //                           text:
    //                               "${userDetails.firstName} ${userDetails.lastName}",
    //                           fontWeight: FontWeight.w500,
    //                           fontSize: 16.sp,
    //                         ),
    //                         GroteskText(
    //                           text: "Joined ${userDetails.createdAt}",
    //                           fontSize: 12.sp,
    //                           fontWeight: FontWeight.w400,
    //                           textColor: ZeehColors.grayColor,
    //                         ),
    //                       ],
    //                     ),

    //                     SizedBox(height: 25.h),

    //                     // Personal, Support, Privacy & Security
    //                     Column(
    //                       children: [
    //                         ProfileMenuWidget(
    //                           onTap: () => navigate(
    //                             context,
    //                             const UserDetailsScreen(),
    //                           ),
    //                           title: "Personal",
    //                           assetPath: ZeehAssets.personalIcon,
    //                         ),
    //                         ProfileMenuWidget(
    //                           onTap: () => navigate(
    //                             context,
    //                             const SupportScreenWebView(),
    //                           ),
    //                           title: "Support",
    //                           assetPath: ZeehAssets.supportIcon,
    //                         ),
    //                         ProfileMenuWidget(
    //                           onTap: () {
    //                             launchUrl(
    //                               Uri.parse(
    //                                   "https://www.zeeh.africa/legal/privacy-policy"),
    //                             );
    //                           },
    //                           title: "Privacy & Security",
    //                           assetPath: ZeehAssets.securityIcon,
    //                         ),
    //                         InkWell(
    //                           onTap: () {},
    //                           child: Container(
    //                             padding: EdgeInsets.symmetric(
    //                                 horizontal: 28.w, vertical: 10.h),
    //                             child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: [
    //                                 Row(
    //                                   children: [
    //                                     SvgPicture.asset(
    //                                         ZeehAssets.scanFingerprintIcon),
    //                                     SizedBox(width: 12.w),
    //                                     Column(
    //                                       crossAxisAlignment:
    //                                           CrossAxisAlignment.start,
    //                                       children: [
    //                                         GroteskText(
    //                                           text: "Biometric",
    //                                           fontSize: 16.sp,
    //                                           fontWeight: FontWeight.w500,
    //                                         ),
    //                                         GroteskText(
    //                                           text:
    //                                               "Enable Biometric for Login",
    //                                           fontSize: 10.sp,
    //                                           fontWeight: FontWeight.w400,
    //                                         ),
    //                                       ],
    //                                     ),
    //                                     const Spacer(),
    //                                     Switch.adaptive(
    //                                       activeColor: ZeehColors.buttonPurple,
    //                                       activeTrackColor:
    //                                           ZeehColors.buttonPurple,
    //                                       value: isBiometricSwitch,
    //                                       onChanged: (biometricValue) {
    //                                         setState(() {
    //                                           isBiometricSwitch =
    //                                               biometricValue;
    //                                         });
    //                                         ref
    //                                             .read(authStateNotifierProvider
    //                                                 .notifier)
    //                                             .enableBiometric(
    //                                               isBiometricSwitch,
    //                                             )
    //                                             .then(
    //                                               (value) => ref
    //                                                   .read(
    //                                                       profileStateNotifierProvider
    //                                                           .notifier)
    //                                                   .userDetails(),
    //                                             );
    //                                       },
    //                                     ),
    //                                   ],
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                         ),
    //                         SizedBox(height: 10.h),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               ),

    //               SizedBox(height: 16.h),

    //               // Delete Account

    //               Container(
    //                 color: Colors.white,
    //                 height: 52.h,
    //                 width: double.infinity,
    //                 child: GestureDetector(
    //                   onTap: () => showCustomModalBottomSheet(
    //                     context,
    //                     child: SuccessPageDialog(
    //                       headerText: 'Delete Account',
    //                       bodyText:
    //                           'Are you sure you want to delete your account',
    //                       imagePath: ZeehAssets.failureSvgIcon,
    //                       twoButtons: true,
    //                       yesClick: () => {
    //                         ref
    //                             .read(profileStateNotifierProvider.notifier)
    //                             .deleteAccount(),
    //                       },
    //                       noClick: () => popView(context),
    //                     ),
    //                   ),
    //                   child: Center(
    //                     child: GroteskText(
    //                       text: "Delete Account",
    //                       fontSize: 16.sp,
    //                       textColor: ZeehColors.buttonPurple,
    //                     ),
    //                   ),
    //                 ),
    //               ),

    //               SizedBox(height: 16.h),

    //               Container(
    //                 color: Colors.white,
    //                 height: 52.h,
    //                 width: double.infinity,
    //                 child: GestureDetector(
    //                   onTap: () => showCustomModalBottomSheet(
    //                     context,
    //                     child: SuccessPageDialog(
    //                       headerText: 'Log out',
    //                       bodyText: 'Are you sure you want to log'
    //                           ' out from your account',
    //                       imagePath: ZeehAssets.failureSvgIcon,
    //                       twoButtons: true,
    //                       yesClick: () => {
    //                         pushUntil(context, const AlmostThereScreen()),
    //                         AuthManager.instance.clearAuthenticatedUser(),
    //                       },
    //                       noClick: () => popView(context),
    //                     ),
    //                   ), //
    //                   child: Center(
    //                     child: GroteskText(
    //                       text: "Log out",
    //                       fontSize: 16.sp,
    //                       textColor: ZeehColors.buttonPurple,
    //                     ),
    //                   ),
    //                 ),
    //               ),

    //               SizedBox(height: 16.h),

    //               Container(
    //                 color: Colors.white,
    //                 height: 105.h,
    //                 width: double.infinity,
    //                 child: Center(
    //                   child: Column(
    //                     children: [
    //                       SizedBox(height: 16.h),
    //                       GroteskText(
    //                         text: "UseZeeh’s Privacy Policy, Terms of Service",
    //                         fontSize: 12.sp,
    //                       ),
    //                       SizedBox(height: 16.h),
    //                       GroteskText(
    //                         text: "Copyright 2023 | UseZeeh",
    //                         fontSize: 12.sp,
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),

    //           if (authState is EnableBiometricLoading ||
    //               userState is UserDetailsLoading)
    //             Container(
    //               height: 812.h,
    //               width: 375.w,
    //               decoration: BoxDecoration(
    //                 color: Colors.grey.withOpacity(0.8),
    //               ),
    //               child: Center(
    //                 child: LoadingIndicatorWidget(
    //                   height: 40.h,
    //                   width: 40.w,
    //                 ),
    //               ),
    //             ),

    //           // Delete Account Loading State
    //           if (userState is DeleteAccountLoading)
    //             const FinnacleLoadingWidget(
    //               loadingText: "Deleting Account...",
    //             ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    this.title,
    this.assetPath,
    this.onTap,
  });

  final String? title;
  final String? assetPath;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(assetPath ?? ZeehAssets.personalIcon),
                SizedBox(width: 12.w),
                GroteskText(
                  text: title ?? "",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
                const Spacer(),
                SizedBox(
                  height: 20.h,
                  width: 8.w,
                  child: const Icon(
                    Icons.keyboard_arrow_right_rounded,
                    color: ZeehColors.grayColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Divider(height: 1.h, color: ZeehColors.grayColor),
          ],
        ),
      ),
    );
  }
}
