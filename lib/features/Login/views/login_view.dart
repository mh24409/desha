// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:app_release2/constants.dart';
import 'package:app_release2/core/api/models/login_model.dart';
import 'package:app_release2/core/auth/auth_provider.dart';
import 'package:app_release2/core/utils/assets.dart';
import 'package:app_release2/features/Login/views/widgets/custom_button.dart';
import 'package:app_release2/features/Login/views/widgets/custom_form_field.dart';
import 'package:app_release2/features/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool _isLoading = false;

  Future<void> _login() async {
    if (!formKey.currentState!.validate()) {
      return; // Exit if form isn't valid
    }

    setState(() {
      _isLoading = true;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      await authProvider.loginUser(
          _emailController.text, _passwordController.text);
      if (authProvider.isAuthenticated) {
        Get.to(() => HomeView());
      }
    } catch (error) {
      // Error handling if login fails
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("login failed".tr),
          content: Text("error".tr),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("ok".tr),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0.0, actions: [
        TextButton(
          onPressed: () {
            String currentLocale = Get.locale!.languageCode;
            String newLocale = (currentLocale == 'ar') ? 'en' : 'ar';
            Get.updateLocale(Locale(newLocale));
          },
          child: Text("1".tr),
        )
      ]),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(130, 0, 130, 0),
                child: Container(
                    width: 400,
                    height: 50,
                    color: KThemeColor,
                    child: Image.asset(AssetsData.logo)),
              ),
              const SizedBox(height: 40),
              CustomTextField(
                controller: _emailController,
                hintText: "username".tr,
                prefixIcon: Icons.person_outline,
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "email is req".tr;
                  }
                  final emailPattern = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailPattern.hasMatch(value)) {
                    return "email is not valid".tr;
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: _passwordController,
                hintText: "pass".tr,
                prefixIcon: Icons.lock_outline,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "pass is req".tr;
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                onTap: _login,
                icon: Icons.login,
                text: "login".tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
