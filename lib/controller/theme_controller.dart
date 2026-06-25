import 'package:get/get.dart';
import '../services/theme_services.dart';


class ThemeControllers extends GetxController {

  RxBool isDark = false.obs;

  @override
  void onInit() {
    super.onInit();
    isDark.value = ThemeService.getTheme();

  }

  void changeTheme(bool value) {
    isDark.value = value;
    ThemeService.saveTheme(value);
  }
}