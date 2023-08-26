import 'package:cosmo_care/core/Constants/ui_constants.dart';
import 'package:cosmo_care/core/widgets/widgets/horizontal_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/Constants/assets_path_constants.dart';
import '../../model/customer_model.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../screens/customer_details_screen.dart';

class CustomerCard extends StatelessWidget {
  final CustomerModel customer;
  const CustomerCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        FocusManager.instance.primaryFocus!.unfocus();
        await Future.delayed(const Duration(milliseconds: 200));
        Get.to(() => CustomerDetailsScreen(customer: customer));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            height: MediaQuery.of(context).size.width / 3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color(0xffF8F5F5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ConditionalBuilder(
                    condition:
                        customer.image != null && customer.image!.isNotEmpty,
                    builder: (context) => Image(
                      image: NetworkImage(customer.image!),
                      height: 80.h,
                      width: 80.w,
                      fit: BoxFit.cover,
                    ),
                    fallback: (context) => Image(
                      image: const AssetImage(AssetsPathConstants.kProfile),
                      height: 80.h,
                      width: 80.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                HorizontalSpacer(30.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        customer.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Iconsax.location,
                            color: UiConstant.kCosmoCareCustomColors1,
                          ),
                          HorizontalSpacer(5.w),
                          Expanded(
                            child: Text(
                              customer.address,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
