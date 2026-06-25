import 'package:expense_tracker/views/currency_setting.dart';
import 'package:expense_tracker/views/about_app.dart';
import 'package:expense_tracker/views/privacy_policy.dart';
import 'package:expense_tracker/views/profile_screen.dart';
import 'package:expense_tracker/views/statistics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/setting_controller.dart';
import '../controller/theme_controller.dart';
import '../utils/app_colors.dart';

class SettingsScreen extends StatelessWidget {

  SettingsScreen({super.key});

  final SettingsController controllers = Get.find<SettingsController>();
  final controller = Get.find<ThemeControllers>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor:
        AppColors.background,
      ),


      body: Obx(() => Center(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Abdullah Al Mamun"),
              accountEmail: Text("Dev.abdullahalmamun@gmail.com"),
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.person, size: 40),
              ),
            ),
            SwitchListTile(
              title: const Text(
                "Dark Mode",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              subtitle: const Text(
                "Enable dark theme",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              value: controller.isDark.value,
              onChanged: (value) {
                controller.changeTheme(value);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>  ProfileScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.pie_chart),
              title: const Text("Statistics"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>  StatisticsScreen(),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.backup),
              title: const Text("Currency Setting"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>  CurrencyScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.backup),
              title: const Text("Notification"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>  PrivacyPolicyScreen(),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("About App"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>  AboutAppScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.backup),
              title: const Text("Privacy Policy"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>  PrivacyPolicyScreen(),
                  ),
                );
              },
            ),

          ],
        ),
      )),
    );
  }
}