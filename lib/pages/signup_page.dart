import 'package:flutter/material.dart';
import 'package:mad_combined_tasks/pages/login_page.dart';
import 'package:mad_combined_tasks/utils/utils.dart';
import 'package:mad_combined_tasks/widgets/custom_app_bar.dart';
import 'package:mad_combined_tasks/widgets/custom_button.dart';
import 'package:mad_combined_tasks/widgets/custom_text_field.dart';

import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  signUp() {
    _auth
        .createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text)
        .then((value) {
      _emailController.clear();
      _passwordController.clear();
      Utils().showSnackBar(
          context, Colors.black, "${value.user!.email} is registered now!");
    }).catchError((e) {
      Utils().showSnackBar(context, Colors.red, e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'SignUp', actions: []),
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
                  text: "SignUp",
                  width: 200,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      signUp();
                    }
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                    child: const Text("Login"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
