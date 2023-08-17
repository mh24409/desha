import 'package:app_release2/core/auth/auth_provider.dart';
import 'package:app_release2/core/utils/assets.dart';
import 'package:app_release2/features/Login/views/login_view.dart';
import 'package:app_release2/features/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
    // LatLng? _initialPosition;

  
  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 4),() {
      final auth = Provider.of<AuthProvider>(context, listen: false);
      if (auth.isAuthenticated) {
        Get.off(() => const HomeView(), transition: Transition.fadeIn);
      } else {
        Get.off(() => LoginView(), transition: Transition.fadeIn);
      }
    });
  }
      // _getCurrentLocation().then((position) {
    //   setState(() {
    //     _initialPosition = LatLng(position.latitude, position.longitude);
    //   });
    // });

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.fromLTRB(80,0,80,0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AssetsData.logo)
        ],
      ),
    );
  }

  // Future <Position> _getCurrentLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text(
  //             'Location services are disabled. Please enable the services')));
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Location permissions are denied')));
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text(
  //             'Location permissions are permanently denied, we cannot request permissions.')));
  //   }
  //   return await Geolocator.getCurrentPosition();
  // }
}