// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../model/user_model.dart';

abstract class UserStates {}

class UserInitState extends UserStates {}

class UserSuccessState extends UserStates {
  UserModel currentUser ;
  
  UserSuccessState({
    required this.currentUser,
  });
}

class UserLoadingState extends UserStates {}

class UserFailedState extends UserStates {}
