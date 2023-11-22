import 'package:cosmo_care/features/orders/model/sale_order_line_model.dart';

class SaleOrderModel {
  int orderId;
  String orderName;
  int customerId;
  String customerName;
  String orderStatus;
  int itemCount;
  double total;
  double taxes;
  double amountUntaxed;
  List<SaleOrderLineModel> orderLines;

  SaleOrderModel(
      {required this.orderId,
      required this.orderName,
      required this.customerId,
      required this.amountUntaxed,
      required this.customerName,
      required this.itemCount,
      required this.orderStatus,
      required this.taxes,
      required this.total,
      required this.orderLines});

  factory SaleOrderModel.fromJson(Map<String, dynamic> json) {
    List<SaleOrderLineModel> orderLines = [];
    for (var line in json['order_lines']) {
      orderLines.add(SaleOrderLineModel.fromJson(line));
    }
    return SaleOrderModel(
      orderId: json["order_id"],
      orderName: json["order_name"],
      customerId: json["customer_id"],
      customerName: json["customer_name"],
      itemCount: json["item_count"],
      amountUntaxed: json["amount_untaxed"],
      orderStatus: json["status"],
      taxes: json["taxes"],
      total: json["total"],
      orderLines: orderLines,
    );
  }
}
