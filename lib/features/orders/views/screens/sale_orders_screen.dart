import 'package:cosmo_care/core/Constants/ui_constants.dart';
import 'package:cosmo_care/core/widgets/widgets/vertical_spacer.dart';
import 'package:cosmo_care/features/orders/controller/cubit/user_sale_orders_state.dart';
import 'package:cosmo_care/features/orders/views/screens/sale_order_full_details.dart';
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          VerticalSpacer(12.h),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(
                                () => SaleOrderFullDetails(
                                  order: state.orders[index],
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: UiConstant.kCosmoCareCustomColors1,
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Column(
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
                                      value:
                                          state.orders[index].total.toString(),
                                      hasDivider: false,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: state.orders.length,
                    ),
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
              onTap: () async {
                await BlocProvider.of<UserSaleOrdersCubit>(context)
                    .getCurrentUserSaleOrders();
              },
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
