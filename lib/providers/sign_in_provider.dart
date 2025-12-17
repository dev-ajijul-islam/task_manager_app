import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_managment_app/data/models/user_model.dart';
import 'package:task_managment_app/data/services/network_caller.dart';
import 'package:task_managment_app/utils/url.dart';

class SignInProvider extends ChangeNotifier {
  bool signInProgress = false;
  static String? accessToken;
  static UserModel? user;
  static const String _userKey = "user";
  static const String _tokenKey = "token";

  Future<NetworkResponse> signIn({
    required String email,
    required String password,
  }) async {
    signInProgress = true;
    notifyListeners();

    try {
      final Map<String, dynamic> requestedBody = {
        "email": email,
        "password": password,
      };

      NetworkResponse response = await NetworkCaller.postRequest(
        Url.signInUrl,
        body: requestedBody,
      );

      if (response.isSuccess) {
        String token = response.body["token"];
        UserModel user = UserModel.fromJson(response.body["data"]);
        await saveUserData(token, user);
        return NetworkResponse(isSuccess: true, statusCode: 200);
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      debugPrint("sign in failed failed $e");
      return NetworkResponse(isSuccess: false, statusCode: -1);
    } finally {
      signInProgress = false;
      notifyListeners();
    }
  }

  Future<void> saveUserData(String token, UserModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_userKey, jsonEncode(userModel.toJson()));

    user = userModel;
    accessToken = token;
  }
}
