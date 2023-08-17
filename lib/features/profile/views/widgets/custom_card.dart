// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;

  CustomCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
  decoration: BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.grey,
        blurRadius: 6,
        offset: Offset(0.0, 5),
      ),
    ],
    color: Color(0xffF9F6F6),
    borderRadius: BorderRadius.circular(9),
  ),
  height: 90,
  width: 364,
  child: Padding(
    padding: const EdgeInsets.all(12.0),
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(subtitle),
        ],
      ),
    ),
  ),
);

  }
}
