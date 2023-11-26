import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/Constants/ui_constants.dart';
import '../../../../core/shared/methods/auth_validation.dart';
import '../../../../core/shared/methods/show_image_picker.dart';
import '../../../../core/widgets/widgets/vertical_spacer.dart';
import '../../controller/user_cubit.dart';
import '../../controller/user_states.dart';
import '../widgets/edit_profile_custom_filed.dart';

// ignore: must_be_immutable
class UserProfileView extends StatelessWidget {
  static Uint8List? _image;
  static final ImagePicker _picker = ImagePicker();
  static String? img64;
  String? userName;
  String? phoneNumber;
  String? email;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UserProfileView({Key? key}) : super(key: key);

  Future<void> _imgFromCamera(context) async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    UserProfileView._image = File(image!.path).readAsBytesSync();
    UserProfileView.img64 = base64Encode(_image!);
    await BlocProvider.of<UserCubit>(context).editImage(UserProfileView.img64);
  }

  Future<void> _imgFromGallery(context) async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    UserProfileView._image = File(image!.path).readAsBytesSync();
    UserProfileView.img64 = base64Encode(_image!);
    await BlocProvider.of<UserCubit>(context).editImage(UserProfileView.img64);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<UserCubit, UserStates>(
        builder: (context, state) {
          if (state is UserSuccessState) {
            return Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ConditionalBuilder(
                            condition: state.currentUser.userImage == "" ||
                                state.currentUser.userImage == null,
                            builder: (context) {
                              return CircleAvatar(
                                backgroundColor:
                                    UiConstant.kCosmoCareCustomColors1,
                                radius: MediaQuery.of(context).size.width / 4,
                                child: Icon(
                                  Iconsax.user,
                                  size: 70.w,
                                ),
                              );
                            },
                            fallback: (context) {
                              return CircleAvatar(
                                radius: MediaQuery.of(context).size.width / 4,
                                backgroundImage: NetworkImage(
                                  "${state.currentUser.userImage!}?v=${Random().nextInt(100)}",
                                ),
                              );
                            },
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                showImagesPickers(
                                  context,
                                  onTapCamera: () async {
                                    Navigator.of(context).pop();
                                    await _imgFromCamera(context);
                                    imageCache.clear();
                                  },
                                  onTapGallery: () async {
                                    imageCache.clear();
                                    Navigator.of(context).pop();
                                    await _imgFromGallery(context);
                                  },
                                );
                              },
                              child: const Icon(
                                Iconsax.edit,
                              ),
                            ),
                          )
                        ],
                      ),
                      const VerticalSpacer(10),
                      Text(
                        state.currentUser.userName!,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      const Divider(),
                      const VerticalSpacer(20),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 25),
                            child: EditProfileCustomFiled(
                              hintText: "Email".tr,
                              labelName: "Email".tr,
                              initValue: state.currentUser.email!,
                              obscureText: false,
                              onChange: (value) {
                                email = value;
                              },
                              validator: (value) {
                                return null;
                              },
                              enabled: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 25),
                            child: EditProfileCustomFiled(
                              hintText: "User Name".tr,
                              labelName: "User Name".tr,
                              initValue: state.currentUser.userName!,
                              obscureText: false,
                              onChange: (value) {
                                userName = value;
                              },
                              validator: (value) {
                                return userNameControllerValidator(value);
                              },
                              enabled: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: EasyButton(
                              idleStateWidget: Text(
                                'Update'.tr,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              loadingStateWidget:
                                  const CircularProgressIndicator(
                                strokeWidth: 3.0,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                              useWidthAnimation: true,
                              useEqualLoadingStateWidgetDimension: true,
                              width: MediaQuery.of(context).size.width / 1.5,
                              height: 40.h,
                              contentGap: 6.0,
                              buttonColor: UiConstant.kCosmoCareCustomColors1,
                              borderRadius: 10,
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  await context
                                      .read<UserCubit>()
                                      .editUserProfile(
                                        name: userName ??
                                            state.currentUser.userName!,
                                        email:
                                            email ?? state.currentUser.email!,
                                      );
                                }
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
