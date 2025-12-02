import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  XFile? image;
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firtNamelTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    Text(
                      "Update Profile",
                      style: TextTheme.of(context).bodyLarge,
                    ),
                    SizedBox(height: 5),
                    InkWell(
                      onTap: _pickImage,
                      child: Container(
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
                            SizedBox(width: 5),
                            Expanded(
                              flex: 3,
                              child: Container(
                                color: Colors.white,
                                child: Center(
                                  child: Text(
                                    image != null
                                        ? image!.name.length > 20
                                              ? "${image!.name.substring(0, 20)} .."
                                              : ""
                                        : "select image",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _emailTEController,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(hintText: "Email"),
                    ),
                    TextFormField(
                      controller: _firtNamelTEController,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(hintText: "First name"),
                    ),
                    TextFormField(
                      controller: _lastNameTEController,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(hintText: "Last name"),
                    ),
                    TextFormField(
                      controller: _mobileTEController,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(hintText: "Mobile"),
                    ),
                    TextFormField(
                      controller: _passwordTEController,
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
      ),
    );
  }

  void _onTapSignUpButton() {
    if (_formKey.currentState!.validate()) {}
  }

  Future<void> _pickImage() async {
    ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }
}
