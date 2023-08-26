import '../model/customer_model.dart';

abstract class GetAllCustomersStates {}

class GetAllCustomersInitState extends GetAllCustomersStates {}

class GetAllCustomersLoadingState extends GetAllCustomersStates {}

class GetAllCustomersSuccessState extends GetAllCustomersStates {
  List<CustomerModel> customers;
  GetAllCustomersSuccessState({
    required this.customers
  });
}

class GetAllCustomersFailedState extends GetAllCustomersStates {}
