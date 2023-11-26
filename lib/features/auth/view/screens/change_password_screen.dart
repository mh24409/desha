import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/Constants/ui_constants.dart';
import '../../../../core/shared/methods/auth_validation.dart';
import '../../../../core/widgets/widgets/custom_text_field.dart';
import '../../../../core/widgets/widgets/horizontal_spacer.dart';
import '../../../../core/widgets/widgets/vertical_spacer.dart';
import '../../controller/user_cubit.dart';

// ignore: must_be_immutable
class ChangePasswordScreen extends StatelessWidget {
  String? currentPassword;
  String? newPassword;
  String? confirmNewPassword;
  GlobalKey<FormState> formKey = GlobalKey();

  ChangePasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 40, horizontal: 25),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                        ),
                      ),
                      HorizontalSpacer(30.w),
                      Text(
                        "Change Password",
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                      height: 13.h,
                      obscureText: true,
                      prefixIconData: Iconsax.password_check,
                      hintText: "Current Password".tr,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChange: (value) {
                        currentPassword = value;
                      },
                      validate: (value) {
                        return passwordControllerValidator(value);
                      }),
                ),
                VerticalSpacer(MediaQuery.of(context).size.height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                    height: 13.h,
                    prefixIconData: Iconsax.lock,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    hintText: "New Password".tr,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChange: (value) {
                      newPassword = value;
                    },
                    validate: (value) {
                      return passwordControllerValidator(value,
                          isForLogin: false);
                    },
                  ),
                ),
                VerticalSpacer(MediaQuery.of(context).size.height * 0.03),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                    height: 13.h,
                    prefixIconData: Iconsax.lock,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    hintText: "Confirm New Password".tr,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChange: (value) {
                      confirmNewPassword = value;
                    },
                    validate: (value) {
                      return confirmPasswordControllerValidator(
                          value, newPassword);
                    },
                  ),
                ),
                VerticalSpacer(MediaQuery.of(context).size.height * 0.05),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: EasyButton(
                    idleStateWidget: Text(
                      "Update Password".tr,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    loadingStateWidget: const CircularProgressIndicator(
                      strokeWidth: 3.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                    useWidthAnimation: true,
                    useEqualLoadingStateWidgetDimension: true,
                    width: MediaQuery.of(context).size.width,
                    height: 45.h,
                    contentGap: 6.0,
                    buttonColor: UiConstant.kCosmoCareCustomColors1,
                    borderRadius: 10,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await UserCubit.changePassword(
                          newPassword: newPassword!,
                          currentPassword: currentPassword!,
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
