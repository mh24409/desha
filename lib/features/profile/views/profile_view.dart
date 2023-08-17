// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:app_release2/constants.dart';
import 'package:app_release2/core/auth/auth_provider.dart';
import 'package:app_release2/core/utils/assets.dart';
import 'package:app_release2/features/Login/views/login_view.dart';
import 'package:app_release2/features/Login/views/widgets/custom_button.dart';
import 'package:app_release2/features/profile/views/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
        final auth = Provider.of<AuthProvider>(context);

    if (!auth.isAuthenticated) {

  Get.offAll(() => LoginView()); // navigate to LoginView after logout
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
          'account'.tr,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        )),
        backgroundColor: KPrimaryColor,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
      Stack(
        children: [
          Container(
        width: 430.0,
        height: 255.0,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(color: KThemeColor),
            ),
            Expanded(
              flex: 1,
              child: Container(color: Colors.white),
            ),
          ],
        ),
          ),
          Positioned(bottom: 60, child: Image.asset(AssetsData.ellipse3)),
          Positioned( child: Image.asset(AssetsData.ellipse22)),
          Positioned(
          top: 50,
          height: 210,
          width: 210,
          right: -20,
          child: Image.asset(AssetsData.ellipse4)),
          Positioned(
          top: -20,
          height: 243,
          width: 243,
          right: -20,
          child: Image.asset(AssetsData.ellipse2)),
        Positioned(
          left: 140,
          top: 90,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Color(0XFFD9D9D9),
            backgroundImage: AssetImage(AssetsData.profile),
          ))
        ],
      ),
      
            Text( Provider.of<AuthProvider>(context).user.profile.fullName),
            SizedBox(
              height: 50,
            ),
            CustomCard(
              title: 'username'.tr,
              subtitle: Provider.of<AuthProvider>(context).user.profile.username,
            ),
            SizedBox(
              height: 30,
            ),
            CustomCard(
              title: 'email'.tr,
              subtitle: Provider.of<AuthProvider>(context).user.profile.email,
            ),
      
      
            SizedBox(
              height: 40,
            ),
      
            //////////
            CustomButton(
              text: 'logout'.tr,
              icon: Icons.logout,
              onTap: () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final auth = Provider.of<AuthProvider>(context, listen: false);
          auth.logout();
          // Navigations or any other code you have
        });
              },
            )
          ],
        ),
      ),
    );
  }
}
