import 'package:cosmo_care/features/products/model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/Constants/api_constants.dart';
import '../../../core/helper/api_helper.dart';
import '../model/category_model.dart';
import 'categories_states.dart';

class CategoriesCubit extends Cubit<CategoriesStates> {
  CategoriesCubit() : super(GetCategoryInitState());

  Set<ProductsModel> productsSet = {};

  Future<void> getProductDividedByCategories() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userToken = preferences.getString("token")!;
    String language = Get.locale?.languageCode ?? 'en';
    Map<String, String> header = {
      'Authorization': 'Bearer $userToken',
    };
    emit(GetCategoryLoadingState());
    final response = await ApiHelper().get(
      url:
          "${ApiConstants.baseUrl}${ApiConstants.categoriesEndPoint}?lang=$language",
      headers: header,
    );
    List<CategoryModel> categories = [];

    if (response["status"] == 200) {
      productsSet.clear();
      for (var category in response['data'].values) {
        CategoryModel categoryModel = CategoryModel.fromJson(category);
        categories.add(categoryModel);
        productsSet.addAll(categoryModel.products);
      }

      emit(GetCategorySuccessState(categories: categories));
    } else if (response["status"] == 400) {
      emit(GetCategorySuccessState(categories: []));
    } else {
      emit(GetCategoryFailedState());
    }
  }
}
