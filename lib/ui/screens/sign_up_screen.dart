import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_managment_app/ui/screens/forget_password_email.dart';
import 'package:task_managment_app/ui/screens/main_layout_screen.dart';
import 'package:task_managment_app/ui/screens/sign_in_screen.dart';
import 'package:task_managment_app/ui/widgets/screen_backgrond.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static String name = "sign-up-screen";

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: SingleChildScrollView(
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Join with Us", style: TextTheme.of(context).bodyLarge),
                  SizedBox(height: 5),
                  TextFormField(
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(hintText: "Email"),
                  ),
                  TextFormField(
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(hintText: "First name"),
                  ),
                  TextFormField(
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(hintText: "Last name"),
                  ),
                  TextFormField(
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(hintText: "Mobile"),
                  ),
                  TextFormField(
                    obscureText: true,
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(hintText: "Password"),
                  ),
                  SizedBox(height: 5),
                  FilledButton(
                    onPressed: _onTapSignUpButton,
                    child: Icon(Icons.arrow_circle_right_outlined, size: 25),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Column(
                      spacing: 5,
                      children: [
                        GestureDetector(
                          onTap: _onTapForgetPassword,
                          child: Text(
                            "Forgot password ?",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black87),
                            text: "Don't have an account? ",
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _onTapSignIn,
                                text: "Sign up",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignUpButton() {
    Navigator.pushReplacementNamed(context, SignInScreen.name);
  }


  void _onTapSignIn(){
    Navigator.pushReplacementNamed(context, SignInScreen.name);
  }


  void _onTapForgetPassword() {
    Navigator.pushNamed(context, ForgetPasswordEmail.name);
  }
}
