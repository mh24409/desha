import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/Constants/api_constants.dart';
import '../../../core/helper/api_helper.dart';
import '../model/customer_model.dart';
import 'get_all_customers_states.dart';

class GetAllCustomerCubit extends Cubit<GetAllCustomersStates> {
  GetAllCustomerCubit() : super(GetAllCustomersInitState());

  Future<void> getAllCustomers() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userToken = preferences.getString("token")!;
    List<CustomerModel> customers = [];
    Map<String, String> headers = {"Authorization": "Bearer $userToken"};
    emit(GetAllCustomersLoadingState());
    try {
      final response = await ApiHelper().get(
          url: ApiConstants.baseUrl + ApiConstants.getCustomersEndPoint,
          headers: headers);
      for (var customer in response) {
        customers.add(CustomerModel.fromJson(customer));
      }
      emit(GetAllCustomersSuccessState(customers: customers));
    } catch (e) {
      Get.snackbar("Connection Error", "Please check your internet connection",
          backgroundColor: Colors.red);
      emit(GetAllCustomersFailedState());
    }
  }
}
