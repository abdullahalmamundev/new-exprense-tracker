import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/transaction_controller.dart';
import '../model/transaction_model.dart';
import '../utils/app_colors.dart';
import 'edit_transaction_screen.dart';

class TransactionListScreen extends StatelessWidget {

  TransactionListScreen({super.key});

  final controller = Get.find<TransactionController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          "All Transactions",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor:
        AppColors.background,
      ),

      body: Column(
        children: [
          // Search
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              style: const TextStyle(
                color: Colors.white,
              ),

              decoration: InputDecoration(
                hintText:
                "Search transaction",
                hintStyle:
                const TextStyle(
                  color: Colors.grey,
                ),
                prefixIcon:
                const Icon(
                  Icons.search,
                  color: Colors.white,
                ),

                filled: true,
                fillColor:
                AppColors.card,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onChanged: (value) {
                controller.searchText.value = value;
              },
            ),
          ),
          // Filter Buttons
          Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              filterButton(
                "All",
                "all",
              ),
              filterButton(
                "Income",
                "income",
              ),
              filterButton(
                "Expense",
                "expense",
              ),

            ],

          )),

          const SizedBox(height: 10),


          // Transaction List

          Expanded(

            child: Obx(() {

              if(controller.filteredTransactions.isEmpty){
                return const Center(
                  child: Text(
                    "No Transaction Found",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),

                );
              }
              return ListView.builder(
                itemCount: controller.transactions.length,
                itemBuilder: (context, index) {
                  final transaction = controller.transactions[index];
                  ListTile(
                    title: Text(transaction.title),
                    subtitle: Text(transaction.amount.toString()),
                  );

                  bool income =
                      transaction.type == "income";
                  return Card(
                    color: AppColors.card,

                    margin:
                    const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),

                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                        income
                            ? AppColors.green
                            : AppColors.red,
                        child: Icon(
                          income
                              ? Icons.arrow_downward
                              : Icons.arrow_upward,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        transaction.title,
                        style:
                        const TextStyle(
                          color: Colors.white,
                        ),
                      ),

                      subtitle: Text(
                        transaction.note,
                        style:
                        const TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${income ? "+" : "-"} \$${transaction.amount}",
                            style: TextStyle(
                              color:
                              income
                                  ? AppColors.green
                                  : AppColors.red,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Get.to(() => EditTransactionScreen(
                                transaction: transaction,
                              ),
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),

                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              // এখানে Confirmation Dialog ব্যবহার হবে
                              Get.dialog(
                                AlertDialog(
                                  title: const Text("Delete Transaction"),
                                  content: const Text(
                                    "Are you sure you want to delete this transaction?",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Get.back(),
                                      child: const Text("Cancel"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        final transaction = controller.transactions[index]; // ✅ get object
                                        controller.deleteTransaction(transaction);
                                        Get.back();
                                      },
                                      child: const Text("Delete"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }


  // Filter Button Widget

  Widget filterButton(
      String text,
      String value,
      ) {
    bool selected =
        controller.filterType.value == value;
    return ElevatedButton(
      style:
      ElevatedButton.styleFrom(
        backgroundColor:
        selected
            ? AppColors.yellow
            : AppColors.card,
      ),
      onPressed: () {
        controller.filterType.value = value;
      },
      child: Text(
        text,
        style: TextStyle(
          color:
          selected
              ? Colors.black
              : Colors.white,
        ),
      ),
    );
  }

  // Delete Dialog
  void showDeleteDialog(
      TransactionModel transaction,
      ) {
    Get.defaultDialog(
      title: "Delete",
      middleText:
      "Are you sure you want to delete this transaction?",
      textCancel: "No",
      textConfirm: "Yes",
      confirmTextColor:
      Colors.white,
      onConfirm: () {
        controller.deleteTransaction(
          transaction,
        );
        Get.back();
      },
    );
  }
}