import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/helper/api_helper.dart';
import '../../../core/shared/global_variables.dart';
import '../../../core/shared/methods/imei_getter.dart';
import 'today_attendance_state.dart';

class TodayAttendanceCubit extends Cubit<TodayAttendanceStates> {
  TodayAttendanceCubit() : super(TodayAttendanceInitState());

  String checkInTime = '';
  String checkOutTime = '';
  bool checkedIn = false;
  bool checkedOut = false;

  Future<void> getTodayCheckingStatus() async {
    emit(TodayAttendanceLoadingState());
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      int employeeId = preferences.getInt('employee_id')!;
      String language =
          preferences.getString('appLang') ?? Get.deviceLocale!.languageCode;
      Map<String, String> headers = {'Content-Type': 'application/json'};
      Map<String, dynamic> body = {
        'employee_id': employeeId,
        'language': language,
      };
      final response = await ApiHelper().post(
        url: ApiConstants.baseUrl + ApiConstants.todayCheckingStatusEndPoint,
        body: body,
        headers: headers,
      );
      if (response['result']['status'] == 200) {
        var data = response['result']['data'];
        setCheckingData(data);
        emit(TodayAttendanceSuccessState());
      } else {
        Get.snackbar(
          'Failed to get attendance data'.tr,
          response['result']['message'],
          backgroundColor: Colors.red,
        );
        emit(TodayAttendanceFailState());
      }
    } catch (e) {
      debugPrint('Error in getTodayCheckingStatus ${e.toString()}');
      emit(TodayAttendanceFailState());
    }
  }

  void setCheckingData(data) {
    checkInTime = data['check_in_time'];
    checkOutTime = data['check_out_time'];
    checkedIn = data['checked_in'];
    checkedOut = data['checked_out'];
  }

  Future<void> checkIn() async {
    emit(TodayAttendanceLoadingState());
    try {
      Map<String, String> headers = {'Content-Type': 'application/json'};
      Map<String, dynamic> body = await getCheckBody();
      final response = await ApiHelper().post(
        url: ApiConstants.baseUrl + ApiConstants.checkInEndPoint,
        body: body,
        headers: headers,
      );
      if (response['result']['status'] == 200) {
        Get.snackbar(
          'Checked in successfully'.tr,
          '',
          backgroundColor: Colors.green,
        );
        emit(TodayAttendanceSuccessState());
      } else {
        Get.snackbar(
          'Failed to check in'.tr,
          response['result']['message'],
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 6),
        );
        emit(TodayAttendanceFailState());
      }
      getTodayCheckingStatus();
    } catch (e) {
      debugPrint('Error in check in ${e.toString()}');
      emit(TodayAttendanceFailState());
    }
  }

  Future<void> checkOut() async {
    emit(TodayAttendanceLoadingState());
    try {
      Map<String, String> headers = {'Content-Type': 'application/json'};
      Map<String, dynamic> body = await getCheckBody();
      final response = await ApiHelper().post(
        url: ApiConstants.baseUrl + ApiConstants.checkOutEndPoint,
        body: body,
        headers: headers,
      );
      if (response['result']['status'] == 200) {
        Get.snackbar(
          'Checked out successfully'.tr,
          '',
          backgroundColor: Colors.green,
        );
        emit(TodayAttendanceSuccessState());
      } else {
        Get.snackbar(
          'Failed to check out'.tr,
          response['result']['message'],
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 6),
        );
        emit(TodayAttendanceFailState());
      }
      getTodayCheckingStatus();
    } catch (e) {
      debugPrint('Error in checkout ${e.toString()}');
      emit(TodayAttendanceFailState());
    }
  }

  Future<Map<String, dynamic>> getCheckBody() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int employeeId = preferences.getInt('employee_id')!;
    String imei = await getIMEI();
    Map<String, dynamic> body = {
      'employee_id': employeeId,
      'imei': imei,
      'lat': currentUserLat,
      'lon': currentUserLong,
    };
    return body;
  }
}
