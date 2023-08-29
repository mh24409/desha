import 'package:cosmo_care/core/widgets/widgets/horizontal_spacer.dart';
import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/Constants/assets_path_constants.dart';
import '../../../../core/Constants/ui_constants.dart';
import '../../../../core/shared/methods/auth_validation.dart';
import '../../../../core/widgets/widgets/custom_text_field.dart';
import '../../../../core/widgets/widgets/vertical_spacer.dart';
import '../../../app_control_feature/views/screens/main_control_screen.dart';
import '../../controller/auth_cubit.dart';
import '../../controller/auth_state.dart';
import 'package:iconsax/iconsax.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) async {
          if (state is AuthLoadingState) {}
          if (state is LoginSuccessState) {
            AuthCubit.liveLocation();
            await Get.offAll(() => const MainControlScreen());
            
          }
          if (state is LoginFailureState) {
            Get.snackbar(
              "Authentication Failed".tr,
              "your email or password are not correct".tr,
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Image.asset(
                          AssetsPathConstants.kColoredLogoPath,
                          scale: 3,
                        ),
                      ),
                    ),
                    VerticalSpacer(40.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: CustomTextField(
                        prefixIconData: Iconsax.user,
                        hintText: "email".tr,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChange: (value) {
                          email = value;
                        },
                        validate: (value) {
                          return emailControllerValidator(value);
                        },
                      ),
                    ),
                    VerticalSpacer(15.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: CustomTextField(
                        prefixIconData: Iconsax.lock,
                        hintText: "password".tr,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: true,
                        onChange: (value) {
                          password = value;
                        },
                        validate: (value) {
                          return passwordControllerValidator(value);
                        },
                      ),
                    ),
                    VerticalSpacer(30.h),
                    Center(
                      child: EasyButton(
                        idleStateWidget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sign In'.tr,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            const HorizontalSpacer(5),
                            const Icon(
                              Iconsax.login_1,
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
                        height: 45.h,
                        contentGap: 6.0,
                        buttonColor: UiConstant.kCosmoCareCustomColors1,
                        borderRadius: 10,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await context
                                .read<AuthCubit>()
                                .signInWithEmailAndPassword(
                                  context,
                                  email: email!,
                                  password: password!,
                                );
                          }
                        },
                      ),
                    ),
                    VerticalSpacer(20.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
