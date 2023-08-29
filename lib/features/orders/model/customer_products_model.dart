import 'package:cosmo_care/features/orders/model/offers_model.dart';

class CustomerProductsModel {
  int productId;
  String title;
  dynamic details;
  dynamic productCode;
  dynamic brand;
  double priceBeforeTax;
  double price;
  double discountAmount;
  List<OffersModel> offers;
  String quantity;
  double total;

  CustomerProductsModel(
      {required this.productId,
      required this.title,
      required this.details,
      required this.productCode,
      required this.brand,
      required this.priceBeforeTax,
      required this.price,
      required this.discountAmount,
      required this.offers,
      this.quantity = '',
      this.total = 0.0
      });

  factory CustomerProductsModel.fromJson(Map<String, dynamic> json) {
    List<OffersModel> offers = List<OffersModel>.from(
        json['offers'].map((item) => OffersModel.fromJson(item)));
    return CustomerProductsModel(
        productId: json['product_id'],
        title: json['title'],
        details: json['details'],
        productCode: json['product_code'],
        brand: json['brand'],
        priceBeforeTax: json['price_before_tax'],
        price: json['price'] ?? 0.0,
        discountAmount: json['discount_amount']?? 0.0,
        offers: offers);
  }
}
