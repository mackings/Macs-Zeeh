import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zeeh_mobile/common/components/app_snackbar.dart';
import 'package:zeeh_mobile/common/components/button.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/components/textfield_box.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/auth/data/state/auth_notifier.dart';
import 'package:zeeh_mobile/feature/auth/view/sign_up/create_account/verify_email.dart';
import 'package:zeeh_mobile/feature/auth/view/widgets/header_widget.dart';
import 'package:zeeh_mobile/feature/provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class CreateAccountScreen extends ConsumerStatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  ConsumerState<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  // Create Account
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? validator(String? value, String field) {
    if (field == "First Name" && value!.contains(RegExp(r'^[0-9]'))) {
      return "$field isn't valid";
    } else if (field == "Last Name" && value!.contains(RegExp(r'^[0-9]'))) {
      return "$field isn't valid";
    } else if (value!.trim().isEmpty) {
      return "$field cannot be empty";
    } else if (field == "Email" && !value.contains(RegExp(r'@'))) {
      return "$field isn't valid";
    } else if (field == 'Phone Number' && value.contains(RegExp(r'[a-zA-Z]'))) {
      return "Phone number isn't valid";
    } else if (field == 'Phone Number' && value.length != 11) {
      return "Phone number length isn't valid";
    } else {
      return null;
    }
  }

  void handleCreateAccount(WidgetRef ref) async {
    // Firebase Service
    final firebaseMessaging = FirebaseMessaging.instance;
    String? fcmToken = await firebaseMessaging.getToken();

    if (_formKey.currentState!.validate()) {
      ref.read(registerUserStateNotifierProvider.notifier).register(
            firstName: firstNameController.text.trim(),
            lastName: lastNameController.text.trim(),
            email: emailController.text.trim(),
            phoneNumber: phoneNumberController.text.trim(),
            fcm: "$fcmToken",
          );
          
    } else {

      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(registerUserStateNotifierProvider);

    ref.listen(
      registerUserStateNotifierProvider,
      (previous, next) {
        if (next is RegisterSuccessState) {
          FirebaseAnalytics.instance.logEvent(name: "sign_up");
          navigateReplace(
            context,
            VerifyEmailScreen(
              email: emailController.text,
              isInitialSignUp: true,
            ),
          );
        } else if (next is RegisterFailureState) {
          AppSnackbar(context, isError: true)
              .showToast(text: next.failure.message);
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
                        fit: BoxFit.fill,
                        child: Image.asset(
                          ZeehAssets.onboardingImageBgV2,
                        ),
                      ),
                    ),

                    // Login
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 700.h,
                        width: 375.w,
                        decoration: BoxDecoration(
                          color: const Color(0xffF8F9FD),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32.r),
                            topRight: Radius.circular(32.r),
                          ),
                        ),
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Login
                                const HeaderWidget(
                                  screenTitle: "Create account",
                                  showCancelButton: true,
                                  showSignUpBars: true,
                                  step: 1,
                                ),

                                // Full Name, Email Address, Phone Number
                                Container(
                                  width: 375.w,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 24.0.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 24.h),

                                        // First Name
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            DMSanText(
                                              text: "First name",
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            SizedBox(height: 5.h),
                                            TextFieldBox(
                                              controller: firstNameController,
                                              hintText: "Your first name ",
                                              validator: (String? value) =>
                                                  validator(
                                                value,
                                                "First Name",
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: 30.h),

                                        // Last Name
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            DMSanText(
                                              text: "Last name",
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            SizedBox(height: 5.h),
                                            TextFieldBox(
                                              controller: lastNameController,
                                              hintText: "Your last name ",
                                              validator: (String? value) =>
                                                  validator(value, "Last Name"),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: 30.h),

                                        // First Name
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            DMSanText(
                                              text: "Email address",
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            SizedBox(height: 5.h),
                                            TextFieldBox(
                                              controller: emailController,
                                              hintText: "Your email address ",
                                              validator: (String? value) =>
                                                  validator(value, "Email"),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: 30.h),

                                        // Phone Number
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            DMSanText(
                                              text: "Phone Number",
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            SizedBox(height: 5.h),
                                            TextFieldBox(
                                              controller: phoneNumberController,
                                              hintText:
                                                  "Enter your phone number",
                                              validator: (String? value) =>
                                                  validator(
                                                      value, "Phone Number"),
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    11),
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: 50.h),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            DMSanText(
                                              text:
                                                  "By clicking “Continue”, you agree to ZeeH’s",
                                              fontSize: 10.sp,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () => launchUrl(
                                                    Uri.parse(
                                                        "https://www.zeeh.africa/legal/terms-of-use"),
                                                  ),
                                                  child: DMSanText(
                                                    text: "T&C ",
                                                    fontSize: 10.sp,
                                                    textColor:
                                                        ZeehColors.buttonPurple,
                                                  ),
                                                ),
                                                DMSanText(
                                                  text: "and ",
                                                  fontSize: 10.sp,
                                                ),
                                                InkWell(
                                                  onTap: () => launchUrl(
                                                    Uri.parse(
                                                        "https://www.zeeh.africa/legal/privacy-policy"),
                                                  ),
                                                  child: DMSanText(
                                                    text: "Privacy policy",
                                                    fontSize: 10.sp,
                                                    textColor:
                                                        ZeehColors.buttonPurple,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: 10.h),

                                        if (authState is RegisterLoadingState)
                                          const AppLoadingButton(
                                            color: ZeehColors.buttonPurple,
                                          )
                                        else
                                          ZeehButton(
                                            onClick: () =>
                                                handleCreateAccount(ref),
                                            text: "Continue",
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
    //     child: Column(
    //       children: [
    //         // Create Account Screen
    //         SingleChildScrollView(
    //           child: SizedBox(
    //             height: 812.h,
    //             width: 375.w,
    //             child: Stack(
    //               children: [
    //                 const BackgroundModal(),
    //                 Positioned(
    //                   bottom: 0,
    //                   child: Container(
    //                     // height: 750.h,
    //                     width: 375.w,
    //                     decoration: BoxDecoration(
    //                       color: const Color(0xffF8F9FD),
    //                       borderRadius: BorderRadius.only(
    //                         topLeft: Radius.circular(16.r),
    //                         topRight: Radius.circular(16.r),
    //                       ),
    //                     ),
    //                     child: Form(
    //                       key: _formKey,
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           // Create Account
    //                           const HeaderWidget(
    //                             showCancelButton: true,
    //                           ),

    //                           // Credentials
    //                           SizedBox(height: 16.h),

    //                           // Full Name, Email Address, Phone Number
    //                           Container(
    //                             width: 375.w,
    //                             height: 645.h,
    //                             decoration: const BoxDecoration(
    //                               color: Colors.white,
    //                             ),
    //                             padding: EdgeInsets.symmetric(horizontal: 24.w),
    //                             child: Column(
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: [
    //                                 SizedBox(height: 24.h),

    //                                 // First Name
    //                                 Column(
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.start,
    //                                   children: [
    //                                     GroteskText(
    //                                       text: "First Name",
    //                                       fontSize: 14.sp,
    //                                       fontWeight: FontWeight.w500,
    //                                     ),
    //                                     SizedBox(height: 8.h),
    //                                     TextFieldBox(
    //                                       controller: firstNameController,
    //                                       hintText: "Enter your first name",
    //                                       validator: (String? value) =>
    //                                           validator(value, "First Name"),
    //                                     ),
    //                                   ],
    //                                 ),

    //                                 SizedBox(height: 16.h),

    //                                 // Last Name
    //                                 Column(
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.start,
    //                                   children: [
    //                                     GroteskText(
    //                                       text: "Last Name",
    //                                       fontSize: 14.sp,
    //                                       fontWeight: FontWeight.w500,
    //                                     ),
    //                                     SizedBox(height: 8.h),
    //                                     TextFieldBox(
    //                                       controller: lastNameController,
    //                                       hintText: "Enter your last name",
    //                                       validator: (String? value) =>
    //                                           validator(value, "Last Name"),
    //                                     ),
    //                                   ],
    //                                 ),

    //                                 SizedBox(height: 16.h),

    //                                 // Email Address
    //                                 Column(
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.start,
    //                                   children: [
    //                                     GroteskText(
    //                                       text: "Email address",
    //                                       fontSize: 14.sp,
    //                                       fontWeight: FontWeight.w500,
    //                                     ),
    //                                     SizedBox(height: 8.h),
    //                                     TextFieldBox(
    //                                       controller: emailController,
    //                                       hintText: "Enter your email address",
    //                                       validator: (String? value) =>
    //                                           validator(value, "Email"),
    //                                     ),
    //                                   ],
    //                                 ),

    //                                 SizedBox(height: 16.h),

    //                                 // Phone Number
    //                                 Column(
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.start,
    //                                   children: [
    //                                     GroteskText(
    //                                       text: "Phone Number",
    //                                       fontSize: 14.sp,
    //                                       fontWeight: FontWeight.w500,
    //                                     ),
    //                                     SizedBox(height: 8.h),
    //                                     TextFieldBox(
    //                                       controller: phoneNumberController,
    //                                       hintText: "Enter your phone number",
    //                                       validator: (String? value) =>
    //                                           validator(value, "Phone Number"),
    //                                       keyboardType: TextInputType.number,
    //                                       inputFormatters: [
    //                                         LengthLimitingTextInputFormatter(
    //                                             11),
    //                                         FilteringTextInputFormatter
    //                                             .digitsOnly,
    //                                       ],
    //                                     ),
    //                                   ],
    //                                 ),

    //                                 const Spacer(),

    //                                 // Continue Button
    //                                 ZeehButton(
    //                                   onClick: () => handleCreateAccount(ref),
    //                                   text: "Continue",
    //                                 ),

    //                                 SizedBox(height: 24.h),

    //                                 // Terms and Conditions
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   children: [
    //                                     GroteskText(
    //                                       text:
    //                                           "By clicking “Continue”, you agree to ZeeH’s ",
    //                                       fontWeight: FontWeight.w400,
    //                                       fontSize: 10.sp,
    //                                     ),
    //                                     InkWell(
    //                                       onTap: () => launchUrl(
    //                                         Uri.parse(
    //                                             "https://www.zeeh.africa/legal/terms-of-use"),
    //                                       ),
    //                                       child: GroteskText(
    //                                         text: "T&C",
    //                                         textColor: ZeehColors.buttonPurple,
    //                                         fontWeight: FontWeight.w500,
    //                                         fontSize: 10.sp,
    //                                       ),
    //                                     ),
    //                                     GroteskText(
    //                                       text: " and ",
    //                                       fontWeight: FontWeight.w400,
    //                                       fontSize: 10.sp,
    //                                     ),
    //                                     InkWell(
    //                                       onTap: () => launchUrl(
    //                                         Uri.parse(
    //                                             "https://www.zeeh.africa/legal/privacy-policy"),
    //                                       ),
    //                                       child: GroteskText(
    //                                         text: "Privacy policy",
    //                                         textColor: ZeehColors.buttonPurple,
    //                                         fontWeight: FontWeight.w500,
    //                                         fontSize: 10.sp,
    //                                       ),
    //                                     ),
    //                                   ],
    //                                 ),

    //                                 SizedBox(height: 30.h),
    //                               ],
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                 ),

    //                 // Loading Overlay
    //                 if (authState is RegisterLoadingState)
    //                   const FinnacleLoadingWidget()
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
