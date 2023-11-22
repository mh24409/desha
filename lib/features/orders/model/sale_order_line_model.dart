class SaleOrderLineModel {
  int productId;
  String productName;
  String description;
  double unitPrice;
  dynamic discount;
  dynamic discountTwo;
  double productUomQty;
  double qtyDelivered;
  double qtyInvoiced;
  double subTotalPrice;

  SaleOrderLineModel({
    required this.productId,
    required this.productName,
    required this.description,
    required this.discount,
    required this.discountTwo,
    required this.subTotalPrice,
    required this.unitPrice,
    required this.productUomQty,
    required this.qtyDelivered,
    required this.qtyInvoiced

  });

   factory SaleOrderLineModel.fromJson(Map<String, dynamic> json) {
    return SaleOrderLineModel(
      productId: json["product_id"],
      productName: json["product_name"],
      description: json["description"],
      discount: json["discount"],
      discountTwo: json["discount_two"],
      productUomQty: json["product_uom_qty"],
      qtyDelivered: json["qty_delivered"],
      qtyInvoiced: json["qty_invoiced"],
      subTotalPrice: json["price_subtotal"],
      unitPrice: json["price_unit"]
    );
  }
}
