import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../controller/transaction_controller.dart';
import '../model/transaction_model.dart';


class HiveService {

  static const String boxName = "transactions";
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TransactionModelAdapter());
    await Hive.openBox<TransactionModel>("transactions");
    await Hive.openBox('settings');
    Get.put(TransactionController());
  }

  Future<Box<TransactionModel>> openBox() async {
    return await Hive.openBox<TransactionModel>("transactions");
  }
}