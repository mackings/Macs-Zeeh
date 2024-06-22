import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zeeh_mobile/common/utils/navigator.dart';
import 'package:zeeh_mobile/constants/asset_paths.dart';
import 'package:zeeh_mobile/constants/colors.dart';
import 'package:zeeh_mobile/feature/auth/view/enter_pin/enter_pin_screen.dart';
import 'package:zeeh_mobile/feature/onboarding/view/onboarding_screen1.dart';
import 'package:zeeh_mobile/routes.dart';
import 'package:zeeh_mobile/services/auth_manager/authmanager.dart';

class AnimatedSplashScreen extends ConsumerStatefulWidget {
  const AnimatedSplashScreen({super.key});

  static const route = ScreenPaths.animatedSplashScreen;

  @override
  ConsumerState<AnimatedSplashScreen> createState() =>
      _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends ConsumerState<AnimatedSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  late final AnimationController textAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 8),
  )..forward();

  bool isScaled = false;

  String accessToken = "";
  String savedEmail = "";

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
      const Duration(seconds: 6),
      () {
        if (savedEmail != "" || accessToken != "") {
          if (mounted) {
            navigateReplace(
              context,
              EnterPinScreen(email: savedEmail),
            );
          }
        } else {
          if (mounted) {
            navigateReplace(
              context,
              const OnboardingScreen(),
            );
          }
        }
      },
    );

    controller = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );

    animation = Tween<double>(begin: 0.5, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    setState(() {
      isScaled = !isScaled;
    });

    controller.forward();
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    textAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZeehColors.onboardingBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ZeehAssets.roundedZeehLogo,
              height: 100.0,
              width: 100.0,
            ),
            // FadeTransition(
            //   opacity: Tween<double>(
            //     begin: 3.0,
            //     end: 0.0,
            //   ).animate(
            //     CurvedAnimation(
            //       parent: textAnimationController,
            //       curve: const Interval(
            //         0.3,
            //         0.7,
            //         curve: Curves.easeIn,
            //       ),
            //     ),
            //   ),
            //   child: SpaceGroteskText(
            //     text: "UseZeeh",
            //     fontSize: 40.sp,
            //     textColor: Colors.white,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
