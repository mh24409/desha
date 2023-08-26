import 'package:get/get.dart';
import 'app_langauge_controller.dart';
import '../local_storage/language_local_storage.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => LanguageLocalStorage());
    Get.put(() => AppLanguageController());
  }
}
