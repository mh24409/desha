abstract class AuthStates {}

class AuthInitState extends AuthStates {}

class LoginSuccessState extends AuthStates {}

class RegistrationSuccessState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class LoginFailureState extends AuthStates {
  String errorMessage;
  LoginFailureState(
    {
      required this.errorMessage
    }
  );
}

class RegisterFailureState extends AuthStates {
   String errorMessage;
  RegisterFailureState(
    {
      required this.errorMessage
    }
  );
}
