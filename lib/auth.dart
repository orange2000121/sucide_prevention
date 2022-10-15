import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum authstatus {
  successful,
  wrongpassword,
  emailalreadyexists,
  invalidemail,
  weakpassword,
  goaskdeveloper, //for unknown error
}

class AuthService {
  Future<bool> signupwithemail(emailAddress, password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailAddress.text, password: password.text);
    return true;
  }

  Future<bool> signinwithemail(emailaddress, password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailaddress.text, password: password.text);

    return true;
  }

  //reset account
  Future<bool> resetpassword(emailaddress) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailaddress.text);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
    }

    return true;
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
}
