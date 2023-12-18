import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/constants/ui_constants.dart';
import '../../controller/attendance_history_cubit.dart';
import '../../controller/attendance_history_state.dart';

class AttendanceHistoryScreen extends StatelessWidget {
  const AttendanceHistoryScreen({super.key});

  final TextStyle lateStyle = const TextStyle(color: Colors.red);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
           await BlocProvider.of<AttendanceHistoryCubit>(context)
                .getAttendanceHistory();
          },
          child: Container(
            color: Colors.grey.shade300,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.05,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Refresh History".tr,
                    style: TextStyle(color: Colors.black, fontSize: 18.sp),
                  ),
                  const Icon(
                    Iconsax.refresh,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<AttendanceHistoryCubit, AttendanceHistoryStates>(
              builder: (context, state) {
            if (state is AttendanceHistoryLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: UiConstant.kCosmoCareCustomColors1,
                ),
              );
            } else if (state is AttendanceHistorySuccessState) {
              return SizedBox(
                height: 0.85.sh,
                child: state.attendanceHistoryList.isEmpty
                    ? Center(
                        child: Card(
                        elevation: 3,
                        color: UiConstant.kCosmoCareCustomColors1,
                        margin: EdgeInsets.all(10.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.0.w),
                          child: Text(
                            'You don\'t have any attendance history'.tr,
                            style: TextStyle(fontSize: 20.sp),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ))
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Card(
                              elevation: 3,
                              color: UiConstant.kCosmoCareCustomColors1,
                              margin: EdgeInsets.all(10.w),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: DataTable(
                                columns: [
                                  DataColumn(
                                      label: Text(
                                    'Date'.tr,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                    ),
                                  )),
                                  DataColumn(
                                      label: Flexible(
                                          child: Text(
                                    'Check In Time'.tr,
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                    ),
                                  ))),
                                  DataColumn(
                                      label: Flexible(
                                          child: Text(
                                    'Check Out Time'.tr,
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                    ),
                                  ))),
                                ],
                                rows: state.attendanceHistoryList
                                    .map(
                                      ((element) => DataRow(
                                            cells: <DataCell>[
                                              DataCell(Text(
                                                element.date,
                                                textAlign: TextAlign.center,
                                                style:
                                                    TextStyle(fontSize: 13.sp),
                                              )),
                                              DataCell(Text(
                                                element.checkInTime,
                                                textAlign: TextAlign.center,
                                                style: element.checkedInOnTime
                                                    ? TextStyle(fontSize: 13.sp)
                                                    : lateStyle,
                                              )),
                                              DataCell(Center(
                                                child: Text(
                                                  element.checkOutTime,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 13.sp),
                                                ),
                                              )),
                                            ],
                                          )),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
              );
            } else {
              return Center(
                child: Text(
                  'Failed to get attendance history'.tr,
                  style: TextStyle(fontSize: 15.sp),
                ),
              );
            }
          }),
        ),
      ],
    );
  }
}
