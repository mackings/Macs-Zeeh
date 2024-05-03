import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeeh_mobile/common/components/app_snackbar.dart';
import 'package:zeeh_mobile/common/components/loading_indicator.dart';
import 'package:zeeh_mobile/common/components/numeric_keypad.dart/num_pad.dart';
import 'package:zeeh_mobile/common/components/pin_otp_field.dart';
import 'package:zeeh_mobile/common/components/text_widget.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/Wallet/homemanager.dart';
import 'package:zeeh_mobile/feature/auth/data/state/auth_notifier.dart';
import 'package:zeeh_mobile/feature/auth/view/forgot_pin/reset_pin_screen.dart';
import 'package:zeeh_mobile/feature/auth/view/login/login_screen.dart';
import 'package:zeeh_mobile/feature/auth/view/sign_up/create_account/create_pin.dart';
import 'package:zeeh_mobile/feature/auth/view/sign_up/create_account/verify_email.dart';
import 'package:zeeh_mobile/feature/home/view/home_screen.dart';
import 'package:zeeh_mobile/feature/provider.dart';
import 'package:zeeh_mobile/services/auth_manager/authmanager.dart';
import 'package:zeeh_mobile/services/local_auth.dart';

class EnterPinScreen extends ConsumerStatefulWidget {
  const EnterPinScreen({super.key, required this.email});

  final String email;

  @override
  ConsumerState<EnterPinScreen> createState() => _EnterPinScreenState();
}

class _EnterPinScreenState extends ConsumerState<EnterPinScreen> {


  bool isPinEntered = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController pinController = TextEditingController();

  String accessToken = "";

  String email = "";

  String firstName = "";

  String savedEmail = "";

  String biometricsToken = "";

  bool biometrics = false;

  void handleLogin(WidgetRef ref) {
    final checkAccountState = ref.watch(checkAccountStateNotifierProvider);

    if (checkAccountState is CheckAccountSuccess) {
      email = checkAccountState.responseModel.data["user"]["email"];
    }

    if (email != "") {
      ref.read(authStateNotifierProvider.notifier).login(
            email,
            pinController.text.trim().substring(0, 4),
          );
    } else if (savedEmail != "") {
      ref
          .read(authStateNotifierProvider.notifier)
          .login(savedEmail, pinController.text.trim().substring(0, 4));
    }
  }

  void handleBioLogin(WidgetRef ref) {
    ref.read(authStateNotifierProvider.notifier).bioLogin(biometricsToken);
  }

  @override
  void initState() {
    super.initState();

    pinController.addListener(
      () {
        setState(() {
          if (pinController.text.length == 4) {
            isPinEntered = true;
            handleLogin(ref);
          } else {
            isPinEntered = false;
          }
        });
      },
    );

    AuthManager.instance.getAuthenticatedUser().then(
          (value) => {
            debugPrint('email: ${value?.user?.email}'),
            if (value?.user?.email != null)
              {
                savedEmail = value?.user?.email ?? "",
                ref
                    .read(checkAccountStateNotifierProvider.notifier)
                    .checkAccount(savedEmail),
              }
          },
        );

    AuthManager.instance.getBiometricToken().then(
          (value) => {
            debugPrint('token: ${value?.token}'),
            if (value?.token != null)
              {
                biometricsToken = value?.token ?? "",
              },
          },
        );
  }

