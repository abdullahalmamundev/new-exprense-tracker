import 'package:expense_tracker/views/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/transaction_controller.dart';
import '../model/transaction_model.dart';
import '../utils/app_colors.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() =>
      _AddTransactionScreenState();
}

class _AddTransactionScreenState
    extends State<AddTransactionScreen> {

  final _formKey = GlobalKey<FormState>();

  String type = "Expense Tracker";
  DateTime selectedDate = DateTime.now();

  final transactionController = Get.find<TransactionController>();
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final noteController = TextEditingController();

  final controller = Get.find<TransactionController>();

  void saveTransaction() {

    if (titleController.text.isEmpty ||
        amountController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill all fields",
      );
      return;
    }

    controller.addTransaction(
      TransactionModel(
        title: titleController.text,
        amount: double.parse(
            amountController.text),
        type: type,
        date: selectedDate,
        note: noteController.text,
      ),
    );

    Get.back();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.ap,
        title: const Text(
          "Add Transaction",
          style: TextStyle(color: Colors.white),
        ),
      ),


      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Title
              TextFormField(
                controller: titleController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: const TextStyle(
                    color: Colors.white70,
                  ),
                  filled: true,
                  fillColor: AppColors.card,
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(15),
                  ),
                ),

                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return "Enter title";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              // Amount
              TextFormField(
                controller: amountController,
                keyboardType:
                TextInputType.number,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  labelText: "Amount",
                  labelStyle: const TextStyle(
                    color: Colors.white70,
                  ),
                  filled: true,
                  fillColor: AppColors.card,
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(15),
                  ),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return "Enter amount";
                  }
                  return null;
                },
              ),


              const SizedBox(height: 20),


              // Income / Expense Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style:
                      ElevatedButton.styleFrom(
                        backgroundColor:
                        type == "income"
                            ? AppColors.green
                            : AppColors.card,
                      ),
                      onPressed: () {
                        setState(() {
                          type = "income";
                        });
                      },
                      child: const Text(
                        "Income",
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: ElevatedButton(
                      style:
                      ElevatedButton.styleFrom(
                        backgroundColor:
                        type == "expense"
                            ? AppColors.red
                            : AppColors.card,
                      ),
                      onPressed: () {
                        setState(() {
                          type = "expense";
                        });
                      },
                      child: const Text(
                        "Expense",
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Date Picker
              ListTile(
                tileColor: AppColors.card,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(15),
                ),
                title: Text(
                  "${selectedDate.day}/"
                      "${selectedDate.month}/"
                      "${selectedDate.year}",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                trailing: const Icon(
                  Icons.calendar_month,
                  color: Colors.white,
                ),
                onTap: () async {
                  DateTime? picked =
                  await showDatePicker(
                    context: context,
                    initialDate:
                    selectedDate,
                    firstDate:
                    DateTime(2020),
                    lastDate:
                    DateTime(2100),
                  );

                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
              ),

              const SizedBox(height: 15),

              // Note
              TextFormField(
                controller: noteController,
                maxLines: 3,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  labelText: "Note (Optional)",
                  labelStyle:
                  const TextStyle(
                    color: Colors.white70,
                  ),
                  filled: true,
                  fillColor: AppColors.card,
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(15),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style:
                  ElevatedButton.styleFrom(
                    backgroundColor:
                    AppColors.yellow,
                  ),
                  onPressed: (){
                    Get.to(()=> DashboardScreen());
                    if (_formKey.currentState!.validate()) {
                      TransactionModel transaction = TransactionModel(
                        title: titleController.text.trim(),
                        amount:double.parse(
                          amountController.text,
                        ),
                        type: type,
                        date: selectedDate,
                        note:
                        noteController.text.trim(),
                      );
                      Get.snackbar(
                        "Error",
                        "Please fill all fields",
                      );
                      transactionController.addTransaction(transaction);
                      Get.back();
                      return;
                    }
                    controller.addTransaction(
                      TransactionModel(
                        title: titleController.text,
                        amount: double.parse(
                            amountController.text),
                        type: type,
                        date: selectedDate,
                        note: noteController.text,
                      ),
                    );
                    Get.back();
                  },
                  child: const Text(
                    "Save Transaction",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}