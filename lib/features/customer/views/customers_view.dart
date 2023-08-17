


// ignore_for_file: prefer_const_constructors

import 'package:app_release2/constants.dart';
import 'package:app_release2/features/customer/views/add_customers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomerView extends StatelessWidget {
  const CustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1.0,
        title: Center(child: Text('Customers', style: TextStyle(
          color: Colors.black
        ),)),),
        body: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              width: 485,
              height: 53,
              color: KThemeColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Our Customers',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
                ),),
              ),
            )

          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(AddCustomer());
          },
          backgroundColor: KThemeColor,
          child: Icon(Icons.add),
          ),
    );
  }
}