import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/Authentication/auth.dart';
import 'package:movie_app/components/Textfiled.dart';
import 'package:movie_app/components/Button.dart';
import 'package:movie_app/components/Square.dart';
import 'package:movie_app/components/toast.dart';
import 'package:movie_app/main.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final Authentication _auth = Authentication();

  final signupemail = TextEditingController();
  final signuppassword = TextEditingController();
  final signuppassword2 = TextEditingController();

  void Signup() async {
    String semail = signupemail.text;
    String spassword = signuppassword.text;
    String spassword2 = signuppassword2.text;

    if (spassword != spassword2) {
      showToastMessage(message: "Passwords Do Not Match!");
    }
    User? user = await _auth.signUpEmailPassword(semail, spassword);
    if (user != null) {
      loginscreen(context);
    }
  }

  loginscreen(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void dispose() {
    signupemail.dispose();
    signuppassword.dispose();
    signuppassword2.dispose();
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
                  const SizedBox(height: 25),
                  Text(
                    'Let\'s create an account for you!',
                    style: TextStyle(color: Colors.grey[500], fontSize: 16),
                  ),
                  const SizedBox(height: 25),
                  TextFieldlogin(
                    controller: signupemail,
                    obscureText: false,
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 10),
                  TextFieldlogin(
                    controller: signuppassword,
                    obscureText: true,
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 10),
                  TextFieldlogin(
                    controller: signuppassword2,
                    obscureText: true,
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 10),
                  Buttonfield(
                    onTap: Signup,
                    text: 'Sign Up',
                    color: Colors.blue,
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
                            'Or Continue With',
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
                    children: [
                      Squarefield(
                        imagepath: 'images/google.png',
                        onTap: () {},
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Squarefield(imagepath: 'images/apple.png', onTap: () {}),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => loginscreen(context),
                        child: const Text(
                          'Sign In now',
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
