import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/setting_controller.dart';



class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),

      body: Obx(() => SwitchListTile(
          value:
          controller.notificationEnabled.value,
          title:
          const Text("Enable Notification"),
          onChanged:
          controller.toggleNotification,
        ),
      ),
    );
  }
}