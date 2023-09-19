import 'package:cosmo_care/core/Constants/ui_constants.dart';
import 'package:cosmo_care/features/products/controller/categories_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../controller/categories_cubit.dart';
import '../../model/product_model.dart';
import '../screens/product_details.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _controller = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<ProductsModel>> autoCompleteKey =
      GlobalKey<AutoCompleteTextFieldState<ProductsModel>>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesStates>(
        builder: (context, state) {
      if (state is GetCategorySuccessState) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.white,
            ),
            height: 50.h,
            child: Row(
              children: [
                Flexible(
                  child: AutoCompleteTextField<ProductsModel>(
                    key: autoCompleteKey,
                    suggestionsAmount: 8,
                    suggestions:
                        context.read<CategoriesCubit>().productsSet.toList(),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15),
                      hintText: "Search here".tr,
                      suffixIcon: Icon(
                        Iconsax.search_normal,
                        color: Colors.grey.shade300,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: UiConstant.kCosmoCareCustomColors1,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    itemBuilder: (context, suggestion) {
                      return Container(
                        color: Colors.transparent,
                        child: ListTile(
                          title: Text(suggestion.title),
                        ),
                      );
                    },
                    itemFilter: (suggestion, query) => suggestion.title
                        .toLowerCase()
                        .contains(query.toLowerCase()),
                    itemSorter: (a, b) => a.title.compareTo(b.title),
                    itemSubmitted: (product) {
                      Get.to(
                        () => ProductDetails(
                          product: product,
                        ),
                      );
                      _controller.clear();
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    autofocus: true,
                    controller: _controller,
                    clearOnSubmit: false,
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
