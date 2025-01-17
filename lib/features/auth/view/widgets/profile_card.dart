import 'package:cosmo_care/core/widgets/widgets/vertical_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ProfileCard extends StatelessWidget {
  String cardName;
  String cardValue;
  ProfileCard({Key? key, required this.cardName, required this.cardValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 6,
            offset: Offset(0.0, 5),
          ),
        ],
        color: const Color(0xffF9F6F6),
        borderRadius: BorderRadius.circular(10),
      ),
      height: MediaQuery.of(context).size.height * 0.12,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cardName,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
            VerticalSpacer(MediaQuery.of(context).size.height * 0.02),
            Text(
              cardValue,
              style: TextStyle(fontSize: 11.sp),
            ),
          ],
        ),
      ),
    );
  }
}
