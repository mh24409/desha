// ignore_for_file: prefer_const_constructors

import 'package:cosmo_care/core/Constants/ui_constants.dart';
import 'package:cosmo_care/features/products/views/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryView extends StatefulWidget {
  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List categories = [];
  bool isLoading = true;
  bool hasError = false;
  String errorMessage = '';

  final String apiUrl =
      'https://cosmocareprod-training.technotown.technology/products_categorized';

  Future<void> fetchCategories() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token")!;
    try {
      final response = await http.get(Uri.parse(apiUrl), headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        setState(() {
          categories = json.decode(response.body)['data'];
          isLoading = false; // Set flag to false once data is fetched
        });
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        hasError = true;
        errorMessage = error.toString();
      });
      throw error;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Container(
              width: 485,
              height: 53,
              color: UiConstant.kCosmoCareCustomColors1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 5),
                child: Text(
                  'Categories',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            isLoading
                ? Expanded(child: Center(child: CircularProgressIndicator()))
                : hasError
                    ? Expanded(child: Center(child: Text(errorMessage)))
                    : Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.5,
                          ),
                          itemBuilder: (context, index) =>
                              CategoryCard(category: categories[index]),
                          itemCount: categories.length,
                        ),
                      )
          ],
        ));
  }
}
