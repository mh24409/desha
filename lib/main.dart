// ignore_for_file: prefer_const_constructors

import 'package:app_release2/constants.dart';
import 'package:app_release2/core/Localizations.dart';
import 'package:app_release2/core/auth/auth_provider.dart';
import 'package:app_release2/core/navbar.dart';
import 'package:app_release2/features/Login/views/login_view.dart';
import 'package:app_release2/features/Splash/views/splash_view.dart';
import 'package:app_release2/features/home/views/home_view.dart';
import 'package:app_release2/features/profile/views/profile_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
    WidgetsFlutterBinding.ensureInitialized();
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: KPrimaryColor));

  runApp( ChangeNotifierProvider(
    create: (ctx) => AuthProvider() ,
    child: CosmoTrackingApp()
    )
    );
}

class CosmoTrackingApp extends StatelessWidget {
   CosmoTrackingApp({super.key});
    

  @override
  Widget build(BuildContext context) {
final auth = Provider.of<AuthProvider>(context);
auth.tryAutoLogin();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(scaffoldBackgroundColor: KPrimaryColor ),
      locale: Get.deviceLocale,
      translations: Languages(),
      home: SplashView(),
      //home: auth.isAuthenticated ? HomeView() : LoginView(),


    );
  }
}
