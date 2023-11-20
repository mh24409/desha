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

  List<CustomerModel> allFilteredCustomers = [];
  List<CustomerModel> allCustomers = [];

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
      allFilteredCustomers = customers;
      allCustomers = customers;
      emit(GetAllCustomersSuccessState(customers: customers));
     
    } catch (e) {
      Get.snackbar(
          "Connection Error".tr, "Please check your internet connection".tr,
          backgroundColor: Colors.red);
      emit(GetAllCustomersFailedState());
    }
  }

  filterCustomers(String query) {
    List<CustomerModel> filteredCustomers = allCustomers.where((customer) {
      final name = customer.title.toLowerCase();
      final queryLower = query.toLowerCase();
      return name.contains(queryLower);
    }).toList();
    allFilteredCustomers = filteredCustomers;
    emit(GetAllCustomersSuccessState(customers: filteredCustomers));
  }
}
