import 'package:cosmo_care/core/Constants/ui_constants.dart';
import 'package:cosmo_care/features/products/views/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../controller/categories_cubit.dart';
import '../../controller/categories_states.dart';
import '../widgets/product_widget.dart';

class ProductDividedByCateScreen extends StatelessWidget {
  const ProductDividedByCateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const SearchWidget(),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("CosmoCare Current Products".tr),
                  GestureDetector(
                    onTap: () async {
                      await BlocProvider.of<CategoriesCubit>(context)
                          .getProductDividedByCategories();
                    },
                    child: const Icon(
                      Iconsax.refresh,
                      color: UiConstant.kCosmoCareCustomColors1,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<CategoriesCubit, CategoriesStates>(
                builder: (context, state) {
                  if (state is GetCategoryLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  } else if (state is GetCategorySuccessState) {
                    if (state.categories.isNotEmpty) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                color: UiConstant.kCosmoCareCustomColors1,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Text(
                                    state.categories[index].name,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, position) {
                                    return ProductWidget(
                                      product: state
                                          .categories[index].products[position],
                                    );
                                  },
                                  itemCount:
                                      state.categories[index].products.length,
                                ),
                              )
                            ],
                          );
                        },
                        itemCount: state.categories.length,
                      );
                    } else {
                      return Center(
                        child: Text("No Categories Available".tr),
                      );
                    }
                  } else {
                    return Center(
                      child: Text("Something Went Wrong. please try agin".tr),
                    );
                  }
                },
              ),
            ),
          ],
        ));
  }
}
