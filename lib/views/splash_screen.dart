import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),
          () {
        Get.off(
              () => DashboardScreen(),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        width: double.infinity,

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            colors: [
              Color(0xff08122E),
              Color(0xff162447),
            ],

            begin: Alignment.topLeft,

            end: Alignment.bottomRight,

          ),

        ),

        child: const Column(

          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            Icon(
              Icons.account_balance_wallet,
              size: 100,
              color: Colors.yellow,
            ),

            SizedBox(height: 20),

            Text(
              "Expense Tracker",
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "Manage Your Money",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),

          ],

        ),

      ),

    );

  }

}