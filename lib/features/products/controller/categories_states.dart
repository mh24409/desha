import '../model/category_model.dart';

abstract class CategoriesStates {}

class GetCateInitState extends CategoriesStates {}

class GetCateLoadingState extends CategoriesStates {}

class GetCateSuccessState extends CategoriesStates {
  List<CategoryModel> categories;
  GetCateSuccessState({required this.categories});
}

class GetCateFailedState extends CategoriesStates {}