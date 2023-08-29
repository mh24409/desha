import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/Constants/ui_constants.dart';
import '../../../../core/widgets/widgets/horizontal_spacer.dart';

class ProductOffersBottomSheetHeader extends StatelessWidget {
  const ProductOffersBottomSheetHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: UiConstant.kCosmoCareCustomColors1,
          height: 40.h,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                 Text(
                  "Available offers for this product".tr,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 40.h,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              children:  [
                Expanded(
                  flex: 3,
                  child: Text(
                    "Product".tr,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Quantity".tr,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "Bonus".tr,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
