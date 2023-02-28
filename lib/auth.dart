// ignore_for_file: no_duplicate_case_values

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AuthStatus {
  successful,
  wrongpassword,
  emailalreadyexists,
  invalidemail,
  weakpassword,
  goaskdeveloper, //for unknown error
}

class AuthService {
  Future<bool> signupwithemail(emailAddress, password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailAddress.text, password: password.text);
      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          Fluttertoast.showToast(msg: '此信箱已被註冊');
          return false;
        case 'invalid-email':
          Fluttertoast.showToast(msg: '信箱格式錯誤');
          return false;
        case 'weak-password':
          Fluttertoast.showToast(msg: '密碼太簡單');
          return false;
        default:
          Fluttertoast.showToast(msg: '未知錯誤');
          return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '未知錯誤');
      return false;
    }
  }

  Future<bool> signinwithemail(emailaddress, password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailaddress.text, password: password.text);
      return true;
    } on FirebaseAuthException catch (e) {
      String errorMessage = e.message!;
      switch (e.code) {
        case "invalid-email":
          errorMessage = "帳號錯誤";
          break;
        case "wrong-password":
          errorMessage = "密碼錯誤";
          break;
        case "user-not-found":
          errorMessage = "使用者不存在";
          break;
        case "user-disabled":
          errorMessage = "使用者被停用";
          break;
        default:
          errorMessage = "未知錯誤";
      }
      Fluttertoast.showToast(msg: errorMessage);
      return false;
    }
  }

  //reset account
  Future<bool> resetpassword(String emailaddress) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailaddress);
      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          Fluttertoast.showToast(msg: "信箱格式錯誤");
          return false;
        case "user-not-found":
          Fluttertoast.showToast(msg: "使用者不存在");
          return false;
        default:
          Fluttertoast.showToast(msg: "再試一次");
          return false;
      }
    }
  }

  //sign in with google

  Future<bool> signinWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return false;
    }
    //obtain the auth deatails from the request
    final GoogleSignInAuthentication googleauth = await googleUser.authentication;

    //create a new credential
    final credential = GoogleAuthProvider.credential(accessToken: googleauth.accessToken, idToken: googleauth.idToken);

    await FirebaseAuth.instance.signInWithCredential(credential);

    return true;
  }

  //get user data
  getuserdata() {
    if (FirebaseAuth.instance.currentUser != null) {
      // print(FirebaseAuth.instance.currentUser);
      return FirebaseAuth.instance.currentUser?.email;
    }
  }

  //signout
  signoutwithGoogle() {
    FirebaseAuth.instance.signOut();
  }

  //delete account
  Future<bool> deleteaccount() async {
    try {
      await FirebaseAuth.instance.currentUser?.delete();
      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "requires-recent-login":
          Fluttertoast.showToast(msg: "請重新登入");
          return false;
        default:
          Fluttertoast.showToast(msg: "再試一次");
          return false;
      }
    }
  }
}
