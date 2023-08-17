// ignore_for_file: prefer_const_constructors

import 'package:app_release2/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AddCustomer extends StatelessWidget {
  const AddCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Customer'),
      backgroundColor: KThemeColor,),

      body: Column(
        children: [
          SizedBox(height: 15,),
        Center(child: Text('New Customer Data'))
      ]),
    );
  }
}