import 'package:flutter/material.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/user.dart';
import 'package:zeeh_mobile/feature/auth/view/login/login_screen.dart';
import 'package:zeeh_mobile/feature/onboarding/view/animated_splash_screen.dart';
import 'package:zeeh_mobile/routes.dart';
import 'package:zeeh_mobile/services/auth_manager/authmanager.dart';

class RootPage extends StatefulWidget {
  static const route = ScreenPaths.rootScreen;
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthManager.instance.streamActiveUser(),
      builder: ((context, snapshot) {
        final user = snapshot.data;
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: user != null
              ?
              //For Sign IN
              const LoginScreen()
              //For LogIn
              : const AnimatedSplashScreen(),
        );
      }),
    );
  }
}
