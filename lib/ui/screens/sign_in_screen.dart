import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_managment_app/data/models/user_model.dart';
import 'package:task_managment_app/data/services/network_caller.dart';
import 'package:task_managment_app/ui/controllers/auth_controller.dart';
import 'package:task_managment_app/ui/screens/forget_password_email.dart';
import 'package:task_managment_app/ui/screens/main_layout_screen.dart';
import 'package:task_managment_app/ui/screens/sign_up_screen.dart';
import 'package:task_managment_app/ui/widgets/screen_backgrond.dart';
import 'package:task_managment_app/ui/widgets/snackbar_message.dart';
import 'package:task_managment_app/utils/url.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static String name = "sign-in-screen";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  bool isPasswordShow = true;

  bool signInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter email";
                      }
                      if (EmailValidator.validate(value!) == false) {
                        return "Enter valid email";
                      }
                      return null;
                    },
                    controller: _emailTEController,
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(hintText: "Email",prefixIcon: Icon(Icons.person_outline)),
                  ),
                  TextFormField(
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter password";
                      }
                      return null;
                    },

                    controller: _passwordTEController,
                    obscureText: isPasswordShow,
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordShow = !isPasswordShow;
                          });
                        },
                        icon: Icon(
                          isPasswordShow
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Visibility(
                    visible: signInProgress == false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: FilledButton(
                      onPressed: _onTapSignINButton,
                      child: Icon(Icons.arrow_circle_right_outlined, size: 25),
                    ),
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
                                  ..onTap = _onTapSignUp,
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

  void _onTapSignINButton() async {
    setState(() {
      signInProgress = true;
    });
    if (_formKey.currentState!.validate()) {
      final Map<String, dynamic> requestedBody = {
        "email": _emailTEController.text.trim(),
        "password": _passwordTEController.text,
      };

      NetworkResponse response = await NetworkCaller.postRequest(
        Url.signInUrl,
        body: requestedBody,
      );

      if (response.isSuccess) {
        UserModel user = UserModel.fromJson(response.body["data"]);
        String token = response.body["token"];

        await AuthController.saveUserData(token, user).then((value) async {
          await AuthController.getUserData().then((_) {
            snackbarMessgae(context, "Sign in success");
            _clearForm();
            Navigator.pushNamedAndRemoveUntil(
              context,
              MainLayoutScreen.name,
              (predicated) => false,
            );
          });
        });
      } else {
        snackbarMessgae(context, response.errorMessage.toString());
      }
    }
    setState(() {
      signInProgress = false;
    });
  }

  void _onTapSignUp() {
    Navigator.pushNamed(context, SignUpScreen.name);
  }

  void _onTapForgetPassword() {
    Navigator.pushNamed(context, ForgetPasswordEmail.name);
  }

  void _clearForm() {
    _emailTEController.clear();
    _passwordTEController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
  }
}
