import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageLocalStorage {
  ///write
  void saveLanguageToDisk(String selectedLanguage) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("appLang", selectedLanguage);
    // await GetStorage().write("appLang", selectedLanguage);
  }

  ///read
  Future<String> get selectedLanguage async {
     SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("appLang") ?? Get.deviceLocale!.languageCode;
  }
}
