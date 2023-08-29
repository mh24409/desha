import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/Constants/assets_path_constants.dart';
import '../../../../core/Constants/ui_constants.dart';
import '../../../../core/widgets/widgets/custom_button_widget.dart';
import '../../model/customer_products_model.dart';

// ignore: must_be_immutable
class SelectedProductDetailsCard extends StatelessWidget {
  void Function() buttonAction;
  CustomerProductsModel selectedProduct;
  SelectedProductDetailsCard(
      {Key? key, required this.buttonAction, required this.selectedProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.2,
        color: Colors.grey.shade200,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(AssetsPathConstants.kProductPlaceholder),
                    CustomButton(
                      buttonWidth: Get.width,
                      buttonHeight: 30.h,
                      buttonBorderRadius: 0,
                      buttonMargin: 0,
                      buttonTextFontSize: 12,
                      buttonText: "delete".tr,
                      buttonAction: buttonAction,
                      buttonColor: UiConstant.kCosmoCareCustomColors1,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(selectedProduct.productCode),
                        Text("${selectedProduct.quantity} ${"pice".tr}"),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text("Price before tax".tr),
                        Text(
                          selectedProduct.priceBeforeTax.toString(),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text("price with tax".tr),
                        Text(selectedProduct.price.toString()),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text("Discount Amount".tr),
                        Text(
                          selectedProduct.discountAmount
                              .toString()
                              .substring(0, 2),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text("total".tr),
                        Text(
                          selectedProduct.total.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
