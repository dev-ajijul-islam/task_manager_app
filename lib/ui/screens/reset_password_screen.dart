import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_managment_app/ui/screens/main_layout_screen.dart';
import 'package:task_managment_app/ui/screens/sign_in_screen.dart';
import 'package:task_managment_app/ui/widgets/screen_backgrond.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  static String name = "reset-password-screen";

  @override
  State<ResetPasswordScreen> createState() =>
      _ResetPasswordScreen();
}

class _ResetPasswordScreen
    extends State<ResetPasswordScreen> {
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
                  "PIN Verification",
                  style: TextTheme.of(context).bodyLarge,
                ),
                Text(
                  "Minimum length password 8 character with Latter and number combination ",
                  style: TextTheme.of(
                    context,
                  ).bodyMedium?.copyWith(color: Colors.grey),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Password"
                  ),
                ),  TextFormField(
                  decoration: InputDecoration(
                    hintText: "Confirm Password"
                  ),
                ),
                SizedBox(height: 5),
                FilledButton(
                  onPressed: _onTapConfirmButton,
                  child: Text("Confirm"),
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

  void _onTapConfirmButton() {
    Navigator.pushReplacementNamed(context, MainLayoutScreen.name);
  }

  void _onTapSignIn() {
    Navigator.pushReplacementNamed(context, SignInScreen.name);
  }
}
