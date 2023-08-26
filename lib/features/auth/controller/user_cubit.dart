import 'package:cosmo_care/features/auth/controller/user_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/Constants/api_constants.dart';
import '../../../core/helper/api_helper.dart';
import '../model/user_model.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(UserInitState());

  Future<void> getCurrentUserInfo() async {
    emit(UserLoadingState());
    SharedPreferences preferences = await SharedPreferences.getInstance();
    UserModel user = UserModel();
    user.userName = preferences.getString("userName");
    user.userId = preferences.getInt("id");
    user.email = preferences.getString("email");
    user.userImage = preferences.getString("image");
    user.trackingID = preferences.getString("trackingID");
    user.token = preferences.getString("token");

    emit(
      UserSuccessState(
        currentUser: user,
      ),
    );
  }

  Future<String> getImage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int partnerId = preferences.getInt("partner_id")!;
    Map<String, String> headers = {"Content-Type": "application/json"};
    Map<String, dynamic> body = {
      "partner_id": partnerId,
    };
    final response = await ApiHelper().post(
      url: ApiConstants.baseUrl,
      body: body,
      headers: headers,
    );
    if (response["status"] == 200) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("image", response['data']['image']);
      await getCurrentUserInfo();
      return response['data']['image'];
    }
    return "";
  }
}
