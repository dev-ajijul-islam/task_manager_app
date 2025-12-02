import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_managment_app/data/models/user_model.dart';

class AuthController {
  static const String _userKey = "user";
  static const String _tokenKey = "token";

  static String? accessToken;
  static UserModel? user;

  /// Save user + token after login
  static Future<void> saveUserData(String token, UserModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_userKey, jsonEncode(userModel.toJson()));

    user = userModel;        // <-- update in memory
    accessToken = token;
  }

  /// Update local stored user after profile update
  static Future<void> updateUserData(UserModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(userModel.toJson()));

    user = userModel;        // <-- important
  }

  /// Load user on app start
  static Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(_tokenKey);
    String? userJson = prefs.getString(_userKey);

    if (token != null && userJson != null) {
      accessToken = token;
      user = UserModel.fromJson(jsonDecode(userJson));
    }
  }

  static Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey) != null;
  }

  static Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    user = null;
    accessToken = null;
  }
}
