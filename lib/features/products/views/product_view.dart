// ignore_for_file: prefer_const_constructors
import 'package:cosmo_care/core/Constants/ui_constants.dart';
import 'package:cosmo_care/features/products/views/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductView extends StatefulWidget {
  final List products;
  final String categoryName;


  ProductView({required this.products, required this.categoryName});

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1.0,
        title: Text(
          'Products',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body:Column(
  children: [
    Container(
      width: 485,
      height: 53,
      color: UiConstant.kCosmoCareCustomColors1,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 5),
        child: Text(
          widget.categoryName,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    ),
    Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (context, index) => ProductCard(product: widget.products[index]),
        itemCount: widget.products.length,
      ),
    ),
  ],
),
    );
  }
}