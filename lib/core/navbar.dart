// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app_release2/constants.dart';
import 'package:app_release2/core/utils/assets.dart';
import 'package:app_release2/features/customer/views/customers_view.dart';
import 'package:app_release2/features/map/views/map_view.dart';
import 'package:app_release2/features/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyNavigationBar extends StatefulWidget {
  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    ProfileView(),
    PageTwo(),
    CustomerView(),
    Maps(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'account'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.production_quantity_limits),
            label: 'products'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: 'customers'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'map'.tr,
          ),
        ],
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.blue,
        selectedItemColor: KThemeColor,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}


class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page 2'),
    );
  }
}



class PageFour extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page 4'),
    );
  }
}
