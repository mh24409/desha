import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/widget/flutter_single_select.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/Constants/ui_constants.dart';
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
  AddResponsibleScreen({Key? key, required this.customerData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add New Responsible",
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                CustomTextField(
                  prefixIconData: Iconsax.user,
                  hintText: "Responsible Name",
                  onChange: (value) {
                    responsibleData.name = value;
                  },
                ),
                const VerticalSpacer(10),
                CustomTextField(
                  prefixIconData: Iconsax.mobile,
                  hintText: "Phone number",
                  onChange: (value) {
                    responsibleData.phoneNumber = value;
                  },
                ),
                const VerticalSpacer(10),
                CustomTextField(
                  prefixIconData: Icons.email,
                  hintText: "Email",
                  onChange: (value) {
                    responsibleData.email = value;
                  },
                ),
                const VerticalSpacer(10),
                CustomSingleSelectField<String>(
                  items: CustomersController.daysData,
                  title: "Work Start Day",
                  onSelectionDone: (value) async {
                    responsibleData.workStartDay = value;
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
                    responsibleData.workEndDay = value;
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
                    responsibleData.workStartTime = value;
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
                    responsibleData.workEndTime = value;
                  },
                  itemAsString: (item) => item,
                  decoration: selectionFiledDecoration(hintText: "Work End At"),
                ),
                const VerticalSpacer(10),
                CustomButton(
                  buttonColor: UiConstant.kCosmoCareCustomColors1,
                  buttonHeight: 40.h,
                  buttonText: "Next",
                  buttonWidth: MediaQuery.of(context).size.width / 2,
                  buttonAction: () async {
                    await Get.to(() => AddOwnerScreen(
                          customerData: customerData,
                          responsibleData: responsibleData,
                        ));
                  },
                  buttonMargin: 10,
                  buttonTextFontSize: 14.sp,
                  buttonBorderRadius: 10,
                ),
              ],
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
