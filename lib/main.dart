import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  LocalNoticeService().addNotification("情緒花園", "紀錄心情", DateTime.utc(now.year, now.month, now.day + 1, now.hour).millisecondsSinceEpoch, "紀錄心情");
  LocalNoticeService().addNotification("情緒花園", "紀錄心情", DateTime.utc(now.year, now.month, now.day + 2, now.hour).millisecondsSinceEpoch, "紀錄心情");
  SystemChrome.setPreferredOrientations([
    // 強制豎屏
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  await Firebase.initializeApp();
  await LocalNoticeService().setup();

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
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
            debugShowCheckedModeBanner: false,
            home: SplashPage(photoPath: "resources/image/Meditation-pana-removebg-preview.png"),
          );
        }
        // Main
        else {
          if (AuthService().getuserdata() == null) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: LoginPage(),
            );
          } else {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: HomePage(),
            );
          }
        }
      },
    );
  }
}