  @override
  Widget build(BuildContext context) {

    final checkAccountState = ref.watch(checkAccountStateNotifierProvider);

    if (checkAccountState is CheckAccountSuccess) {
      email = checkAccountState.responseModel.data["user"]["email"];
      firstName = checkAccountState.responseModel.data["user"]["first_name"];
      accessToken = checkAccountState.responseModel.data["access_token"];
      biometrics = checkAccountState.responseModel.data["user"]["biometrics"];
    }

    final authState = ref.watch(authStateNotifierProvider);

    ref.listen(
      authStateNotifierProvider,
      (previous, next) {
        if (next is LogInFailureState) {
          AppSnackbar(context, isError: true)
              .showToast(text: next.failure.message);
        } else if (next is LogInSuccessState) {
          
          navigateReplace(context, const HomeManager());
         // navigateReplace(context, const HomeScreen());

        }
      },
    );

    ref.listen(
      authStateNotifierProvider,
      (previous, next) {
        if (next is BioLoginFailure) {
          AppSnackbar(context).showToast(text: next.failure.message);
        }
        if (next is BioLoginSuccess) {
          navigateReplace(context, const HomeScreen());
        }
      },
    );


    ref.listen(
      checkAccountStateNotifierProvider,
      (previous, next) {
        if (next is CheckAccountSuccess) {
          if (next.responseModel.data["verified"] == false) {
            navigate(context,
                VerifyEmailScreen(isInitialSignUp: false, email: email));
          } else if (next.responseModel.data["pinExist"] == false) {
            navigate(context, const CreatePinScreen());
          }
        }
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: SizedBox(
                    height: 812.h,
                    width: 375.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 95.h),

                        Center(
                          child: Image.asset(
                            ZeehAssets.roundedZeehLogo,
                            height: 56.h,
                            width: 56.w,
                          ),
                        ),

                        SizedBox(height: 20.h),

                        // Title
                        Column(
                          children: [
                            DMSanText(
                              text: "Welcome back, $firstName!",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              textColor: const Color(0xFF242739),
                            ),
                            DMSanText(
                              text: "Enter your pin",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              textColor: const Color(0xFF242739),
                            ),
                          ],
                        ),

                        // Credentials
                        SizedBox(height: 30.h),

                        // Full Name, Email Address, Phone Number
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Email Address

                            // Pin Code
                            PinOTPFieldWidget(
                              controller: pinController,
                              length: 4,
                              obscureText: true,
                            ),
                          ],
                        ),

                        SizedBox(height: 16.h),

                        // Button Input
                        Container(
                          width: 375.w,
                          height: 345.h,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: NumPad(
                            buttonSize: 50.w,
                            buttonColor: Colors.white,
                            iconColor: Colors.black,
                            controller: pinController,
                            delete: () {
                              pinController.text = pinController.text
                                  .substring(0, pinController.text.length - 1);
                            },
                            onButtonTap: () async {
                              if (biometricsToken != "") {
                                final isAuthenticated =
                                    await LocalAuthApi.authenticate();

                                if (isAuthenticated) {
                                  if (!mounted) return;

                                  handleBioLogin(ref);
                                }
                              } else if (biometricsToken == "") {
                                AppSnackbar(context, isError: true).showToast(
                                  text:
                                      "Please enable biometrics in Profile Settings",
                                );
                              }
                            },
                            // do something with the input numbers
                            onSubmit: () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  content: Text(
                                    "You code is ${pinController.text}",
                                    style: const TextStyle(fontSize: 30),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        SizedBox(height: 20.h),

                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DMSanText(
                                  text: "Can’t remember your pin? ",
                                  fontSize: 14.sp,
                                ),
                                InkWell(
                                  onTap: () =>
                                      navigate(context, const ResetPinScreen()),
                                  child: DMSanText(
                                    text: "Reset Pin",
                                    textColor: ZeehColors.buttonPurple,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DMSanText(
                                  text: "Not $firstName? ",
                                  fontSize: 14.sp,
                                ),
                                InkWell(
                                  onTap: () =>
                                      navigate(context, const LoginScreen()),
                                  child: DMSanText(
                                    text: "Switch account",
                                    textColor: ZeehColors.buttonPurple,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // FingerPrint
            ],
          ),

          // Loading Overlay
          if (authState is BioLoginLoading || authState is LogInLoadingState)
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

  void handleBiometricLogin(BuildContext context) {
    () async {
      final isAuthenticated = await LocalAuthApi.authenticate();

      if (isAuthenticated) {
        if (!mounted) return;

        handleBioLogin(ref);
      }
    };
  }
}
