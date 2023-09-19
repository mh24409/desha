import '../model/category_model.dart';

abstract class CategoriesStates {}

class GetCategoryInitState extends CategoriesStates {}

class GetCategoryLoadingState extends CategoriesStates {}

class GetCategorySuccessState extends CategoriesStates {
  List<CategoryModel> categories;
  GetCategorySuccessState({required this.categories});
}

class GetCategoryFailedState extends CategoriesStates {}
