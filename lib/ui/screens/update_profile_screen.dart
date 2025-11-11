import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_managment_app/ui/screens/forget_password_email.dart';
import 'package:task_managment_app/ui/screens/main_layout_screen.dart';
import 'package:task_managment_app/ui/screens/sign_in_screen.dart';
import 'package:task_managment_app/ui/widgets/screen_backgrond.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  static String name = "update-profile-screen";

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreen();
}

class _UpdateProfileScreen extends State<UpdateProfileScreen> {
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
                  Text(
                    "Update Profile",
                    style: TextTheme.of(context).bodyLarge,
                  ),
                  SizedBox(height: 5),
                  Container(
                    clipBehavior: Clip.hardEdge,
                    width: double.maxFinite,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.black87,
                            child: Center(
                              child: Text(
                                "Photo",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
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

  void _onTapSignIn() {
    Navigator.pushReplacementNamed(context, SignInScreen.name);
  }

  void _onTapForgetPassword() {
    Navigator.pushNamed(context, ForgetPasswordEmail.name);
  }
}
