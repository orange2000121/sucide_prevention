import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sucide_prevention/auth.dart';
import 'package:sucide_prevention/auth/home/login_page.dart';
import 'package:sucide_prevention/home/home_page.dart';
import 'package:sucide_prevention/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sucide_prevention/tool/local_notification_service.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNoticeService().setup();
  DateTime now = DateTime.now();
  LocalNoticeService().addNotification("test", "test", DateTime.utc(now.year, now.month, now.day, 18).millisecondsSinceEpoch, "test");
  SystemChrome.setPreferredOrientations([
    // 強制豎屏
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  await Firebase.initializeApp();
  await LocalNoticeService().setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 3)),
      builder: (context, AsyncSnapshot snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: SplashPage(photoPath: "resources/image/splash_logo.png"),
          );
        }
        // Main
        else {
          if (AuthService().getuserdata() == null) {
            return const MaterialApp(
              home: LoginPage(),
            );
          } else {
            return const MaterialApp(
              home: HomePage(),
            );
          }
        }
      },
    );
  }
}
