import 'package:expense_tracker/controller/setting_controller.dart';
import 'package:expense_tracker/views/settings_screen.dart';
import 'package:expense_tracker/views/statistics.dart';
import 'package:expense_tracker/views/transaction_lists_screen.dart';
import 'package:expense_tracker/widgets/transaction_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/transaction_controller.dart';
import '../utils/app_colors.dart';
import 'add_transaction_screen.dart';

class DashboardScreen extends StatefulWidget {

   DashboardScreen({super.key});

   final SettingsController controller = Get.find<SettingsController>();




  @override
  _DashboardScreen createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen> {


  int currentIndex = 0;
  final List<Widget> screens = [
    Center(child: Text("Dash Board")),
    StatisticsScreen(),
    SettingsScreen(),
  ];
  final controller = Get.find<TransactionController>();
  final settings = Get.find<SettingsController>();



  Null get bottomNavigationBar => null;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          "Expense Tracker",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      // Button Nav Bar
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30)
        ),
        child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DashboardScreen(),
                  ),
                );
              }

              if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => StatisticsScreen(),
                  ),
                );
              }

              if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SettingsScreen(),
                  ),
                );
              }
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home),
                  label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.chart_pie),
                  label: 'Statistics'
              ),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.settings),
                  label: 'Settings'
              ),
            ]
        ),
      ),

      body: Obx(() {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Balance Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.yellow,
                  borderRadius:
                  BorderRadius.circular(25),
                ),

                child: Column(
                  children: [
                    const Text(
                      "Total Balance",
                    ),
                    Text(
                      "\$${controller.balance}",
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text("Income"),
                            Text(
                              "\$${controller.totalIncome}",
                              style: const TextStyle(
                                color: AppColors.green,
                              ),
                            ),
                          ],
                        ),

                        Column(
                          children: [
                            const Text("Expense"),
                            Text(
                              "\$${controller.totalExpense}",
                              style: const TextStyle(
                                color: AppColors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Recent Transactions",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const Text(
                    "Last 5",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => TransactionListScreen());
                    },
                    child: const Text(
                      "See All",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 15),

              // Transaction List

              if(controller.recentTransactions.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    "No Transactions Yet",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              else
                ListView.builder(
                  itemCount:
                  controller.recentTransactions.length,
                  shrinkWrap: true,
                  physics:
                  const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return TransactionTile(
                      transaction:
                      controller.recentTransactions[index],
                    );
                  },
                ),
            ],
          ),
        );
      }),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.yellow,
        onPressed: () {
          // Go to Add Screen
          Get.to(AddTransactionScreen());
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}