import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/widget/flutter_single_select.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/Constants/ui_constants.dart';
import '../../../../core/shared/methods/auth_validation.dart';
import '../../../../core/widgets/widgets/custom_text_field.dart';
import '../../../../core/widgets/widgets/vertical_spacer.dart';
import '../../controller/customers_controller.dart';
import '../../model/create_customer_modeling.dart';

// ignore: must_be_immutable
class AddOwnerScreen extends StatelessWidget {
  CustomerData customerData;
  ResponsibleData? responsibleData;
  OwnerData ownerData = OwnerData();
  GlobalKey<FormState> formKey = GlobalKey();

  AddOwnerScreen(
      {Key? key, required this.customerData, required this.responsibleData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add New Owner",
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
                    hintText: "Owner Name",
                    onChange: (value) {
                      ownerData.name = value;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validate: (value) {
                      return ownerNameControllerValidator(value);
                    },
                  ),
                  const VerticalSpacer(10),
                  CustomTextField(
                    prefixIconData: Iconsax.mobile,
                    hintText: "Owner number",
                    onChange: (value) {
                      ownerData.phoneNumber = value;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validate: (value) {
                      return phoneNumberControllerValidator(value);
                    },
                  ),
                  const VerticalSpacer(10),
                  CustomTextField(
                    prefixIconData: Icons.email,
                    hintText: "Owner Email",
                    onChange: (value) {
                      ownerData.email = value;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validate: (value) {
                      return emailControllerValidator(value);
                    },
                  ),
                  const VerticalSpacer(10),
                  CustomSingleSelectField<String>(
                    items: CustomersController.daysData,
                    title: "Work Start Day",
                    onSelectionDone: (value) async {
                      ownerData.workStartDay = value;
                    },
                    itemAsString: (item) => item,
                    decoration:
                        selectionFiledDecoration(hintText: "Work Start Day"),
                  ),
                  const VerticalSpacer(10),
                  CustomSingleSelectField<String>(
                    items: CustomersController.daysData,
                    title: "Work End Day",
                    onSelectionDone: (value) async {
                      ownerData.workEndDay = value;
                    },
                    itemAsString: (item) => item,
                    decoration:
                        selectionFiledDecoration(hintText: " Work End Day"),
                  ),
                  const VerticalSpacer(10),
                  CustomSingleSelectField<String>(
                    items: CustomersController.timeList,
                    title: "Work Start At",
                    onSelectionDone: (value) async {
                      ownerData.workStartTime = value;
                    },
                    itemAsString: (item) => item,
                    decoration:
                        selectionFiledDecoration(hintText: "Work Start At"),
                  ),
                  const VerticalSpacer(10),
                  CustomSingleSelectField<String>(
                    items: CustomersController.timeList,
                    title: "Work End At",
                    onSelectionDone: (value) async {
                      ownerData.workEndTime = value;
                    },
                    itemAsString: (item) => item,
                    decoration:
                        selectionFiledDecoration(hintText: "Work End At"),
                  ),
                  VerticalSpacer(30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      EasyButton(
                        idleStateWidget: Text(
                          'Skip & Create'.tr,
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
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 45.h,
                        contentGap: 6.0,
                        buttonColor: UiConstant.kCosmoCareCustomColors1,
                        borderRadius: 10,
                        onPressed: () async {
                          await CustomersController.createCustomer(
                              customerData: customerData,
                              ownerData: null,
                              responsibleData: responsibleData);
                        },
                      ),
                      EasyButton(
                        idleStateWidget: Text(
                          'Create'.tr,
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
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 45.h,
                        contentGap: 6.0,
                        buttonColor: UiConstant.kCosmoCareCustomColors1,
                        borderRadius: 10,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await CustomersController.createCustomer(
                              customerData: customerData,
                              ownerData: ownerData,
                              responsibleData: responsibleData,
                            );
                          }
                        },
                      ),
                    ],
                  )
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
