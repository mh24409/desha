import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/helper/api_helper.dart';
import '../model/attendance_history_model.dart';
import 'attendance_history_state.dart';

class AttendanceHistoryCubit extends Cubit<AttendanceHistoryStates> {
  AttendanceHistoryCubit() : super(AttendanceHistoryInitState());

  Future<void> getAttendanceHistory() async {
    emit(AttendanceHistoryLoadingState());
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
        url: ApiConstants.baseUrl + ApiConstants.attendanceHistoryEndPoint,
        body: body,
        headers: headers,
      );
      debugPrint(response.toString());
      List<AttendanceHistoryModel> attendanceHistoryList = [];
      if (response['result']['status'] == 200) {
        var attendanceList = response['result']['data']['attendance_list'];
        for (var attendance in attendanceList) {
          attendanceHistoryList
              .add(AttendanceHistoryModel.fromJson(attendance));
        }
        emit(AttendanceHistorySuccessState(
            attendanceHistoryList: attendanceHistoryList));
      } else {
        Get.snackbar(
          'Failed to get attendance history'.tr,
          response['result']['message'],
          backgroundColor: Colors.red,
        );
        emit(AttendanceHistoryFailState());
      }
    } catch (e) {
      debugPrint('Error in getAttendanceHistory ${e.toString()}');
      emit(AttendanceHistoryFailState());
    }
  }
}
