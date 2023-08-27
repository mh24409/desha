import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cosmo_care/core/Constants/ui_constants.dart';
import 'package:cosmo_care/core/widgets/widgets/vertical_spacer.dart';
import 'package:cosmo_care/features/products/views/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/Constants/assets_path_constants.dart';
import '../controller/categories_cubit.dart';
import '../controller/categories_states.dart';

class ProductDividedByCateScreen extends StatelessWidget {
  const ProductDividedByCateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("CosmoCare Current Products"),
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
              if (state is GetCateLoadingState) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                );
              } else if (state is GetCateSuccessState) {
                if (state.categories.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.06,
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
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, position) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      () => ProductDetails(
                                        product: state
                                            .categories[index].products[position],
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 15),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.height *
                                                  0.15,
                                          height:
                                              MediaQuery.of(context).size.height *
                                                  0.15,
                                          decoration: const BoxDecoration(
                                            color: Color(0xffF9F6F6),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 2,
                                                blurRadius: 2,
                                                offset: Offset(2, 3),
                                              ),
                                            ],
                                          ),
                                          child: ConditionalBuilder(
                                            condition: state
                                                    .categories[index]
                                                    .products[position]
                                                    .imageURL !=
                                                "",
                                            builder: (context) {
                                              // try {
                                              // return Image.network(
                                              //   state.categories[index]
                                              //       .products[position].imageURL,
                                              //   fit: BoxFit.fill,
                                              // );
                                              // } catch (e) {
                                              return Image.asset(
                                                AssetsPathConstants
                                                    .kProductPlaceholder,
                                                fit: BoxFit.fill,
                                              );
                                              // }
                                            },
                                            fallback: (context) => Image.asset(
                                              AssetsPathConstants
                                                  .kProductPlaceholder,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        VerticalSpacer(5.h),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.height *
                                                  0.15,
                                          child: Text(
                                            state.categories[index]
                                                .products[position].title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: state.categories[index].products.length,
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
