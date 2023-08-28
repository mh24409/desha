import 'package:cosmo_care/core/widgets/widgets/custom_button_widget.dart';
import 'package:cosmo_care/core/widgets/widgets/custom_text_field.dart';
import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/widget/flutter_single_select.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/Constants/ui_constants.dart';
import '../../../../core/widgets/widgets/horizontal_spacer.dart';
import '../../../../core/widgets/widgets/vertical_spacer.dart';
import '../../model/customer_products_model.dart';

// ignore: must_be_immutable
class SaleOrderLineScreen extends StatelessWidget {
  int invoiceId;
  int total = 0;
  List<CustomerProductsModel> offers;
  SaleOrderLineScreen({Key? key, required this.invoiceId, required this.offers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sale Order Lines"),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              color: Colors.grey.shade200,
              width: MediaQuery.of(context).size.width,
              height: 40.h,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total"),
                    Text(
                      total.toString(),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: ListView()),
            VerticalSpacer(10.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomSingleSelectField<String>(
                items: offers.map((e) => e.title).toList(),
                title: "Product Name",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Sale Zone is Required";
                  }
                  return null;
                },
                onSelectionDone: (value) {
                  for (var item in offers) {
                    if (item.title == value) {
                      if (item.offers.isNotEmpty) {
                        Get.bottomSheet(
                          Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Container(
                                  color: UiConstant.kCosmoCareCustomColors1,
                                  height: 40.h,
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: const Icon(
                                            Iconsax.close_circle,
                                            color: Colors.white,
                                          ),
                                        ),
                                        HorizontalSpacer(15.w),
                                        const Text(
                                          "Available offers for this product",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return Text(
                                          item.offers[index].bonusProducts);
                                    },
                                    itemCount: item.offers.length,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    }
                  }
                },
                itemAsString: (item) => item,
                decoration: selectionFiledDecoration(hintText: "Product Name"),
              ),
            ),
            VerticalSpacer(10.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      prefixIconData: Icons.format_list_numbered,
                      hintText: "Quantity",
                    ),
                  ),
                  HorizontalSpacer(10.w),
                  Expanded(
                    child: CustomButton(
                      buttonWidth: MediaQuery.of(context).size.width * 0.4,
                      buttonHeight: 45.h,
                      buttonMargin: 0,
                      buttonTextFontSize: 14,
                      buttonText: "Add",
                      buttonBorderRadius: 10,
                      buttonAction: () {},
                      buttonColor: UiConstant.kCosmoCareCustomColors1,
                    ),
                  ),
                ],
              ),
            ),
            VerticalSpacer(10.h),
            Center(
              child: EasyButton(
                idleStateWidget: Text(
                  'Save'.tr,
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
                width: MediaQuery.of(context).size.width * 0.6,
                height: 45.h,
                contentGap: 6.0,
                buttonColor: Colors.green,
                borderRadius: 10,
                onPressed: () async {},
              ),
            ),
            VerticalSpacer(20.h),
          ],
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
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.red,
          style: BorderStyle.solid,
        ),
      ),
      contentPadding: const EdgeInsets.all(15),
      hintText: hintText,
    );
  }
}
