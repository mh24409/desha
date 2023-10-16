import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/Constants/ui_constants.dart';

class DetailRow extends StatelessWidget {
  final IconData icon;
  final String detailText;

  const DetailRow({super.key, required this.icon, required this.detailText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.06.sh,
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: UiConstant.kCosmoCareCustomColors1),
              SizedBox(width: 12.w),
              Flexible(
                  child: Text(
                detailText,
                style: TextStyle(fontSize: 10.sp),
              )),
            ],
          ),
          Flexible(
            child: Divider(
              color: Colors.grey.shade200,
            ),
          )
        ],
      ),
    );
  }
}
