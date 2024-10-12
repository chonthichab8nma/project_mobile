import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:account/models/transactions.dart';

class TransactionDB {
  String dbName;

  TransactionDB({required this.dbName});

  Future<Database> openDatabase() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);

    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  Future<int> insertDatabase(Transactions statement) async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('expense');
    try {
      var keyID = store.add(db, {
        "note": statement.note,
        "emotionColor": statement.emotionColor,
        "date": statement.date.toIso8601String()
      });
      db.close();
      return keyID;
    } finally {
      await db.close();
    }
  }

  Future<List<Transactions>> loadAllData() async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('expense');
    List<Transactions> transactions = [];
    try {
      var snapshot = await store.find(db,
          finder: Finder(sortOrders: [SortOrder(Field.key, false)]));

      for (var record in snapshot) {
        transactions.add(Transactions(
            id: record.key.toString(),
            note: record['note'].toString(),
            emotionColor: record['emotionColor'].toString(),
            date: DateTime.parse(record['date'].toString())));
      }
      db.close();
      return transactions;
    } finally {
      await db.close();
    }
    return transactions;
  }

  deleteDatabase(String id) async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('expense');
    await store.delete(db,
        finder: Finder(filter: Filter.equals(Field.key, id)));
    // Delete from table... where rowId = index
    db.close();
  }

  updateDatabase(Transactions statement) async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('expense');
    var filter = Finder(filter: Filter.equals(Field.key, statement.id));
    var result = store.update(db, finder: filter, {
      "note": statement.note,
      "emotionColor": statement.emotionColor,
      "date": statement.date.toIso8601String()
    });
    db.close();
    print('update result: $result');
  }
}
