class ProductsModel {
  int id;
  String title;
  dynamic details;
  dynamic code;
  dynamic imageURL;
  double price;
  dynamic category;
  double availableQuantity;

  ProductsModel(
      {required this.id,
      required this.title,
      required this.details,
      required this.code,
      required this.price,
      required this.category,
      required this.availableQuantity,
      required this.imageURL});

  factory ProductsModel.fromJson(Map<dynamic, dynamic> json) {
    return ProductsModel(
      id: json['product_id'],
      title: json['title'],
      imageURL: json['image'] == false ? "" : json['image'],
      price: json['price_before_tax'],
      details: json['details'] == false ? "" : json['details'],
      availableQuantity: json['qty_available'],
      code: json['product_code'] == false ? "" : json['product_code'],
      category: json['category'] == false ? "" : json['category'],
    );
  }
}
