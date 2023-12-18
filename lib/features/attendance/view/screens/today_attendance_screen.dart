import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/constants/ui_constants.dart';
import '../../controller/today_attendance_cubit.dart';
import '../../controller/today_attendance_state.dart';
import '../widgets/attendance_time_widget.dart';
import 'package:intl/intl.dart';

class TodayAttendanceScreen extends StatelessWidget {
  const TodayAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Text(
                'Today'.tr,
                style: TextStyle(
                    color: UiConstant.kCosmoCareCustomColors1, fontSize: 20.sp),
              ),
              Text(
                ": ${DateFormat('EEEE, d MMMM yyyy').format(DateTime.now())}",
                style: TextStyle(
                    color: UiConstant.kCosmoCareCustomColors1, fontSize: 20.sp),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Divider(),
        ),
        Flexible(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25.h),
            child: BlocBuilder<TodayAttendanceCubit, TodayAttendanceStates>(
                builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AttendanceTimeWidget(
                    checkingType: 'Checked in'.tr,
                    isChecked: context.read<TodayAttendanceCubit>().checkedIn,
                    checkTime: context.read<TodayAttendanceCubit>().checkInTime,
                  ),
                  AttendanceTimeWidget(
                    checkingType: 'Checked out'.tr,
                    isChecked: context.read<TodayAttendanceCubit>().checkedOut,
                    checkTime:
                        context.read<TodayAttendanceCubit>().checkOutTime,
                  ),
                ],
              );
            }),
          ),
        ),
        Flexible(
          flex: 1,
          child: BlocBuilder<TodayAttendanceCubit, TodayAttendanceStates>(
              builder: (context, state) {
            String buttonText = '';
            if (!context.read<TodayAttendanceCubit>().checkedIn) {
              buttonText = 'Check in'.tr;
            } else if (!context.read<TodayAttendanceCubit>().checkedOut) {
              buttonText = 'Check out'.tr;
            } else {
              buttonText = 'Done for the day👍🏼'.tr;
            }

            return Center(
              child: EasyButton(
                idleStateWidget: Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20.sp),
                ),
                loadingStateWidget: const Center(
                    child: CircularProgressIndicator(
                  color: UiConstant.kCosmoCareCustomColors1,
                )),
                useWidthAnimation: true,
                useEqualLoadingStateWidgetDimension: false,
                width: 0.4.sw,
                height: 0.4.sw,
                contentGap: 1.0.h,
                buttonColor: UiConstant.kCosmoCareCustomColors1,
                borderRadius: 300.r,
                onPressed: () async {
                  if (!context.read<TodayAttendanceCubit>().checkedIn) {
                    await context.read<TodayAttendanceCubit>().checkIn();
                  } else if (!context.read<TodayAttendanceCubit>().checkedOut) {
                    await context.read<TodayAttendanceCubit>().checkOut();
                  } else {
                    await context
                        .read<TodayAttendanceCubit>()
                        .getTodayCheckingStatus();
                    Get.snackbar('Already checked in and out'.tr,
                        'You have already checked in and out today'.tr);
                  }
                },
              ),
            );
          }),
        )
      ],
    );
  }
}
