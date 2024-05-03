import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/authenticated_user.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/token.dart';
import 'package:zeeh_mobile/feature/auth/model/auth/user.dart';
import 'package:zeeh_mobile/firebase_options.dart';
import 'package:zeeh_mobile/routes.dart';
import 'package:zeeh_mobile/configs/theme.dart';
import 'package:face_camera/face_camera.dart';
import 'package:zeeh_mobile/services/push_notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FaceCamera.initialize();

  //Set orientation as potrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Hive.initFlutter();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Hive
    ..registerAdapter(AuthenticatedUserAdapter())
    ..registerAdapter(UserAdapter())
    ..registerAdapter(TokenAdapter());

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );

  // initializing push notification and awesome notification
  final firebaseCloudMessaging = FCM();
  firebaseCloudMessaging.setNotification();

  // Handling Background message
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
}

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, snapshot) {
        return MaterialApp(
          title: 'Zeeh',
          debugShowCheckedModeBanner: false,
          navigatorObservers: [
            routeObserver,
          ],
          theme: theme(),
          initialRoute: '/',
          routes: routes(),
          onGenerateRoute: generateRoutes,
          scrollBehavior: const CupertinoScrollBehavior(),
        );
      },
    );
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (message.data.containsKey('data')) {
    //Handle data message
    // final data = message.data['data'];
  }

  if (message.data.containsKey('notification')) {
    // Handle notification message
    // final notification = message.data['notification'];
  }

  //Show local notifications with local notifications package
  //Disabled so firebase handles the background notiications.
  //you can create a notification using the awesome notification plugin.
}
