import 'package:cosmo_care/features/auth/view/screens/profile_screen.dart';
import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/Constants/api_constants.dart';
import '../../../../core/Constants/assets_path_constants.dart';
import '../../../../core/Constants/ui_constants.dart';
import '../../../../core/widgets/widgets/horizontal_spacer.dart';
import '../../../../core/widgets/widgets/vertical_spacer.dart';
import '../../../auth/controller/auth_cubit.dart';
import '../../../auth/view/screens/change_password_screen.dart';
import '../../../auth/view/screens/user_profile_view.dart';
import 'clicked_option_widget.dart';
import 'drawer_list_of_menu_header.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Image.asset(
              AssetsPathConstants.kBlueLogoPath,
              scale: 1.4,
            ),
          ),
          const DrawerListOfMenuHeader(
            icon: Iconsax.setting,
            title: "Settings",
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                ClickedOptionWidget(
                  optionName: "Change Password",
                  onTap: () {
                    Get.to(() => ChangePasswordScreen());
                  },
                ),
                VerticalSpacer(12.h),
                ClickedOptionWidget(
                  optionName: "Forget Password",
                  onTap: () async {
                    await launchUrl(
                      Uri.parse(
                        ApiConstants.resetPasswordURL,
                      ),
                    );
                  },
                ),
                VerticalSpacer(12.h),
              ],
            ),
          ),
          VerticalSpacer(25.h),
          const DrawerListOfMenuHeader(
            icon: Iconsax.more,
            title: "More",
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                ClickedOptionWidget(
                  optionName: "My Profile",
                  onTap: () {
                    Get.to(() =>  UserProfileView());
                  },
                ),
                VerticalSpacer(12.h),
              ],
            ),
          ),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: EasyButton(
              idleStateWidget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Logout'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const HorizontalSpacer(5),
                  const Icon(
                    Iconsax.logout,
                    color: Colors.white,
                  )
                ],
              ),
              loadingStateWidget: const CircularProgressIndicator(
                strokeWidth: 3.0,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white,
                ),
              ),
              useWidthAnimation: true,
              useEqualLoadingStateWidgetDimension: true,
              width: MediaQuery.of(context).size.width * 0.6,
              height: 40.h,
              contentGap: 6.0,
              buttonColor: UiConstant.kCosmoCareCustomColors1,
              borderRadius: 10,
              onPressed: () async {
                context.read<AuthCubit>().logOut(context: context);
              },
            ),
          )
        ],
      ),
    );
  }
}
