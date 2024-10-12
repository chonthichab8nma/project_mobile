import 'package:account/databases/transaction_db.dart';
import 'package:flutter/foundation.dart';
import 'package:account/models/transactions.dart';

class TransactionProvider with ChangeNotifier {
  List<Transactions> transactions = [];

  List<Transactions> getTransaction() {
    return transactions;
  }

  void initData() async {
    var db = await TransactionDB(dbName: 'transactions.db');
    transactions = await db.loadAllData();
    print(transactions);
    notifyListeners();
  }

  void addTransaction(Transactions transaction) async {
    try {
      var db = await TransactionDB(dbName: 'transactions.db');
      await db.insertDatabase(transaction);
      transactions = await db.loadAllData();
      print(transactions);
      notifyListeners();
    } catch (e) {
      print('Error adding transaction: $e');
    }
  }

  Future<void> deleteTransaction(String id) async {
    try {
      print('delete index: $id');
      var db = await TransactionDB(dbName: 'transactions.db');
      await db.deleteDatabase(id);
      transactions = await db.loadAllData();
      notifyListeners();
    } catch (e) {
      print('Error deleting transaction: $e');
    }
  }

  Future<void> updateTransaction(Transactions transaction) async {
    try {
      print('update index: ${transaction.id}');
      var db = await TransactionDB(dbName: 'transactions.db');
      await db.updateDatabase(transaction);
      transactions = await db.loadAllData();
      notifyListeners();
    } catch (e) {
      print('Error updating transaction: $e');
    }
  }
}
