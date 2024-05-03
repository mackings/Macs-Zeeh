import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/app_snackbar.dart';
import 'package:zeeh_mobile/common/components/button.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/components/textfield_box.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/Wallet/home/Home.dart';
import 'package:zeeh_mobile/feature/Wallet/homemanager.dart';
import 'package:zeeh_mobile/feature/auth/data/state/auth_notifier.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/authenticated_user.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/user.dart';
import 'package:zeeh_mobile/feature/auth/view/forgot_pin/reset_pin_screen.dart';
import 'package:zeeh_mobile/feature/auth/view/sign_up/create_account/create_account.dart';
import 'package:zeeh_mobile/feature/auth/view/sign_up/create_account/create_pin.dart';
import 'package:zeeh_mobile/feature/auth/view/sign_up/create_account/verify_email.dart';
import 'package:zeeh_mobile/feature/auth/view/widgets/header_widget.dart';
import 'package:zeeh_mobile/feature/home/view/home_screen.dart';
import 'package:zeeh_mobile/feature/provider.dart';
import 'package:zeeh_mobile/services/auth_manager/authmanager.dart';
import 'package:zeeh_mobile/services/local_auth.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<FocusNode> focusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  bool biometrics = false;

  String accessToken = "";
  String savedEmail = "";

  // Validator
  String? validator(String? value, String field) {
    if (value!.trim().isEmpty) {
      return "$field cannot be empty";
    } else if (field == "Email" && !value.contains(RegExp(r'@'))) {
      return "$field isn't valid";
    } else if (field == "Pin" &&
        value.length != 4 &&
        value.contains(RegExp(r'[a-zA-Z]'))) {
      return "Pin isn't valid";
    } else {
      return null;
    }
  }

  void handleCheckAccount(WidgetRef ref) {
    ref
        .read(checkAccountStateNotifierProvider.notifier)
        .checkAccount(emailController.text.trim());
  }

  void handleBioLogin(WidgetRef ref) {
    ref.read(authStateNotifierProvider.notifier).bioLogin(accessToken);
  }

  void handleLogin(WidgetRef ref) {
    if (_formKey.currentState!.validate()) {
      ref.read(checkAccountStateNotifierProvider.notifier).checkAccount(
            emailController.text.trim(),
          );
      // ref.read(authStateNotifierProvider.notifier).login(
      //       emailController.text.trim(),
      //       pinController.text.trim().substring(0, 4),
      //     );
    }
  }

  @override
  void initState() {
    super.initState();

    AuthManager.instance.getAuthenticatedUser().then(
          (value) => {
            debugPrint('email: ${value?.user?.email}'),
            if (value?.user?.email != null)
              {
                savedEmail = value?.user?.email ?? "",
              }
          },
        );

    AuthManager.instance.getBiometricToken().then(
          (value) => {
            debugPrint('token: ${value?.token}'),
            if (value?.token != null)
              {
                accessToken = value?.token ?? "",
              },
          },
        );

    Future.delayed(
      const Duration(seconds: 1),
      () async {
        if (savedEmail != "" && accessToken != "") {
          final isAuthenticated = await LocalAuthApi.authenticate();

          if (isAuthenticated) {
            if (!mounted) return;

            handleBioLogin(ref);
          }
        }
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();

    for (var element in focusNodes) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateNotifierProvider);

    final checkAccountState = ref.watch(checkAccountStateNotifierProvider);

    ref.listen(
      authStateNotifierProvider,
      (previous, next) {
        if (next is LogInSuccessState) {
         // navigateReplace(context, const HomeScreen());
         navigateReplace(context, const HomeManager());
        } else if (next is LogInFailureState) {
          AppSnackbar(context, isError: true)
              .showToast(text: next.failure.message);
        }
      },
    );

    ref.listen(
      checkAccountStateNotifierProvider,
      (previous, next) {
        // Check Account Failure and Success
        if (next is CheckAccountFailure) {
          AppSnackbar(context, isError: true).showToast(
            text: next.failure.message,
          );
        }
        if (next is CheckAccountSuccess) {
          AuthManager.instance.saveAuthenticatedUser(
            User(
              token: next.responseModel.data["access_token"],
              user: AuthenticatedUser(
                email: next.responseModel.data["user"]["email"],
              ),
            ),
          );

          // If Account is not Verified
          if (next.responseModel.data["user"]["verified"] == false) {
            ref
                .read(authStateNotifierProvider.notifier)
                .resendVerification(emailController.text);

            AppSnackbar(context, isError: true)
                .showToast(text: "Account is not Verified");

            // Navigate to Verify Email
            navigate(
              context,
              VerifyEmailScreen(
                email: emailController.text,
                isInitialSignUp: false,
              ),
            );
          } else if (next.responseModel.data["user"]["pinExist"] == false) {
            // If User hasn't attached a pin
            AppSnackbar(context, isError: true).showToast(
              text: "Pin not attached to this account. Kindly create a pin",
            );

            navigate(
              context,
              const CreatePinScreen(),
            );
          } else if (next.responseModel.data["user"]["verified"] == true ||
              next.responseModel.data["user"]["pinExist"] == true) {
            ref.read(authStateNotifierProvider.notifier).login(
                  emailController.text.trim(),
                  pinController.text.trim().substring(0, 4),
                );
          }
        }
      },
    );

    ref.listen(
      authStateNotifierProvider,
      (previous, next) {
        if (next is BioLoginFailure) {
          AppSnackbar(context, isError: true)
              .showToast(text: next.failure.message);
        }
        if (next is BioLoginSuccess) {
          AuthManager.instance.saveAuthenticatedUser(
            User(
              accessToken: next.responseModel.data["access_token"],
              user: AuthenticatedUser(
                email: next.responseModel.data["user"]["email"],
              ),
            ),
          );

          navigateReplace(context, const HomeScreen());
        }
      },
    );

    return Scaffold(
      backgroundColor: ZeehColors.onboardingBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 812.h,
              width: 375.w,
              child: Stack(
                children: [
                  // Login
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
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          topRight: Radius.circular(16.r),
                        ),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Login
                            const HeaderWidget(
                              showBackButton: false,
                              screenTitle: "Login",
                              showCancelButton: true,
                            ),

                            SizedBox(height: 40.h),

                            // Zeeh Icon
                            Image.asset(
                              ZeehAssets.roundedZeehLogo,
                              height: 48.h,
                              width: 48.w,
                            ),

                            SizedBox(height: 20.h),

                            // Welcome Back
                            DMSanText(
                              text: "Welcome back!",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),

                            SizedBox(height: 20.h),

                            // Email and PIn

                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                              child: Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DMSanText(
                                        text: "Email Address",
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      SizedBox(height: 10.h),
                                      TextFieldBox(
                                        focusNode: focusNodes[0],
                                        hintText: "Enter your email address",
                                        controller: emailController,
                                        validator: (String? value) =>
                                            validator(value, "Email"),
                                        onEditingComplete: () {
                                          focusNodes[1].requestFocus();

                                          //  handleCheckAccount(ref);
                                        },
                                      ),

                                      SizedBox(height: 15.h),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          DMSanText(
                                            text: "Pin",
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          SizedBox(height: 10.h),
                                          TextFieldBox(
                                            focusNode: focusNodes[1],
                                            hintText: "Enter your pin",
                                            controller: pinController,
                                            keyboardType: TextInputType.number,
                                            obscureText: true,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                   4),
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                            validator: (String? value) =>
                                                validator(value, "Pin"),
                                            onEditingComplete: () {
                                              focusNodes[1].unfocus();
                                            },
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 20.h),

                                      // Forgot your pin
                                      Row(
                                        children: [
                                          DMSanText(
                                            text: "Forgot your pin? ",
                                            fontSize: 14.sp,
                                          ),
                                          InkWell(
                                            onTap: () => navigate(context,
                                                const ResetPinScreen()),
                                            child: DMSanText(
                                              text: "Reset Pin",
                                              textColor:
                                                  ZeehColors.buttonPurple,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 40.h),

                                      // Login Button
                                      if (authState is LogInLoadingState ||
                                          checkAccountState
                                              is CheckAccountLoading)
                                        const AppLoadingButton()
                                      else
                                        ZeehButton(
                                          onClick: () => handleLogin(ref),
                                          text: "Login",
                                        ),

                                      SizedBox(height: 80.h),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          DMSanText(
                                            text: "Are you a new user?",
                                            fontSize: 14.sp,
                                          ),
                                          SizedBox(width: 5.w),
                                          InkWell(
                                            onTap: () => navigate(context,
                                                const CreateAccountScreen()),
                                            child: DMSanText(
                                              text: "Sign up",
                                              textColor:
                                                  ZeehColors.buttonPurple,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
    //               height: 750.h,
    //               width: 375.w,
    //               decoration: BoxDecoration(
    //                 color: const Color(0xffF8F9FD),
    //                 borderRadius: BorderRadius.only(
    //                   topLeft: Radius.circular(16.r),
    //                   topRight: Radius.circular(16.r),
    //                 ),
    //               ),
    //               child: Form(
    //                 key: _formKey,
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     // Login
    //                     const HeaderWidget(
    //                       screenTitle: "Login",
    //                       showCancelButton: false,
    //                     ),

    //                     // Credentials
    //                     SizedBox(height: 15.h),

    //                     // Full Name, Email Address, Phone Number
    //                     Container(
    //                       width: 375.w,
    //                       decoration: const BoxDecoration(
    //                         color: Colors.white,
    //                       ),
    //                       child: Padding(
    //                         padding: EdgeInsets.symmetric(horizontal: 24.0.w),
    //                         child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             SizedBox(height: 24.h),

    //                             // Welcome Back!
    //                             GroteskText(
    //                               text: "Welcome Back!",
    //                               fontSize: 18.sp,
    //                               fontWeight: FontWeight.w500,
    //                             ),
    //                             SizedBox(height: 10.h),

    //                             // Enter your email to sign in
    //                             GroteskText(
    //                               text: "Enter your email to sign in",
    //                               fontSize: 12.sp,
    //                               fontWeight: FontWeight.w400,
    //                             ),

    //                             // Email Address
    //                             SizedBox(height: 20.h),

    //                             GroteskText(
    //                               text: "Email address",
    //                               fontSize: 14.sp,
    //                               fontWeight: FontWeight.w500,
    //                             ),

    //                             // Textfield
    //                             SizedBox(height: 10.h),

    //                             // Textfield
    //                             TextFieldBox(
    //                               focusNode: focusNode,
    //                               hintText: "Enter your email address",
    //                               controller: emailController,
    //                               validator: (String? value) =>
    //                                   validator(value, "Email"),
    //                               onEditingComplete: () {
    //                                 focusNode.unfocus();

    //                                 handleCheckAccount(ref);
    //                               },
    //                             ),

    //                             SizedBox(height: 350.h),

    //                             if (checkAccountState is CheckAccountLoading)
    //                               const AppLoadingButton()
    //                             else
    //                               ZeehButton(
    //                                 onClick: () => {
    //                                   if (_formKey.currentState!.validate())
    //                                     handleCheckAccount(ref)
    //                                 },
    //                                 text: "Continue",
    //                               ),

    //                             SizedBox(height: 20.h),

    //                             Row(
    //                               mainAxisAlignment: MainAxisAlignment.center,
    //                               children: [
    //                                 GroteskText(
    //                                   text: "New to UseZeeh? ",
    //                                   fontSize: 12.sp,
    //                                 ),
    //                                 InkWell(
    //                                   onTap: () => navigate(
    //                                       context, const CreateAccountScreen()),
    //                                   child: GroteskText(
    //                                     text: "Sign up",
    //                                     textColor: ZeehColors.buttonPurple,
    //                                     fontWeight: FontWeight.w500,
    //                                     fontSize: 12.sp,
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),

    //           if (checkAccountState is CheckAccountLoading)
    //             const FinnacleLoadingWidget(
    //               loadingText: "Fetching Account Details...",
    //             )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
