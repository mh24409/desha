import 'package:cosmo_care/core/widgets/widgets/vertical_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../model/sale_order_model.dart';
import '../widgets/order_one_info.dart';

class SaleOrderFullDetails extends StatelessWidget {
  final SaleOrderModel order;
  const SaleOrderFullDetails({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          order.orderName,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(order.orderStatus),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            OrderOneInfoInLine(
              propName: "Item Count".tr,
              value: order.itemCount.toString(),
            ),
            OrderOneInfoInLine(
              propName: "Untaxed Amount".tr,
              value: order.amountUntaxed.toString(),
            ),
            OrderOneInfoInLine(
              propName: "Taxes".tr,
              value: order.taxes.toString(),
              hasDivider: false,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade200,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Text("Order Product Lines"),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.65,
              child: CarouselSlider.builder(
                itemCount: order.orderLines.length,
                slideBuilder: (position) {
                  return ListView(
                    children: [
                      OrderOneInfoInLine(
                        propName: "Product".tr,
                        value:
                            order.orderLines[position].productName,
                      ),
                      OrderOneInfoInLine(
                        propName: "Description".tr,
                        value:
                            order.orderLines[position].description,
                      ),
                      OrderOneInfoInLine(
                        propName: "Delivered Quantity".tr,
                        value: order.orderLines[position].qtyDelivered
                            .toString(),
                      ),
                      OrderOneInfoInLine(
                        propName: "Invoice Quantity".tr,
                        value: order.orderLines[position].qtyInvoiced
                            .toString(),
                      ),
                      OrderOneInfoInLine(
                        propName: "Price".tr,
                        value: order.orderLines[position].unitPrice
                            .toString(),
                      ),
                      OrderOneInfoInLine(
                        propName: "Discount 1".tr,
                        value: order.orderLines[position].discount
                            .toString(),
                      ),
                      OrderOneInfoInLine(
                        propName: "Discount 2".tr,
                        value: order.orderLines[position].discountTwo
                            .toString(),
                      ),
                      OrderOneInfoInLine(
                        propName: "Sub Total".tr,
                        value: order.orderLines[position].subTotalPrice
                            .toString(),
                      ),
                      VerticalSpacer(15.h)
                    ],
                  );
                },
                slideTransform: const CubeTransform(),
                slideIndicator: CircularSlideIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
