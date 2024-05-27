import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/Screens/home_screen.dart';
import 'package:movie_app/components/Textfiled.dart';
import 'package:movie_app/components/Button.dart';
import 'package:movie_app/components/Square.dart';
import 'package:movie_app/Signup.dart';
import 'package:movie_app/Authentication/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/page1.dart'; // Assuming this is your home screen
import 'package:movie_app/splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Add this import

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBYVyyQ8FV0FRMqmPwkL_cnpDmdDjTDFR4",
            appId: "1:863713963090:web:c08129c31c088a76d8838b",
            messagingSenderId: "863713963090",
            projectId: "lab-exam-c38a0"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    print("inside the myApp");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(
        child: LoginScreen(),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Authentication _auth = Authentication();
  final email = TextEditingController();
  final password = TextEditingController();

  void showToastMessage({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey[800],
      textColor: Colors.white,
    );
  }

  void Signin() async {
    String semail = email.text;
    String spassword = password.text;

    try {
      User? user = await _auth.signInEmailPassword(semail, spassword);
      if (user != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen())); // Redirect to your home screen
      } else {
        showToastMessage(
            message: "Login failed. Please check your credentials.");
      }
    } catch (e) {
      showToastMessage(message: e.toString());
    }
  }

  void signInWithGoogle() async {
    // Add your Google sign-in logic here
  }

  void signInWithApple() {
    // Add your Apple sign-in logic here
  }

  Signupscreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignupScreen()));
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    "Netflix Recommendation",
                    style: GoogleFonts.archivoNarrow(
                      color: Color(0xFFCC1609),
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  Container(
                    child: Text(
                      'Welcome back, you\'ve been missed!',
                      style: TextStyle(color: Colors.grey[500], fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextFieldlogin(
                    controller: email,
                    obscureText: false,
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 10),
                  TextFieldlogin(
                    controller: password,
                    obscureText: true,
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 10),
                  Buttonfield(
                    onTap: Signin,
                    text: 'Sign In',
                    color: Color(0xFFCC1609),
                    textColor: Colors.white,
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'Or sign in with',
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Squarefield(
                        imagepath: 'images/google.png',
                        onTap: signInWithGoogle,
                      ),
                      const SizedBox(width: 25),
                      Squarefield(
                        imagepath: 'images/fb.png',
                        onTap: signInWithApple,
                      ),
                      const SizedBox(width: 25),
                      Squarefield(
                        imagepath: 'images/x.png',
                        onTap: signInWithApple,
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => Signupscreen(context),
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
