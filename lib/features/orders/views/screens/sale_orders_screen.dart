import 'package:cosmo_care/core/Constants/ui_constants.dart';
import 'package:cosmo_care/core/widgets/widgets/vertical_spacer.dart';
import 'package:cosmo_care/features/orders/controller/cubit/user_sale_orders_state.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../controller/cubit/user_sale_orders_cubit.dart';
import '../widgets/order_one_info.dart';

class SaleOrdersScreen extends StatelessWidget {
  const SaleOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildSaleOrdersViewHeader(context),
        Expanded(
          child: BlocBuilder<UserSaleOrdersCubit, UserSaleOrdersState>(
            builder: (context, state) {
              if (state is UserSaleOrdersLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: UiConstant.kCosmoCareCustomColors1,
                  ),
                );
              } else if (state is UserSaleOrdersSuccess) {
                if (state.orders.isNotEmpty) {
                  return ListView.separated(
                    separatorBuilder: (context, index) => VerticalSpacer(12.h),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: UiConstant.kCosmoCareCustomColors1,
                                blurRadius: 10,
                                offset:  Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: ExpandablePanel(
                              header: Column(
                                children: [
                                  OrderOneInfoInLine(
                                    propName: "Order Name".tr,
                                    value: state.orders[index].orderName,
                                  ),
                                  OrderOneInfoInLine(
                                    propName: "Customer Name".tr,
                                    value: state.orders[index].customerName,
                                  ),
                                  OrderOneInfoInLine(
                                    propName: "Total Price".tr,
                                    value: state.orders[index].total.toString(),
                                  ),
                                ],
                              ),
                              collapsed: const SizedBox.shrink(),
                              expanded: Column(
                                children: [
                                  OrderOneInfoInLine(
                                    propName: "Order State".tr,
                                    value: state.orders[index].orderStatus,
                                  ),
                                  OrderOneInfoInLine(
                                    propName: "Item Count".tr,
                                    value:
                                        state.orders[index].itemCount.toString(),
                                  ),
                                  OrderOneInfoInLine(
                                    propName: "Untaxed Amount".tr,
                                    value: state.orders[index].amountUntaxed
                                        .toString(),
                                  ),
                                  OrderOneInfoInLine(
                                    propName: "Taxes".tr,
                                    value: state.orders[index].taxes.toString(),
                                  ),
                                  SizedBox(
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    child: CarouselSlider.builder(
                                      itemCount:
                                          state.orders[index].orderLines.length,
                                      slideBuilder: (position) {
                                        return ListView(
                                          children: [
                                            OrderOneInfoInLine(
                                              propName: "Product".tr,
                                              value: state
                                                  .orders[index]
                                                  .orderLines[position]
                                                  .productName,
                                            ),
                                            OrderOneInfoInLine(
                                              propName: "Description".tr,
                                              value: state
                                                  .orders[index]
                                                  .orderLines[position]
                                                  .description,
                                            ),
                                            OrderOneInfoInLine(
                                              propName: "Delivered Quantity".tr,
                                              value: state
                                                  .orders[index]
                                                  .orderLines[position]
                                                  .qtyDelivered
                                                  .toString(),
                                            ),
                                            OrderOneInfoInLine(
                                              propName: "Invoice Quantity".tr,
                                              value: state
                                                  .orders[index]
                                                  .orderLines[position]
                                                  .qtyInvoiced
                                                  .toString(),
                                            ),
                                            OrderOneInfoInLine(
                                              propName: "Price".tr,
                                              value: state.orders[index]
                                                  .orderLines[position].unitPrice
                                                  .toString(),
                                            ),
                                            OrderOneInfoInLine(
                                              propName: "Discount 1".tr,
                                              value: state.orders[index]
                                                  .orderLines[position].discount
                                                  .toString(),
                                            ),
                                            OrderOneInfoInLine(
                                              propName: "Discount 2".tr,
                                              value: state
                                                  .orders[index]
                                                  .orderLines[position]
                                                  .discountTwo
                                                  .toString(),
                                            ),
                                            OrderOneInfoInLine(
                                              propName: "Sub Total".tr,
                                              value: state
                                                  .orders[index]
                                                  .orderLines[position]
                                                  .subTotalPrice
                                                  .toString(),
                                            ),
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
                          ),
                        ),
                      );
                    },
                    itemCount: state.orders.length,
                  );
                } else {
                  return Center(
                      child:
                          Text("You didn't create any sale order till now".tr));
                }
              } else {
                return Center(
                    child: Text('Something went wrong please try agin'.tr));
              }
            },
          ),
        )
      ],
    );
  }

  Container buildSaleOrdersViewHeader(BuildContext context) {
    return Container(
      color: UiConstant.kCosmoCareCustomColors1,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.05,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "My Sale Orders",
              style: TextStyle(color: Colors.white, fontSize: 18.sp),
            ),
            GestureDetector(
              onTap: () async {},
              child: const Icon(
                Iconsax.refresh,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
