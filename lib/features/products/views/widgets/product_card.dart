
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../../core/Constants/assets_path_constants.dart';
import '../product_details_view.dart';



class ProductCard extends StatelessWidget {
  final Map product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object> customerImage;
    customerImage = AssetImage(AssetsPathConstants.kProductPlaceholder);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(product: product),
          ),
        );
      },
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 6,
                offset: Offset(0.0, 5),
              ),
            ],
            color: Color(0xffF9F6F6),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: customerImage,
                height: 90,
                width: 90,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 10,
              ),
              Text(product['title']),
              SizedBox(
                height: 10,
              ),
              Text('${product['qty_available'].toInt().toString()} Pieces')
            ],
          ),
        ),
      ),
    );
  }
}