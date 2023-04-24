// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mad_combined_tasks/pages/home_page.dart';
import 'package:mad_combined_tasks/pages/signup_page.dart';
import 'package:mad_combined_tasks/utils/utils.dart';
import 'package:mad_combined_tasks/widgets/custom_app_bar.dart';
import 'package:mad_combined_tasks/widgets/custom_button.dart';
import 'package:mad_combined_tasks/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mad_combined_tasks/widgets/social_icon_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  GoogleSignInAccount? _currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String?> signInWithGoogle() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null;
      _currentUser = googleUser;

      final googleSignInAuthentication = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      Utils().showSnackBar(
          context, Colors.black, "${user!.email} is logged in now!");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
      return null;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  signInWithFacebook() async {
    //write code here
  }

  login() {
    _auth
        .signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text)
        .then((value) {
      _emailController.clear();
      _passwordController.clear();
      Utils().showSnackBar(
          context, Colors.black, "${value.user!.email} is logged in now!");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }).catchError((e) {
      Utils().showSnackBar(context, Colors.red, e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Login', actions: []),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                  hintText: "Email",
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  }),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: "Password",
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomButton(
                  text: "LogIn",
                  width: 200,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      login();
                    }
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()));
                    },
                    child: const Text("SignUp"),
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SocialIconButton(
                      onPressed: signInWithGoogle,
                      size: 73,
                      iconUrl:
                          'http://pngimg.com/uploads/google/google_PNG19635.png'),
                  SocialIconButton(
                      onPressed: signInWithFacebook,
                      size: 50,
                      iconUrl:
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Facebook_Logo_%282019%29.png/1024px-Facebook_Logo_%282019%29.png')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
