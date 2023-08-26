// ignore_for_file: use_build_context_synchronously
import 'package:cosmo_care/features/auth/controller/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../app_control_feature/views/screens/main_control_screen.dart';
import '../../auth/controller/auth_cubit.dart';
import '../../auth/view/screens/login_screen.dart';
import '../widgets/cosmo_care_splash_view_widget.dart';

class CosmoCareSplashScreen extends StatelessWidget {
  const CosmoCareSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) async {
        if (state is LoginSuccessState) {
          AuthCubit.liveLocation();
          await Get.offAll(() => const MainControlScreen());
        } else if (state is LoginFailureState) {
          Get.off(() => LoginScreen());
        }
      },
      child: const CosmoCareSplashWidget(),
    );
  }
}
