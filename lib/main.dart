import 'package:expense_tracker/controller/theme_controller.dart';
import 'package:expense_tracker/services/hive_controller.dart';
import 'package:expense_tracker/utils/app_theme.dart';
import 'package:expense_tracker/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async{
  await HiveService.init();
  Get.put(ThemeControllers());
  runApp(const MyApp());
}


class TransactionController extends GetxController {
  final Box transactionBox = Hive.box('transactions');
  final controller = Get.find<TransactionController>();
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: SplashScreen(),
    );
  }
}

