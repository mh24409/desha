import 'package:cosmo_care/features/attendance/view/screens/today_attendance_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/Constants/ui_constants.dart';
import 'attendance_history_screen.dart';



class AttendanceControlScreen extends StatelessWidget {
  const AttendanceControlScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Attendance".tr,
            style: TextStyle(
              color: UiConstant.kCosmoCareCustomColors1,
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            indicatorColor: UiConstant.kCosmoCareCustomColors1,
            tabs: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Attendance Sheet".tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: UiConstant.kCosmoCareCustomColors1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "History".tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: UiConstant.kCosmoCareCustomColors1),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TodayAttendanceScreen(),
            AttendanceHistoryScreen()
          ],
        ),
      ),
    );
  }
}