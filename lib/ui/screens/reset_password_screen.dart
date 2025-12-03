import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_managment_app/data/services/network_caller.dart';
import 'package:task_managment_app/ui/screens/main_layout_screen.dart';
import 'package:task_managment_app/ui/screens/sign_in_screen.dart';
import 'package:task_managment_app/ui/widgets/screen_backgrond.dart';
import 'package:task_managment_app/ui/widgets/snackbar_message.dart';
import 'package:task_managment_app/utils/url.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  static String name = "reset-password-screen";

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreen();
}

class _ResetPasswordScreen extends State<ResetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _passwordRepeatController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Set Password", style: TextTheme.of(context).bodyLarge),
                    Text(
                      "Minimum length password 8 character with Latter and number combination ",
                      style: TextTheme.of(
                        context,
                      ).bodyMedium?.copyWith(color: Colors.grey),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Password";
                        }
                        if (value.length < 6) {
                          return "Enter 6 character password at least";
                        }
              
                        return null;
                      },
                      decoration: InputDecoration(hintText: "Password"),
                    ),
                    TextFormField(
                      controller: _passwordRepeatController,
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return "Password Not Matched";
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintText: "Confirm Password"),
                    ),
                    SizedBox(height: 5),
                    FilledButton(
                      onPressed: () {
                        _onTapConfirmButton(args);
                      },
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
        ),
      ),
    );
  }

  Future<void> _onTapConfirmButton(args) async {
    if (_formKey.currentState!.validate()) {
      NetworkResponse response = await NetworkCaller.postRequest(
        Url.resetPasswordUrl,
        body: {
          "email": args["email"],
          "OTP": args["pin"],
          "password": _passwordController.text,
        },
      );
      if (response.isSuccess) {
        snackbarMessgae(context, "Password reset success");
        Navigator.pushNamedAndRemoveUntil(
          context,
          SignInScreen.name,
              (route) => false,
        );
      } else {
        snackbarMessgae(context, response.errorMessage.toString());
      }
    }
  }

  void _onTapSignIn() {
    Navigator.pushReplacementNamed(context, SignInScreen.name);
  }
}
