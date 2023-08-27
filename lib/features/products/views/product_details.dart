import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/Constants/assets_path_constants.dart';
import '../../../core/Constants/ui_constants.dart';
import '../model/product_model.dart';

// ignore: must_be_immutable
class ProductDetails extends StatelessWidget {
  ProductsModel product;
  ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CosmoCare".tr,
          style: TextStyle(color: Colors.black, fontSize: 24.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 1.5,
                height: MediaQuery.of(context).size.height * 0.45,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ConditionalBuilder(
                  condition: product.imageURL != "",
                  builder: (context) => Image.asset(
                    AssetsPathConstants.kProductPlaceholder,
                    fit: BoxFit.fill,
                  ),
                  fallback: (context) => Image.asset(
                    AssetsPathConstants.kProductPlaceholder,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                product.title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  Text(
                    "${product.price.toString()} EG",
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: const Color(0xff03283F),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ConditionalBuilder(
                    condition: product.code != false,
                    builder: (context) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        decoration: BoxDecoration(
                            color: UiConstant.kCosmoCareCustomColors1,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              product.code,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    fallback: (context) => Container(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: ConditionalBuilder(
                condition: product.details != false,
                builder: (context) => Text(product.details),
                fallback: (context) => Container(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  Text(
                    "Available Quantity",
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                  Text(
                    ": ${product.availableQuantity}",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
