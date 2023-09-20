import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/widget/flutter_single_select.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/Constants/ui_constants.dart';
import '../../../../core/shared/methods/auth_validation.dart';
import '../../../../core/widgets/widgets/custom_button_widget.dart';
import '../../../../core/widgets/widgets/custom_text_field.dart';
import '../../../../core/widgets/widgets/vertical_spacer.dart';
import '../../controller/customers_controller.dart';
import '../../model/create_customer_modeling.dart';
import 'add_owner_screen.dart';

// ignore: must_be_immutable
class AddResponsibleScreen extends StatelessWidget {
  CustomerData customerData;
  ResponsibleData responsibleData = ResponsibleData();
  GlobalKey<FormState> formKey = GlobalKey();
  AddResponsibleScreen({Key? key, required this.customerData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add New Responsible".tr,
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    prefixIconData: Iconsax.user,
                    hintText: "Responsible Name".tr,
                    onChange: (value) {
                      responsibleData.name = value;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validate: (value) {
                      return responsibleNameControllerValidator(value);
                    },
                  ),
                  const VerticalSpacer(10),
                  CustomTextField(
                    prefixIconData: Iconsax.mobile,
                    hintText: "Phone Number".tr,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChange: (value) {
                      responsibleData.phoneNumber = value;
                    },
                    validate: (value) {
                      return phoneNumberControllerValidator(value);
                    },
                  ),
                  const VerticalSpacer(10),
                  CustomTextField(
                    prefixIconData: Icons.email,
                    hintText: "Email".tr,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChange: (value) {
                      responsibleData.email = value;
                    },
                    validate: (value) {
                      return emailControllerValidator(value);
                    },
                  ),
                  const VerticalSpacer(10),
                  CustomSingleSelectField<String>(
                    items: CustomersController.daysData,
                    title: "Work Start Day".tr,
                    onSelectionDone: (value) async {
                      responsibleData.workStartDay = value;
                    },
                    itemAsString: (item) => item,
                    decoration:
                        selectionFiledDecoration(hintText: "Work Start Day".tr),
                  ),
                  const VerticalSpacer(10),
                  CustomSingleSelectField<String>(
                    items: CustomersController.daysData,
                    title: "Work End Day".tr,
                    onSelectionDone: (value) async {
                      responsibleData.workEndDay = value;
                    },
                    itemAsString: (item) => item,
                    decoration:
                        selectionFiledDecoration(hintText: "Work End Day".tr),
                  ),
                  const VerticalSpacer(10),
                  CustomSingleSelectField<String>(
                    items: CustomersController.timeList,
                    title: "Work Start At".tr,
                    onSelectionDone: (value) async {
                      responsibleData.workStartTime = value;
                    },
                    itemAsString: (item) => item,
                    decoration:
                        selectionFiledDecoration(hintText: "Work Start At".tr),
                  ),
                  const VerticalSpacer(10),
                  CustomSingleSelectField<String>(
                    items: CustomersController.timeList,
                    title: "Work End At".tr,
                    onSelectionDone: (value) async {
                      responsibleData.workEndTime = value;
                    },
                    itemAsString: (item) => item,
                    decoration:
                        selectionFiledDecoration(hintText: "Work End At".tr),
                  ),
                  const VerticalSpacer(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        buttonColor: UiConstant.kCosmoCareCustomColors1,
                        buttonHeight: 40.h,
                        buttonText: "Skip".tr,
                        buttonWidth: MediaQuery.of(context).size.width / 2.5,
                        buttonAction: () async {
                          await Get.to(() => AddOwnerScreen(
                                customerData: customerData,
                                responsibleData: null,
                              ));
                        },
                        buttonMargin: 10,
                        buttonTextFontSize: 14.sp,
                        buttonBorderRadius: 10,
                      ),
                      CustomButton(
                        buttonColor: UiConstant.kCosmoCareCustomColors1,
                        buttonHeight: 40.h,
                        buttonText: "Next".tr,
                        buttonWidth: MediaQuery.of(context).size.width / 2.5,
                        buttonAction: () async {
                          if (formKey.currentState!.validate()) {
                            await Get.to(
                              () => AddOwnerScreen(
                                customerData: customerData,
                                responsibleData: responsibleData,
                              ),
                            );
                          }
                        },
                        buttonMargin: 10,
                        buttonTextFontSize: 14.sp,
                        buttonBorderRadius: 10,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  selectionFiledDecoration({required hintText}) {
    return InputDecoration(
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: UiConstant.kCosmoCareCustomColors1,
          style: BorderStyle.solid,
        ),
      ),
      contentPadding: const EdgeInsets.all(15),
      hintText: hintText,
    );
  }
}
