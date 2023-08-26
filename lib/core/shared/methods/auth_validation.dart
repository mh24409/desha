import 'package:get/get.dart';

String? emailControllerValidator(String? value) {
  if (value!.isEmpty) {
    return "Email Field Is required".tr;
  } else if (!GetUtils.isEmail(value)) {
    return "email is in a bad format".tr;
  }
  return null;
}

String? phoneNumberControllerValidator(String? value) {
  if (value!.isEmpty) {
    return "phone number is empty".tr;
  }
  return null;
}

String? passwordControllerValidator(String? value, {bool isForLogin = false}) {
  if (value!.isEmpty) {
    return 'password is empty'.tr;
  }

  return null;
}

String? userNameControllerValidator(String? value) {
  if (value!.isEmpty) {
    return 'Customer name is empty'.tr;
  }
  return null;
}

String? addressControllerValidator(String? value) {
  if (value!.isEmpty) {
    return 'Customer address is empty'.tr;
  }
  return null;
}

String? distinctiveAddressControllerValidator(String? value) {
  if (value!.isEmpty) {
    return 'Customer distinctive address is empty'.tr;
  }
  return null;
}



String? confirmPasswordControllerValidator(String? value, String? password) {
  if (value!.isEmpty) {
    return 'confirm password is empty'.tr;
  } else {
    if (value != password || password == null) {
      return 'password and confirm password not equaled'.tr;
    } else {
      return null;
    }
  }
}
