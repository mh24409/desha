// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

import '../../../core/Constants/assets_path_constants.dart';


class ProductDetail extends StatelessWidget {
  final Map product;

  ProductDetail({required this.product});

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object> customerImage;
    customerImage = AssetImage(AssetsPathConstants.kProductPlaceholder);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1.0,
        title: Text(
          'Product Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Card(
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
                child: Center(
                  child: Image(
                    image: customerImage,
                    height: 150,
                    width: 150,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(product['title']),
            SizedBox(
              height: 10,
            ),
            Text('Brand: ${product['brand']}'),
            SizedBox(
              height: 10,
            ),
            Text('Code:  ${product['product_code']}'),
            SizedBox(
              height: 10,
            ),
            Text('Price: ${product['price_before_tax']}'),
            SizedBox(
              height: 10,
            ),
            Text('${product['qty_available'].toInt().toString()} Pieces')
          ],
        ),
      ),
    );
  }
}
