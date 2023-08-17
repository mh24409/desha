// ignore_for_file: prefer_const_constructors

import 'package:app_release2/constants.dart';
import 'package:app_release2/features/Splash/views/widgets/splash_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SplashView extends StatelessWidget {
  const SplashView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KThemeColor,
      body: SplashViewBody() ,
    );
  }
}