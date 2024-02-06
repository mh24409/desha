// ignore_for_file: use_build_context_synchronously

import 'package:cosmo_care/features/auth/controller/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/Constants/api_constants.dart';
import '../../../core/Constants/ui_constants.dart';
import '../../../core/helper/api_helper.dart';
import '../../../core/shared/methods/imei_getter.dart';
import '../../../core/widgets/widgets/custom_button_widget.dart';
import '../../customers/controller/get_all_customer_cubit.dart';
import '../../orders/controller/cubit/user_sale_orders_cubit.dart';
import '../view/screens/login_screen.dart';
import 'auth_state.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cosmo_care/core/shared/global_variables.dart' as global;

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitState());

  Future<void> signInWithEmailAndPassword(context,
      {required String email, required String password}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String imei = await getIMEI();
    Map<String, String> body = {
      'identity': email,
      'password': password,
      'imei': imei
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
        preferences.setInt(
            "employee_id", response["profile"]["employee_id"] ?? 0);
        preferences.setString("trackingID", response["trackingID"]);
        preferences.setString("token", response["token"]);
        preferences.setInt("id", response["profile"]["id"]);
        preferences.setString("email", response["profile"]["email"]);
        preferences.setString("userName", response["profile"]["full_name"]);
        preferences.setString("image", response["profile"]["image"]);
        BlocProvider.of<UserCubit>(context).getCurrentUserInfo();
        await BlocProvider.of<GetAllCustomerCubit>(context).getAllCustomers();
        await BlocProvider.of<UserSaleOrdersCubit>(context)
            .getCurrentUserSaleOrders();
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
      String password = preferences.getString("password")!;
      String email = preferences.getString("email")!;

      try {
        String imei = await getIMEI();
        Map<String, String> body = {
          'identity': email,
          'password': password,
          'imei': imei
        };
        Map<String, String> headers = {"Content-Type": "text/html"};
        final response = await ApiHelper().post(
            url: ApiConstants.baseUrl + ApiConstants.loginEndPoint,
            body: body,
            headers: headers);
        if (response["status"] == 5000) {
          logOut(context: context);
          Get.snackbar(
              "Login info changed".tr,
              "Your email or password changed. please call your administrator to get your new login info"
                  .tr,
              backgroundColor: Colors.blue,
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 5));
        } else {
          preferences.setString("token", response["token"]);
          emit(LoginSuccessState());
        }
      } catch (e) {
        Get.snackbar("Connection Error".tr,
            "Please check your internet connection".trParams(),
            backgroundColor: Colors.red);
      }
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
    try {
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
        bool accept = await Get.dialog(
          AlertDialog(
            title: Text('Location Permission'.tr),
            actions: [
              CustomButton(
                buttonWidth: 0.3.sw,
                buttonHeight: 30.h,
                buttonBorderRadius: 0,
                buttonMargin: 0,
                buttonTextFontSize: 12,
                buttonText: "Accept".tr,
                buttonAction: () => Get.back(result: true),
                buttonColor: UiConstant.kCosmoCareCustomColors1,
              ),
              CustomButton(
                buttonWidth: 0.3.sw,
                buttonHeight: 30.h,
                buttonBorderRadius: 0,
                buttonMargin: 0,
                buttonTextFontSize: 12,
                buttonText: "Reject".tr,
                buttonAction: () => Get.snackbar(
                  "Please allow permission".tr,
                  "The app cannot function without this permission".tr,
                  backgroundColor: Colors.red,
                ),
                buttonColor: Colors.red,
              ),
            ],
            content: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 16.sp),
                children: [
                  TextSpan(
                    text: 'Cosmocare app '.tr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                      text:
                          'collects location data for sales management to manage sale team agents by monitoring their location when they are logged in, even when the app is closed and not in use. The app stops monitoring when you are logged out.'
                              .tr),
                ],
              ),
            ),
          ),
          barrierDismissible: false,
        );
        if (accept) {
          try {
            permissionGranted = await location.requestPermission();
            if (permissionGranted != PermissionStatus.granted) {
              return;
            }
          } catch (e) {
            debugPrint("Error in location permission ${e.toString()}");
            permissionGranted = await location.requestPermission();
            while (permissionGranted != PermissionStatus.granted) {
              permissionGranted = await location.requestPermission();
            }
          }
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
    } catch (e) {
      debugPrint('Cannot get live location ${e.toString()}');
    }
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
