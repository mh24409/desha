import 'package:cosmo_care/features/auth/controller/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/Constants/api_constants.dart';
import '../../../core/helper/api_helper.dart';
import '../../customers/controller/get_all_customer_cubit.dart';
import '../view/screens/login_screen.dart';
import 'auth_state.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cosmo_care/core/shared/global_variables.dart' as global;

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitState());

  Future<void> signInWithEmailAndPassword(context,
      {required String email, required String password}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'identity': email,
      'password': password,
    };
    Map<String, String> headers = {"Content-Type": "text/html"};

    try {
      emit(AuthLoadingState());
      final response = await ApiHelper().post(
          url: ApiConstants.baseUrl + ApiConstants.loginEndPoint,
          body: body,
          headers: headers);
      if (response["status"] == 5000) {
        emit(LoginFailureState(
            errorMessage: "email or password are not correct".tr));
      } else {
        preferences.setBool("isLoggedIn", true);
        preferences.setString("password", password);
        preferences.setString("trackingID", response["trackingID"]);
        preferences.setString("token", response["token"]);
        preferences.setInt("id", response["profile"]["id"]);
        preferences.setString("email", response["profile"]["email"]);
        preferences.setString("userName", response["profile"]["full_name"]);
        preferences.setString("image", response["profile"]["image"]);
        BlocProvider.of<UserCubit>(context).getCurrentUserInfo();
        await BlocProvider.of<GetAllCustomerCubit>(context).getAllCustomers();
        emit(LoginSuccessState());
      }
    } catch (e) {
      Get.snackbar("Connection Error".tr,
          "Please check your internet connection".trParams(),
          backgroundColor: Colors.red);
    }
  }

  void onSplashViewScreenLaunch(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 5));
    bool loginState = preferences.getBool('isLoggedIn') ?? false;
    if (loginState == true) {
      emit(LoginSuccessState());
    } else {
      emit(LoginFailureState(errorMessage: "User Not Login"));
    }
  }

  void logOut({required BuildContext context}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String appLanguage = preferences.getString("appLang") ?? "en";
    int userId = preferences.getInt("id")!;
    preferences.clear();
    emit(AuthInitState());
    preferences.setString("appLang", appLanguage);
    Get.snackbar("Logout Success".tr, "Your location isn't tracked now".tr);
    await _deleteUserFromFirebase(userId: userId.toString());
    await await Get.offAll(() => LoginScreen());
  }

  static void liveLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    Location location = Location();
    // await enableBackgroundMode();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //---------Request to enable location---------------
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    //---------Request to has permission---------------
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    StreamSubscription<LocationData>? locationSubscription;
    locationSubscription = location.onLocationChanged.listen(
      (LocationData currentLocation) async {
        try {
          bool isLogin = preferences.getBool('isLoggedIn') ?? false;
          int userId = preferences.getInt("id")!;
          String fullName = preferences.getString("userName")!;
          String email = preferences.getString("email")!;
          if (isLogin) {
            global.currentUserLat = currentLocation.latitude!;
            global.currentUserLong = currentLocation.longitude!;
            await _updateUserLocation(
              userId: userId.toString(), // Replace with the actual user ID
              lat: currentLocation.latitude!,
              lng: currentLocation.longitude!,
              fullName: fullName,
              image: 'http://qcsales.cosmocare.net/img/anonymous.jpg',
              timestamp: DateTime.now().toString(),
              email: email,
            );
          } else {
            locationSubscription!.cancel();
          }
        } catch (e) {
          locationSubscription!.cancel();
        }
      },
    );
    location.enableBackgroundMode(enable: true);
  }

  static Future<void> _updateUserLocation({
    required String userId,
    required double lat,
    required double lng,
    required String fullName,
    required String image,
    required String timestamp,
    required String email,
  }) async {
    FirebaseDatabase database = FirebaseDatabase.instance;
    final DatabaseReference usersRef = database.ref().child('users');
    await usersRef.child(userId).update({
      'lat': lat.toString(),
      'lng': lng.toString(),
      'full_name': fullName,
      'image': image,
      'timestamp': timestamp,
      'username': email,
    });
  }

  static Future<void> _deleteUserFromFirebase({required String userId}) async {
    FirebaseDatabase database = FirebaseDatabase.instance;
    final DatabaseReference usersRef = database.ref().child('users');
    await usersRef.child(userId).remove();
  }
}
