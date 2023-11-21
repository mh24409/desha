import 'package:cosmo_care/features/check_in_tracking/model/visit_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/Constants/api_constants.dart';
import '../../../core/helper/api_helper.dart';
import 'track_check_states.dart';

class TrackCheckingCubit extends Cubit<TrackCheckingStates> {
  TrackCheckingCubit() : super(TrackCheckingInitState());

  Future<void> trackChecking(
      bool isCheckIn, double latitude, double longitude, int customerId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userToken = preferences.getString("token")!;
    Map<String, String> headers = {
      "Authorization": "Bearer $userToken",
      "Content-Type": "text/html",
    };
    Map<String, dynamic> body = {
      'in': isCheckIn ? 0 : 1,
      'lat': latitude,
      'lng': longitude,
      'customer_id': customerId,
    };
    emit(TrackCheckingLoadingState());
    try {
      final response = await ApiHelper().post(
        url: ApiConstants.baseUrl + ApiConstants.trackChecking,
        headers: headers,
        body: body,
      );
      if (response["status"] != 200) {
        Get.snackbar("error".tr, "Can't check in".tr,
            backgroundColor: Colors.red);
        emit(TrackCheckingFailedState());
      } else {
        String key = "isCheckIn${customerId.toString()}";
        preferences.setBool(key, !isCheckIn);
        emit(TrackCheckingSuccessState(!isCheckIn));
      }
    } catch (e) {
      Get.snackbar(
          "Connection Error".tr, "Please check your internet connection".tr,
          backgroundColor: Colors.red);
      emit(TrackCheckingFailedState());
    }
  }

  Future<void> customerCheckInVisit(
      {required double latitude,
      required double longitude,
      required int customerId}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userToken = preferences.getString("token")!;
    Map<String, String> headers = {
      "Authorization": "Bearer $userToken",
      "Content-Type": "text/html",
    };
    Map<String, dynamic> body = {
      'lat': latitude,
      'lng': longitude,
      'customer_id': customerId,
    };
    emit(TrackCheckingLoadingState());
    try {
      final response = await ApiHelper().post(
        url: ApiConstants.baseUrl + ApiConstants.visitCheckInEndPoint,
        headers: headers,
        body: body,
      );
      if (response["status"] != 200) {
        Get.snackbar("error".tr, "Can't check in".tr,
            backgroundColor: Colors.red);
        emit(TrackCheckingFailedState());
      } else {
        String key = "isCheckIn${customerId.toString()}";
        preferences.setBool(key, true);
        emit(TrackCheckingSuccessState(true));
        Get.snackbar(
          "Check in".tr,
          "Changed customer status successfully".tr,
          backgroundColor: Colors.green,
        );
      }
    } catch (e) {
      Get.snackbar(
          "Connection Error".tr, "Please check your internet connection".tr,
          backgroundColor: Colors.red);
      emit(TrackCheckingFailedState());
    }
  }

  Future<void> customerCheckOutVisit(
      {required int statusId,
      required String reportDescription,
      required int customerId}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userToken = preferences.getString("token")!;
    Map<String, String> headers = {
      "Authorization": "Bearer $userToken",
      "Content-Type": "text/html",
    };
    Map<String, dynamic> body = {
      'status_id': statusId,
      'report_description': reportDescription,
      'customer_id': customerId,
    };
    emit(TrackCheckingLoadingState());
    try {
      final response = await ApiHelper().post(
        url: ApiConstants.baseUrl + ApiConstants.visitCheckOutEndPoint,
        headers: headers,
        body: body,
      );
      if (response["status"] != 200) {
        Get.snackbar("error".tr, "Can't check Out".tr,
            backgroundColor: Colors.red);
        emit(TrackCheckingFailedState());
      } else {
        String key = "isCheckIn${customerId.toString()}";
        preferences.remove(key);
        emit(TrackCheckingSuccessState(false));
        Get.snackbar("Check out".tr, "Changed customer status successfully".tr,
            backgroundColor: Colors.green);
      }
    } catch (e) {
      Get.snackbar(
          "Connection Error".tr, "Please check your internet connection".tr,
          backgroundColor: Colors.red);
      emit(TrackCheckingFailedState());
    }
  }

  Future<void> getCustomerTrackCheckingState(int customerId) async {
    emit(TrackCheckingLoadingState());
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String key = "isCheckIn${customerId.toString()}";
    bool isCheckIn = preferences.getBool(key) ?? false;
    emit(TrackCheckingSuccessState(isCheckIn));
  }

  static Future<List<VisitStateModel>> getVisitStatesModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userToken = preferences.getString("token")!;
    Map<String, String> headers = {
      "Authorization": "Bearer $userToken",
      "Content-Type": "text/html",
    };
    List<VisitStateModel> visitStates = [];
    try {
      final response = await ApiHelper().get(
        url: ApiConstants.baseUrl + ApiConstants.visitStatesEndPoint,
        headers: headers,
      );
      for (var visitState in response['data']) {
        visitStates.add(VisitStateModel.fromJson(visitState));
      }
      return visitStates;
    } catch (e) {
      return visitStates;
    }
  }
}
