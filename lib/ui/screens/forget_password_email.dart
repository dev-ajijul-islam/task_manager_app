import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_managment_app/ui/screens/sign_in_screen.dart';
import 'package:task_managment_app/ui/widgets/screen_backgrond.dart';

class ForgetPasswordEmail extends StatefulWidget {
  const ForgetPasswordEmail({super.key});

  static String name = "forget-password-email";

  @override
  State<ForgetPasswordEmail> createState() => _ForgetPasswordEmailState();
}

class _ForgetPasswordEmailState extends State<ForgetPasswordEmail> {
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
                  "Your Email Address",
                  style: TextTheme.of(context).bodyLarge,
                ),
                Text(
                  "A 6 digit pin code will sent to Your Email Address",
                  style: TextTheme.of(context).bodyMedium?.copyWith(
                    color: Colors.grey
                  ),
                ),
                TextFormField(
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(hintText: "Email"),
                ),
                SizedBox(height: 5),
                FilledButton(
                  onPressed: _onTapSubmitEmailButton,
                  child: Icon(Icons.arrow_circle_right_outlined, size: 25),
                ),
                SizedBox(height: 10),
                Center(
                  child: Column(
                    spacing: 5,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black87),
                          text: "have an account? ",
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = _onTapSignIn,
                              text: "Sign in",
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

  void _onTapSubmitEmailButton() {}

  void _onTapSignIn() {
    Navigator.pushReplacementNamed(context, SignInScreen.name);
  }
}
