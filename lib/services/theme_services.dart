import 'package:hive/hive.dart';

class ThemeService {
  static const String boxName = "settings";
  static Future<Box> openBox() async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box(boxName);
    }
    return await Hive.openBox(boxName);
  }


  static bool getTheme() {
    final box = Hive.box(boxName);
    return box.get(
      "darkMode",
      defaultValue: false,
    );
  }

  static void saveTheme(bool value) {
    final box = Hive.box(boxName);
    box.put(
      "darkMode",
      value,
    );
  }

}