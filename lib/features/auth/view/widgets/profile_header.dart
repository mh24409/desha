import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/Constants/assets_path_constants.dart';
import '../../../../core/widgets/widgets/vertical_spacer.dart';

// ignore: must_be_immutable
class ProfileHeader extends StatelessWidget {
  String userName;
  ProfileHeader({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.18,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage(AssetsPathConstants.kProfileHeaderBGImagePath),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width / 6,
                    backgroundColor: const Color(0xffD9D9D9),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: MediaQuery.of(context).size.width / 4,
                    ),
                  ),
                  VerticalSpacer(10.h),
                  Text(
                    userName,
                    style: TextStyle(fontSize: 16.sp),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
