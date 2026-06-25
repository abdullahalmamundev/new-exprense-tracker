import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../model/transaction_model.dart';
import '../services/hive_controller.dart';

class TransactionController extends GetxController {
  // Hive Box
  late Box<TransactionModel> transactionBox;

  // Observable Transaction List
  RxList<TransactionModel> transactions = <TransactionModel>[].obs;
  RxString filterType = "all".obs;
  RxString searchText = "".obs;

  List<TransactionModel> get filteredTransactions {
    List<TransactionModel> list = transactions;
    // Search
    if (searchText.value.isNotEmpty) {
      list = list.where((item) {
        return item.title
            .toLowerCase()
            .contains(
          searchText.value.toLowerCase(),
        );
      }).toList();
    }

    // Filter
    if (filterType.value != "all") {
      list = list.where((item) {
        return item.type == filterType.value;
      }).toList();
    }
    return list;
  }
  List<TransactionModel> get currentMonthTransactions {
    DateTime now = DateTime.now();
    return transactions.where((item) {
      return item.date.month == now.month &&
          item.date.year == now.year;

    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    // Get opened box
    transactionBox = Hive.box<TransactionModel>(
      HiveService.boxName,

    );
    loadTransactions();
  }


  // =============================
  // READ ALL TRANSACTIONS
  // =============================
  void loadTransactions() {
    transactions.value = transactionBox.values.toList();

    // Newest transaction first
    transactions.sort(
          (a, b) => b.date.compareTo(a.date),
    );
  }


  // =============================
  // CREATE TRANSACTION
  // =============================
  void addTransaction(
      TransactionModel transaction,
      ) {

    transactionBox.add(transaction);

    loadTransactions();

    Get.snackbar(
      "Success",
      "Transaction added successfully",
    );
  }


  // =============================
  // UPDATE TRANSACTION
  // =============================
  void updateTransaction(
      TransactionModel oldTransaction,
      TransactionModel newTransaction,
      ) {
    oldTransaction.title = newTransaction.title;
    oldTransaction.amount = newTransaction.amount;
    oldTransaction.type = newTransaction.type;
    oldTransaction.date = newTransaction.date;
    oldTransaction.note = newTransaction.note;
    oldTransaction.save();
    loadTransactions();
    Get.snackbar(
        "Update", "Transaction updated successfully"
    );
  }


  // =============================
  // DELETE TRANSACTION
  // =============================
  void deleteTransaction(TransactionModel transaction) async {
    await transaction.delete();
    loadTransactions();
    Get.snackbar(
      "Deleted",
      "Transaction deleted successfully",
    );
  }


  // =============================
  // TOTAL INCOME
  // =============================
  double get totalIncome {
    double total = 0;

    for (var item in transactions) {
      if (item.type == "income") {
        total += item.amount;
      }
    }

    return total;
  }


  // =============================
  // TOTAL EXPENSE
  // =============================
  double get totalExpense {
    double total = 0;

    for (var item in transactions) {
      if (item.type == "expense") {
        total += item.amount;
      }
    }

    return total;
  }


  // =============================
  // CURRENT BALANCE
  // =============================
  double get balance {
    return totalIncome - totalExpense;
  }


  // =============================
  // LAST 5 TRANSACTIONS
  // =============================
  List<TransactionModel> get recentTransactions {

    if (transactions.length <= 5) {
      return transactions;
    }

    return transactions.sublist(0, 5);
  }

}