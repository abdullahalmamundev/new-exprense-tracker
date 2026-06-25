import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../controller/transaction_controller.dart';
import '../utils/app_colors.dart';

class StatisticsScreen extends StatelessWidget {
  StatisticsScreen({super.key});
  final controller = Get.find<TransactionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          "Statistics",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: Obx(() {

        double income = controller.totalIncome;
        double expense = controller.totalExpense;
        double balance = controller.balance;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              // Pie Chart
              SizedBox(
                height: 250,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: income == 0 ? 1 : income,
                        color: AppColors.green,
                        title:
                        "Income\n\$${income.toStringAsFixed(0)}",
                        radius: 80,
                        titleStyle:
                        const TextStyle(
                          color: Colors.white,
                          fontWeight:
                          FontWeight.bold,
                        ),

                      ),
                      PieChartSectionData(
                        value:
                        expense == 0 ? 1 : expense,
                        color: AppColors.red,
                        title:
                        "Expense\n\$${expense.toStringAsFixed(0)}",
                        radius: 80,
                        titleStyle:
                        const TextStyle(
                          color: Colors.white,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Summary Cards
              buildCard(
                "Total Income",
                "\$${income.toStringAsFixed(2)}",
                AppColors.green,
              ),

              buildCard(
                "Total Expense",
                "\$${expense.toStringAsFixed(2)}",
                AppColors.red,
              ),

              buildCard(
                "Current Balance",
                "\$${balance.toStringAsFixed(2)}",
                AppColors.apps,
              ),

              const SizedBox(height: 25),


              // Monthly Summary
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius:
                  BorderRadius.circular(20),
                ),

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Current Month",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Transactions: "
                          "${controller.currentMonthTransactions.length}",
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }


  // Summary Card Widget

  Widget buildCard(
      String title,
      String amount,
      Color color,
      ) {

    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),

      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius:
        BorderRadius.circular(20),

      ),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),

          Text(
            amount,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight:
              FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}