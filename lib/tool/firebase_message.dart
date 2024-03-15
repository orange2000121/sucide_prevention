import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessage {
  void init() {
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.getToken().then((token) {
      print("token: $token");
    });
    _firebaseMessaging.requestPermission();
  }
}
