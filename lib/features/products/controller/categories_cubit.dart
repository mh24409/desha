import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/Constants/api_constants.dart';
import '../../../core/helper/api_helper.dart';
import '../model/category_model.dart';
import 'categories_states.dart';

class CategoriesCubit extends Cubit<CategoriesStates> {
  CategoriesCubit() : super(GetCateInitState());

  Future<void> getProductDividedByCategories() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userToken = preferences.getString("token")!;
    Map<String, String> header = {
        'Authorization': 'Bearer $userToken',
      };
    emit(GetCateLoadingState());
    final response = await ApiHelper().get(
      url: ApiConstants.baseUrl + ApiConstants.categoriesEndPoint,
      headers: header,
    );
    List<CategoryModel> categories = [];

    if (response["status"] == 200) {
      for (var category in response['data'].values) {
        categories.add(CategoryModel.fromJson(category));
      }

      emit(GetCateSuccessState(categories: categories));
    } else if (response["status"] == 400) {
      emit(GetCateSuccessState(categories: []));
    } else {
      emit(GetCateFailedState());
    }
  }
}
