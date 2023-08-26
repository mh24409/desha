import 'dart:ui';
import 'package:get/get.dart';
import '../local_storage/language_local_storage.dart';

class AppLanguageController extends GetxController {
  var currentAppLanguage = "en";

  @override
  void onInit() async {
    super.onInit();
    LanguageLocalStorage languageLocalStorage = LanguageLocalStorage();
    currentAppLanguage = await languageLocalStorage.selectedLanguage;
    await Get.updateLocale(Locale(currentAppLanguage));
    update();
  }

  void changeSelectedLanguage(String language) async {
    LanguageLocalStorage languageLocalStorage = LanguageLocalStorage();
    if (await languageLocalStorage.selectedLanguage == language) {
      return;
    } else {
      currentAppLanguage = language;
      languageLocalStorage.saveLanguageToDisk(language);
    }
    update();
  }
}
