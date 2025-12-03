import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_managment_app/data/models/user_model.dart';
import 'package:task_managment_app/data/services/network_caller.dart';
import 'package:task_managment_app/ui/controllers/auth_controller.dart';
import 'package:task_managment_app/ui/widgets/app_bar_widget.dart';

import 'package:task_managment_app/ui/widgets/screen_backgrond.dart';
import 'package:task_managment_app/ui/widgets/snackbar_message.dart';
import 'package:task_managment_app/utils/url.dart';

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
  void initState() {
    UserModel? userModel = AuthController.user;

    _emailTEController.text = userModel!.email;
    _firtNamelTEController.text = userModel.firstName;
    _lastNameTEController.text = userModel.lastName;
    _mobileTEController.text = userModel.mobile;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
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
                                child: Text(
                                  style: TextStyle(color: Colors.grey),
                                  image != null
                                      ? image!.name.length > 20
                                            ? "${image!.name.substring(0, 20)} .."
                                            : image!.name
                                      : "select image",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextFormField(
                      enabled: false,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter Email";
                        }
                        if (!value.contains("@") || !value.contains(".com")) {
                          return "Enter valid Email";
                        }
                        return null;
                      },
                      controller: _emailTEController,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(hintText: "Email"),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter First name";
                        }
                        return null;
                      },
                      controller: _firtNamelTEController,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(hintText: "First name"),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter last name";
                        }
                        return null;
                      },
                      controller: _lastNameTEController,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(hintText: "Last name"),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter phone number";
                        }
                        if (value.length < 11) {
                          return "Phone number must be at least 11 charecter";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      controller: _mobileTEController,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(hintText: "Mobile"),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isNotEmpty && value.length < 6) {
                          return "Password must be at least 6 letters";
                        }
                        return null;
                      },
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
    if (_formKey.currentState!.validate()) {
      _updateProfile();
    }
  }

  Future<void> _updateProfile() async {
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firtNamelTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
    };

    if (_passwordTEController.text.isNotEmpty) {
      requestBody["password"] = _passwordTEController.text;
    }

    if (image != null) {
      Uint8List imageByte = await image!.readAsBytes();
      requestBody["photo"] = base64Encode(imageByte);
    }

    NetworkResponse response = await NetworkCaller.postRequest(
      Url.updateProfileUrl,
      body: requestBody,
    );

    if (response.isSuccess) {
      await AuthController.updateUserData(UserModel.fromJson(requestBody));
      await AuthController.getUserData();
      snackbarMessgae(context, "Profile Updated");
      setState(() {});
    } else {
      snackbarMessgae(context, response.errorMessage.toString());
    }
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
