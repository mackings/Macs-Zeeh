import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/loading_indicator.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/auth/data/state/auth_notifier.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/token.dart';
import 'package:zeeh_mobile/feature/auth/view/forgot_pin/reset_pin_screen.dart';
import 'package:zeeh_mobile/feature/auth/view/widgets/header_widget.dart';
import 'package:zeeh_mobile/feature/profile/data/state/profile_state_notifier.dart';
import 'package:zeeh_mobile/feature/profile/model/user_details.dart';
import 'package:zeeh_mobile/feature/provider.dart';
import 'package:zeeh_mobile/services/auth_manager/authmanager.dart';

class AccountSecurityScreen extends ConsumerStatefulWidget {
  const AccountSecurityScreen({super.key});

  @override
  ConsumerState<AccountSecurityScreen> createState() =>
      _AccountSecurityScreenState();
}

class _AccountSecurityScreenState extends ConsumerState<AccountSecurityScreen> {
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

    final authState = ref.watch(authStateNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            height: 812.h,
            width: 375.w,
            child: Column(
              children: [
                SizedBox(height: 60.h),
                const HeaderWidget(
                  screenTitle: "Account Security",
                  showBackButton: true,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => {
                          navigate(
                            context,
                            const ResetPinScreen(),
                          )
                        },
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DMSanText(
                                  text: "Change pin",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                SizedBox(width: 4.h),
                                SizedBox(
                                  width: 206.w,
                                  child: DMSanText(
                                    text: "Change your login pin",
                                    fontSize: 11.sp,
                                    maxLines: 4,
                                    fontWeight: FontWeight.w400,
                                    textColor: const Color(0xFF5F6D7E),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.chevron_right_rounded,
                              color: ZeehColors.grayColor,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 32.h),
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DMSanText(
                                text: "Enable Biometrics",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(width: 4.h),
                              SizedBox(
                                width: 206.w,
                                child: DMSanText(
                                  text:
                                      "Enable or disable biometrics for login",
                                  fontSize: 11.sp,
                                  maxLines: 4,
                                  fontWeight: FontWeight.w400,
                                  textColor: const Color(0xFF5F6D7E),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Switch.adaptive(
                            activeColor: ZeehColors.buttonPurple,
                            activeTrackColor: ZeehColors.buttonPurple,
                            value: isBiometricSwitch,
                            onChanged: (biometricValue) {
                              setState(() {
                                isBiometricSwitch = biometricValue;
                              });
                              ref
                                  .read(authStateNotifierProvider.notifier)
                                  .enableBiometric(
                                    isBiometricSwitch,
                                  )
                                  .then(
                                    (value) => ref
                                        .read(profileStateNotifierProvider
                                            .notifier)
                                        .userDetails(),
                                  );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Loading Overlay
          if (authState is EnableBiometricLoading)
            Container(
              height: 812.h,
              width: 375.w,
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: LoadingIndicatorWidget(
                  color: ZeehColors.buttonPurple,
                  height: 40.h,
                  width: 40.w,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
