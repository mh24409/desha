import 'package:cosmo_care/features/products/model/product_model.dart';

class CategoryModel {
  int id;
  String name;
  List<ProductsModel> products;

  CategoryModel({required this.id, required this.name, required this.products});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    List<ProductsModel> products = List<ProductsModel>.from(
        json['products'].map((item) => ProductsModel.fromJson(item)));
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      products: products,
    );
  }
}
