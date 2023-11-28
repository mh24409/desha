import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/Constants/ui_constants.dart';
import '../../model/offers_model.dart';

// ignore: must_be_immutable
class ProductOffersBottomSheetBody extends StatelessWidget {
  OffersModel offersModel;
  ProductOffersBottomSheetBody({Key? key, required this.offersModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  offersModel.bonusProducts.toString(),
                  style: TextStyle(fontSize: 12.sp),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  offersModel.extraDiscount.toString(),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "${offersModel.amount.toString()} ${"to".tr} ${offersModel.amountTo.toString()}",
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  offersModel.bonusAmount.toString(),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
        const Divider(
          color: UiConstant.kCosmoCareCustomColors1,
        )
      ],
    );
  }
}
