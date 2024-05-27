import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/components/toast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpEmailPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      showToastMessage(message: "Successfully Signed Up!");
      return credential.user;
    } on FirebaseException catch (e) {
      print(e.code);
      if (e.code == 'email-already-in-use') {
        showToastMessage(message: "Email Already In Use");
      } else {
        showToastMessage(message: "An Error Occurred : ${e.code}");
      }
    }
    return null;
  }

  Future<User?> signInEmailPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      showToastMessage(message: "Successfully Logged In!");
      return credential.user;
    } on FirebaseException catch (e) {
      print(e.code);
      if (e.code == 'invalid-credential') {
        showToastMessage(message: "Invalid Email Or Password");
      } else {
        showToastMessage(message: "An Error Occurred : ${e.code}");
      }
    }
    return null;
  }

Future<User?> signInGoogle() async {
  try {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      showToastMessage(message: "Successfully Logged In!");
      
      return userCredential.user;
    } else {
      showToastMessage(message: "Google Sign In Cancelled");
    }
  } on FirebaseAuthException catch (e) {
    print(e.code);
    if (e.code == 'invalid-credential') {
      showToastMessage(message: "Invalid Email Or Password");
    } else {
      showToastMessage(message: "An Error Occurred : ${e.code}");
    }
  } catch (e) {
    print("Error: $e");
    showToastMessage(message: "An Error Occurred");
  }
  return null;
}
}

