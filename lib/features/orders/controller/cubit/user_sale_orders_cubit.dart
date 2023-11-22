import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cosmo_care/features/orders/controller/cubit/user_sale_orders_state.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/Constants/api_constants.dart';
import '../../../../core/helper/api_helper.dart';
import '../../model/sale_order_model.dart';

class UserSaleOrdersCubit extends Cubit<UserSaleOrdersState> {
  UserSaleOrdersCubit() : super(UserSaleOrdersInitial());

  Future<void> getCurrentUserSaleOrders() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userToken = preferences.getString("token")!;
    List<SaleOrderModel> orders = [];
    Map<String, String> headers = {"Authorization": "Bearer $userToken"};
    emit(UserSaleOrdersLoading());
    try {
      final response = await ApiHelper().get(
        url: ApiConstants.baseUrl + ApiConstants.userOrdersEndPoint,
        headers: headers,
      );
      if (response["status"] == 200) {
        for (var order in response["data"]) {
          orders.add(SaleOrderModel.fromJson(order));
        }
        emit(UserSaleOrdersSuccess(orders: orders));
      } else {
        emit(UserSaleOrdersFailed());
      }
    } catch (e) {
      Get.snackbar(
          "Connection Error".tr, "Please check your internet connection".tr,
          backgroundColor: Colors.red);
      emit(UserSaleOrdersFailed());
    }
  }
}
