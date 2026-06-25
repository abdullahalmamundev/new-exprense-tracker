import 'package:expense_tracker/views/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/transaction_controller.dart';
import '../model/transaction_model.dart';
import '../utils/app_colors.dart';

class EditTransactionScreen extends StatefulWidget {
  final TransactionModel transaction;

  const EditTransactionScreen({
    super.key,
    required this.transaction,
  });

  @override
  State<EditTransactionScreen> createState() =>
      _EditTransactionScreenState();
}

class _EditTransactionScreenState
    extends State<EditTransactionScreen> {

  final _formKey = GlobalKey<FormState>();

  late TextEditingController titleController;
  late TextEditingController amountController;
  late TextEditingController noteController;

  late String type;
  late DateTime selectedDate;

  final controller =
  Get.find<TransactionController>();


  @override
  void initState() {
    super.initState();

    titleController =
        TextEditingController(
          text: widget.transaction.title,
        );

    amountController =
        TextEditingController(
          text: widget.transaction.amount.toString(),
        );

    noteController =
        TextEditingController(
          text: widget.transaction.note,
        );

    type = widget.transaction.type;
    selectedDate = widget.transaction.date;
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text(
          "Edit Transaction",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.background,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            children: [

              // Title
              customField(
                controller: titleController,
                label: "Title",
              ),

              const SizedBox(height: 15),

              // Amount
              customField(
                controller: amountController,
                label: "Amount",
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 20),

              // Type Buttons
              Row(
                children: [

                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
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

                      child: const Text("Income"),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
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

                      child: const Text("Expense"),
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
                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),

                trailing: const Icon(
                  Icons.calendar_month,
                  color: Colors.white,
                ),

                onTap: () async {

                  DateTime? date =
                  await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );

                  if (date != null) {
                    setState(() {
                      selectedDate = date;
                    });
                  }

                },

              ),

              const SizedBox(height: 15),

              // Note
              customField(
                controller: noteController,
                label: "Note (Optional)",
                maxLines: 3,
              ),

              const SizedBox(height: 30),

              // Update Button
              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    AppColors.yellow,
                  ),
                  onPressed: () async {
                    updateTransaction();
                    Get.to(() => DashboardScreen());
                    Get.snackbar(
                      "Success",
                      "Transaction updated successfully",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    Get.back(); // ✅ go back to previous screen
                  },
                  child: const Text(
                    "Update Transaction",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }


  // Custom TextField
  Widget customField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType =
        TextInputType.text,
    int maxLines = 1,
  }) {

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,

      style: const TextStyle(
        color: Colors.white,
      ),

      decoration: InputDecoration(
        labelText: label,
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

      validator: (value) {
        if (label != "Note (Optional)" &&
            (value == null || value.isEmpty)) {
          return "Enter $label";
        }

        return null;
      },

    );

  }


  // Update Method
  void updateTransaction() {

    if (_formKey.currentState!.validate()) {

      TransactionModel newData =
      TransactionModel(
        title: titleController.text.trim(),
        amount: double.parse(
          amountController.text,
        ),
        type: type,
        date: selectedDate,
        note: noteController.text.trim(),
      );


      controller.updateTransaction(
        widget.transaction,
        newData,
      );


      Get.back();

    }

  }


  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    noteController.dispose();

    super.dispose();
  }

}