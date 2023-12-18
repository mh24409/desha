import '../model/attendance_history_model.dart';

abstract class AttendanceHistoryStates {}

class AttendanceHistoryInitState extends AttendanceHistoryStates {}

class AttendanceHistorySuccessState extends AttendanceHistoryStates {
  final List<AttendanceHistoryModel> attendanceHistoryList;
  AttendanceHistorySuccessState({required this.attendanceHistoryList});
}

class AttendanceHistoryLoadingState extends AttendanceHistoryStates {}

class AttendanceHistoryFailState extends AttendanceHistoryStates {}
