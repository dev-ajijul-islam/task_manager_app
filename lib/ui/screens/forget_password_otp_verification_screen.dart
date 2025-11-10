import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_managment_app/ui/screens/sign_in_screen.dart';
import 'package:task_managment_app/ui/widgets/screen_backgrond.dart';

class ForgetPasswordOtpVerificationScreen extends StatefulWidget {
  const ForgetPasswordOtpVerificationScreen({super.key});

  static String name = "Forget-password-otp-verification-screen";

  @override
  State<ForgetPasswordOtpVerificationScreen> createState() =>
      _ForgetPasswordOtpVerificationScreen();
}

class _ForgetPasswordOtpVerificationScreen
    extends State<ForgetPasswordOtpVerificationScreen> {
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
                  "A 6 digit pin code will sent to Your Email Address",
                  style: TextTheme.of(
                    context,
                  ).bodyMedium?.copyWith(color: Colors.grey),
                ),
                PinCodeTextField(
                  keyboardType: TextInputType.number,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    activeColor: Colors.white,
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Colors.white
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.blue.shade50,
                  enableActiveFill: true,
                  appContext: context,
                ),
                SizedBox(height: 5),
                FilledButton(
                  onPressed: _onTapSubmitVerifyButton,
                  child: Text("Verify"),
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

  void _onTapSubmitVerifyButton() {}

  void _onTapSignIn() {
    Navigator.pushReplacementNamed(context, SignInScreen.name);
  }
}
