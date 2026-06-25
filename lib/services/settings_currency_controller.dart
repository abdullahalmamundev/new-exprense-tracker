import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {

  RxBool darkMode = false.obs;
  RxBool notificationEnabled = true.obs;
  RxString currency = "BDT".obs;

  void toggleDarkMode(bool value) {
    darkMode.value = value;
    Get.changeThemeMode(
      value ? ThemeMode.dark : ThemeMode.light,
    );
  }
  void toggleNotification(bool value) {
    notificationEnabled.value = value;
  }
  void changeCurrency(String value) {
    currency.value = value;
  }
}