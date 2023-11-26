import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClickedOptionWidget extends StatelessWidget {
  final void Function()? onTap;
  final String optionName;
  final Color optionNameColor;
  const ClickedOptionWidget({
    Key? key,
    required this.optionName,
    required this.onTap,
    this.optionNameColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              optionName,
              style: TextStyle(color: optionNameColor, fontSize: 17.sp),
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }
}
