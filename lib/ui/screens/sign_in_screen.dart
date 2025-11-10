import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_managment_app/ui/screens/forget_password_email.dart';
import 'package:task_managment_app/ui/screens/main_layout_screen.dart';
import 'package:task_managment_app/ui/screens/sign_up_screen.dart';
import 'package:task_managment_app/ui/widgets/screen_backgrond.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static String name = "sign-in-screen";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Get started With",
                  style: TextTheme.of(context).bodyLarge,
                ),
                SizedBox(height: 5),
                TextFormField(
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(hintText: "Email"),
                ),
                TextFormField(
                  obscureText: true,
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(hintText: "Password"),
                ),
                SizedBox(height: 5),
                FilledButton(
                  onPressed: _onTapSignINButton,
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
                              recognizer: TapGestureRecognizer()..onTap = _onTapSignUp,
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
    );
  }

  void _onTapSignINButton(){
    Navigator.pushReplacementNamed(context, MainLayoutScreen.name);
  }


  void _onTapSignUp(){
    Navigator.pushNamed(context, SignUpScreen.name);
  }
  void _onTapForgetPassword(){
    Navigator.pushNamed(context, ForgetPasswordEmail.name);
  }

}
