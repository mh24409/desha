import 'package:cosmo_care/core/widgets/widgets/custom_button_widget.dart';
import 'package:cosmo_care/core/widgets/widgets/custom_text_field.dart';
import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/widget/flutter_single_select.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/Constants/ui_constants.dart';
import '../../../../core/shared/methods/auth_validation.dart';
import '../../../../core/widgets/widgets/horizontal_spacer.dart';
import '../../../../core/widgets/widgets/vertical_spacer.dart';
import '../../controller/order_controller.dart';
import '../../model/customer_products_model.dart';
import '../widgets/product_offers_bottom_sheet_body.dart';
import '../widgets/product_offers_bottom_sheet_header.dart';
import '../widgets/selected_product_details_card.dart';

// ignore: must_be_immutable
class SaleOrderLineScreen extends StatefulWidget {
  int invoiceId;
  List<CustomerProductsModel> offers;
  SaleOrderLineScreen({
    Key? key,
    required this.invoiceId,
    required this.offers,
  }) : super(key: key);

  @override
  State<SaleOrderLineScreen> createState() => _SaleOrderLineScreenState();
}

class _SaleOrderLineScreenState extends State<SaleOrderLineScreen> {
  double total = 0;
  List<CustomerProductsModel> saleOrderLineProducts = [];
  CustomerProductsModel? selectedProduct;
  TextEditingController quantityController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sale Order Lines".tr),
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
                    Text("Total".tr),
                    Text(
                      total.toString(),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) {
                return SelectedProductDetailsCard(
                  selectedProduct: saleOrderLineProducts[index],
                  buttonAction: () {
                    setState(() {
                      saleOrderLineProducts.removeAt(index);
                      total = 0;
                      for (var product in saleOrderLineProducts) {
                        total = total + product.total;
                      }
                    });
                  },
                );
              },
              itemCount: saleOrderLineProducts.length,
            )),
            VerticalSpacer(10.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomSingleSelectField<String>(
                items: widget.offers.map((e) => e.title).toList(),
                title: "Product Name".tr,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Product is required".tr;
                  }
                  return null;
                },
                onSelectionDone: (value) {
                  for (var item in widget.offers) {
                    if (item.title == value) {
                      selectedProduct = item;
                      if (item.offers.isNotEmpty) {
                        showProductOffers(context, item);
                      }
                    }
                  }
                },
                itemAsString: (item) => item,
                decoration:
                    selectionFiledDecoration(hintText: "Product Name".tr),
              ),
            ),
            VerticalSpacer(10.h),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: quantityController,
                        prefixIconData: Icons.format_list_numbered,
                        hintText: "Quantity".tr,
                        keyboardType: TextInputType.number,
                        validate: (value) {
                          return quantityControllerValidator(value);
                        },
                        onChange: (value) {
                          if (selectedProduct != null) {
                            selectedProduct!.quantity = value;
                          } else {
                            Get.snackbar("Select Product At first".tr, "");
                          }
                        },
                      ),
                    ),
                    HorizontalSpacer(10.w),
                    Expanded(
                      child: CustomButton(
                        buttonWidth: MediaQuery.of(context).size.width * 0.4,
                        buttonHeight: 45.h,
                        buttonMargin: 0,
                        buttonTextFontSize: 14,
                        buttonText: "Add".tr,
                        buttonBorderRadius: 10,
                        buttonAction: () {
                          if (formKey.currentState!.validate()) {
                            if (saleOrderLineProducts.any((product) =>
                                product.productId ==
                                selectedProduct!.productId)) {
                              Get.snackbar(
                                "this product already added".tr,
                                "",
                                backgroundColor: Colors.blue,
                              );
                            } else {
                              setState(() {
                                selectedProduct!.total = (selectedProduct!
                                            .price *
                                        int.parse(selectedProduct!.quantity)) -
                                    selectedProduct!.discountAmount;
                                saleOrderLineProducts.add(selectedProduct!);
                                quantityController.clear();
                                total = 0;
                                for (var product in saleOrderLineProducts) {
                                  total = total + product.total;
                                }
                              });
                            }
                          }
                        },
                        buttonColor: UiConstant.kCosmoCareCustomColors1,
                      ),
                    ),
                  ],
                ),
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
                onPressed: () async {
                  await OrderController.createSaleOrderLines(
                    invoiceId: widget.invoiceId,
                    products: saleOrderLineProducts,
                  );
                },
              ),
            ),
            VerticalSpacer(20.h),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showProductOffers(
      BuildContext context, CustomerProductsModel item) {
    return Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Column(
          children: [
            const ProductOffersBottomSheetHeader(),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ProductOffersBottomSheetBody(
                    offersModel: item.offers[index],
                  );
                },
                itemCount: item.offers.length,
              ),
            )
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
