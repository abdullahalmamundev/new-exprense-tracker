import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/setting_controller.dart';


class CurrencyScreen extends StatelessWidget {
  CurrencyScreen({super.key});

  final controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        const Text("Currency Settings"),
      ),

      body: Obx(() => Column(
          children: [
            RadioListTile(
              title: const Text("Bangladesh Take (৳)"),
              value: "BDT",
              groupValue:
              controller.currency.value,
              onChanged: (value) {
                controller.changeCurrency(
                  value.toString(),
                );
              },
            ),

            RadioListTile(
              title: const Text("US Dollar (\$)"),
              value: "USD",
              groupValue:
              controller.currency.value,
              onChanged: (value) {
                controller.changeCurrency(
                  value.toString(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}