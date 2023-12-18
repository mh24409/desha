import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/constants/ui_constants.dart';

class AttendanceTimeWidget extends StatelessWidget {
  const AttendanceTimeWidget({
    super.key,
    required this.checkingType,
    required this.isChecked,
    required this.checkTime,
  });
  final String checkingType;
  final bool isChecked;
  final String checkTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.h,
      width: 130.h,
      decoration: BoxDecoration(
        color: isChecked ? UiConstant.kCosmoCareCustomColors1 : Colors.grey,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Flexible(
                child: Icon(
                  Icons.login,
                  color: Colors.white,
                ),
              ),
              Flexible(
                flex: 2,
                child: Text(
                  checkingType,
                  style: TextStyle(color: Colors.white, fontSize: 15.sp),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          SizedBox(height: 10.h),
          isChecked
              ? Text(
                  '${'Time'.tr} $checkTime',
                  style: TextStyle(color: Colors.white, fontSize: 13.sp),
                  textAlign: TextAlign.center,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
