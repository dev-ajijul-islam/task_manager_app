import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_managment_app/data/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  static String? accessToken;
  static UserModel? user;
  static const String _userKey = "user";
  static const String _tokenKey = "token";

  Future<void> saveUserData(String token, UserModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_userKey, jsonEncode(userModel.toJson()));

    user = userModel;
    accessToken = token;

    notifyListeners();
  }
}
