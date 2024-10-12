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
    this.transactions = await db.loadAllData();
    print(this.transactions);
    notifyListeners();
  }

  void addTransaction(Transactions transaction) async {
    var db = await TransactionDB(dbName: 'transactions.db');
    await db.insertDatabase(transaction);
    this.transactions = await db.loadAllData();
    print(this.transactions);
    notifyListeners();
  }

  void deleteTransaction(String id) async {
    print('delete index: $id');
    var db = await TransactionDB(dbName: 'transactions.db');
    await db.deleteDatabase(id);
    this.transactions = await db.loadAllData();
    notifyListeners();
  }

  void updateTransaction(Transactions transaction) async {
    // print('update index: ${transaction.keyID}');
    var db = await TransactionDB(dbName: 'transactions.db');
    await db.updateDatabase(transaction);
    this.transactions = await db.loadAllData();
    notifyListeners();
  }
}
