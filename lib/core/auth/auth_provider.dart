import 'dart:convert';
import 'package:app_release2/constants.dart';
import 'package:app_release2/features/Login/views/login_view.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:app_release2/core/api/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  LoginModel? _loginModel;
  bool _isAuthenticated = false;

  LoginModel get user => _loginModel!;
  bool get isAuthenticated => _isAuthenticated;

  set user(LoginModel user) {
    _loginModel = user;
    notifyListeners();
  }

  Future<void> loginUser(String email, String password) async {
    
    final url = Uri.parse('$apiUrl/login');
    final headers = {
      "Content-Type": "text/html",
    };
    final body = {
      "identity": email,
      "password": password,
    };

    try {
        final response = await http.post(url, headers: headers, body: json.encode(body));

        if (response.statusCode == 200) {
            final responseData = json.decode(response.body);

            // Assuming your API sends a 5000 status for a login failure
            if (responseData['status'] == 5000) {
                throw Exception("Login Failed");
            }

            _loginModel = LoginModel.fromJson(responseData);
            _isAuthenticated = true;
            notifyListeners();

            final prefs = await SharedPreferences.getInstance();
            final userData = json.encode(_loginModel!.toJson());
            prefs.setString('userData', userData);
        } else {
            throw Exception("Login Failed");
        }
    } catch (error) {
        print(error);
        throw error;  // You can also handle the error more gracefully if needed
    }
}

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return;
    }
    final extractedUserData = json.decode(prefs.getString('userData')!);
    _loginModel = LoginModel.fromJson(extractedUserData);
    _isAuthenticated = true;
    notifyListeners();
  }


Future<void> logout() async {
  _isAuthenticated = false;
  _loginModel = null;
  notifyListeners();
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('userData');
  Get.offAll(() => LoginView()); // navigate to LoginView after logout
}

}
