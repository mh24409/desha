import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/Constants/ui_constants.dart';
import '../../../../core/widgets/widgets/horizontal_spacer.dart';

class DrawerListOfMenuHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  const DrawerListOfMenuHeader(
      {Key? key, required this.icon, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Icon(
                icon,
                color: UiConstant.kCosmoCareCustomColors1,
              ),
              HorizontalSpacer(10.w),
              Text(
                title,
                style: TextStyle(
                  color: UiConstant.kCosmoCareCustomColors1,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
