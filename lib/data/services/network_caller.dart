import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class NetworkCaller {
  //get request
  Future<NetworkResponse> getRequest(String uri) async {
    Uri url = Uri.parse(uri);

    _logRequest(uri);

    try {
      Response response = await get(url);

      _logResponse(uri, response: response);

      final decodedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodedData,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedData.data
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: "something went wrong $e",
      );
    }
  }

  //post request
  Future<NetworkResponse> postRequest(
    String uri, {
    Map<String, dynamic>? body,
  }) async {
    Uri url = Uri.parse(uri);

    _logRequest(uri);

    try {
      Response response = await post(
        url,
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json"},
      );

      _logResponse(uri, response: response);

      final  decodedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: response.body,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedData["data"],
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: "Something went wrong $e",
      );
    }
  }

  //log request
  _logRequest(String url) {
    debugPrint("Requested url : $url");
  }

  //log response
  _logResponse(String url, {Response? response}) {
    debugPrint(
      "Requested url : $url \n"
      "StatusCode : ${response?.statusCode}\n"
      "Body : ${response?.body}",
    );
  }
}

class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final dynamic body;
  final String? errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.body,
    this.errorMessage,
  });
}
