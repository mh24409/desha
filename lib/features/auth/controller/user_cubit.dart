import 'package:cosmo_care/features/app_control_feature/views/screens/main_control_screen.dart';
import 'package:cosmo_care/features/auth/controller/user_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/Constants/api_constants.dart';
import '../../../core/helper/api_helper.dart';
import '../model/user_model.dart';
import '../view/screens/login_screen.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(UserInitState());

  Future<void> getCurrentUserInfo() async {
    emit(UserLoadingState());
    SharedPreferences preferences = await SharedPreferences.getInstance();
    UserModel user = UserModel();
    user.userName = preferences.getString("userName");
    user.userId = preferences.getInt("id");
    user.email = preferences.getString("email");
    user.userImage = preferences.getString("image");
    user.trackingID = preferences.getString("trackingID");
    user.token = preferences.getString("token");

    emit(
      UserSuccessState(
        currentUser: user,
      ),
    );
  }

  Future<void> editImage(String? image) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userToken = preferences.getString("token")!;
    Map<String, String> headers = {
      "Authorization": "Bearer $userToken",
      "Content-Type": "text/html"
    };
    Map<String, dynamic> body = {
      'image': image,
    };
    final response = await ApiHelper().post(
      url: ApiConstants.baseUrl + ApiConstants.editProfileEndPoint,
      body: body,
      headers: headers,
    );
    print(response);
    if (response["status"] == 200) {
      String imageUrl = await getImage();
      preferences.setString("image", imageUrl);
      await getCurrentUserInfo();
      Get.snackbar(
        "Image update".tr,
        "update success".tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
      );

      Get.offAll(
        () => const MainControlScreen(),
      );
    }
  }

  Future<String> getImage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userToken = preferences.getString("token")!;
    Map<String, String> headers = {
      "Authorization": "Bearer $userToken",
      "Content-Type": "text/html"
    };

    final response = await ApiHelper().get(
      url: ApiConstants.baseUrl + ApiConstants.getProfileImageEndPoint,
      headers: headers,
    );
    print(response);
    if (response["status"] == 200) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("image", response['data']['image']);
      await getCurrentUserInfo();
      return response['data']['image'];
    }
    return "";
  }

  Future<void> editUserProfile(
      {String? name, String? phone, String? email}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userToken = preferences.getString("token")!;
    Map<String, String> headers = {
      "Authorization": "Bearer $userToken",
      "Content-Type": "text/html"
    };
    Map<String, dynamic> body = {
      "email": email,
      'user_name': name,
    };
    final response = await ApiHelper().post(
      url: ApiConstants.baseUrl + ApiConstants.editProfileEndPoint,
      body: body,
      headers: headers,
    );
    if (response["status"] == 200) {
      preferences.setString("userName", name!);
      await getCurrentUserInfo();
      if (preferences.getString('email') != email) {
        preferences.clear();
        preferences.setBool("isOnboardingSeen", true);
        Get.offAll(() => LoginScreen());
        Get.snackbar(
          "Update email successfully".tr,
          "Please login again".tr,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
        );
      } else {
        Get.snackbar(
          "profile update".tr,
          "update success".tr,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
        );
        Get.offAll(
          () => const MainControlScreen(),
        );
      }
    } else if (response["status"] == 402) {
      Get.snackbar(
        "profile update".tr,
        "This email already exists".tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<void> changePassword(
      {required String newPassword, required String currentPassword}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userToken = preferences.getString("token")!;
    Map<String, String> headers = {
      "Authorization": "Bearer $userToken",
      "Content-Type": "text/html"
    };
    String savedPassword = preferences.getString("password")!;
    Map<String, dynamic> body = {'password': newPassword};
    if (savedPassword == currentPassword) {
      final response = await ApiHelper().post(
        url: ApiConstants.baseUrl + ApiConstants.changePasswordEndPoint,
        body: body,
        headers: headers,
      );
      int status = response["status"];

      if (status == 200) {
        preferences.setString("password", newPassword);
        Get.back();
        Get.snackbar("Change Password Done".tr, "",
            backgroundColor: Colors.green);
      } else {
        Get.snackbar(
          "Change Password Failed".tr,
          "",
          backgroundColor: Colors.red,
        );
      }
    } else {
      Get.snackbar(
        "Error".tr,
        "Current Password Isn't Correct".tr,
        backgroundColor: Colors.red,
      );
    }
  }
}
