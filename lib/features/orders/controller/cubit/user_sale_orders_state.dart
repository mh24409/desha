import '../../model/sale_order_model.dart';

class UserSaleOrdersState {}

class UserSaleOrdersInitial extends UserSaleOrdersState {}

class UserSaleOrdersLoading extends UserSaleOrdersState {}

class UserSaleOrdersSuccess extends UserSaleOrdersState {
  List<SaleOrderModel> orders;
  UserSaleOrdersSuccess({
    required this.orders
  });
}

class UserSaleOrdersFailed extends UserSaleOrdersState {}
