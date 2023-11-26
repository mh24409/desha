import 'package:cosmo_care/core/widgets/widgets/vertical_spacer.dart';
import 'package:cosmo_care/features/auth/controller/user_cubit.dart';
import 'package:cosmo_care/features/auth/controller/user_states.dart';
import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/Constants/ui_constants.dart';
import '../../../../core/widgets/widgets/horizontal_spacer.dart';
import '../../controller/auth_cubit.dart';
import '../widgets/profile_card.dart';
import '../widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: BlocBuilder<UserCubit, UserStates>(
          builder: (context, state) {
            if (state is UserSuccessState) {
              return Column(
                children: [
                  Flexible(
                    flex: 10,
                    child: ProfileHeader(
                      userName: state.currentUser.userName!,
                    ),
                  ),
                  Flexible(child: VerticalSpacer(20.h)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ProfileCard(
                      cardName: "User Name".tr,
                      cardValue: state.currentUser.userName!,
                    ),
                  ),
                  Flexible(child: VerticalSpacer(20.h)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ProfileCard(
                      cardName: "User Email".tr,
                      cardValue: state.currentUser.email!,
                    ),
                  ),
                 
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
