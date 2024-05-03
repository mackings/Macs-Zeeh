import 'package:flutter/material.dart';
import 'package:zeeh_mobile/feature/onboarding/view/animated_splash_screen.dart';
import 'package:zeeh_mobile/rootpage.dart';

const String homeRoute = '/home';

///? should we use screen paths or just create the strings where
///? it's needed.
class ScreenPaths {
  static const String rootScreen = '/rootpage';
  static const String signInScreen = '/sign_in_screen';
  static const String homeScreen = '/home';
  static const String onboardingScreen = '/onboarding_screen';
  static const String animatedSplashScreen = '/animated_splash_screen';
}

Map<String, WidgetBuilder> routes() {
  return <String, WidgetBuilder>{
    //if user is logged in return dashboard with user, else return loginpage

    '/': (context) =>
        // const FeedPage(),
        const RootPage(),

    AnimatedSplashScreen.route: (context) => const AnimatedSplashScreen(),

    // HomePage.route: (context) => const HomePage(),
  };
}

Route<dynamic>? generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case RootPage.route:
    default:
  }
  return null;
}
