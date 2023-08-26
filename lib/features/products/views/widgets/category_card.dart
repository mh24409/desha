// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../product_view.dart';


class CategoryCard extends StatelessWidget {
  final Map category;

  CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    // ImageProvider<Object> customerImage;
    // customerImage = AssetImage(AssetsData.productImg);
    return GestureDetector(
onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProductView(products: category['products'], categoryName: category['name']), // <-- Modify this
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
            children: <Widget>[
              // Image(
              //   image: customerImage,
              //   height: 80,
              //   width: 80,
              //   fit: BoxFit.cover,
              // ),
              // SizedBox(
              //   height: 15,
              // ),
              Center(
                  child: Text(category['name'],
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
        ),
      ),
    );
  }
}
