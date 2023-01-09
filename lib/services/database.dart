// ignore_for_file: file_names

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Future<Database> openDatabase() async {
//   // Get a location using the `path` package
//   var databasesPath = await getDatabasesPath();
//   String path = join(databasesPath, 'mydb.db');

//   // Open the database
//   return await openDatabase(path, version: 1,
//       onCreate: (Database db, int version) async {
//     // When creating the db, create the table
//     await db.execute(
//         'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
//   });
// }

// // Insert some records in a transaction
// await db.transaction((txn) async {
//   int id1 = await txn.rawInsert(
//       'INSERT INTO Test(name, value, num) VALUES("some name", 1234, 456.789)');
//   print('inserted1: $id1');
//   int id2 = await txn.rawInsert(
//       'INSERT INTO Test(name, value, num) VALUES(?, ?, ?)',
//       ['another name', 12345678, 3.1416]);
//   print('inserted2: $id2');
// });

// // Get the records
// List<Map> list = await db.rawQuery('SELECT * FROM Test');
// print(list);

// // Count the records
// int count = Sqflite.firstIntValue(
//     await db.rawQuery('SELECT COUNT(*) FROM Test'));
// print('count: $count');

// // Delete a record
// int id = await db.rawDelete('DELETE FROM Test WHERE name = ?', ['some name']);
// print('deleted: $id');

// await db.close();

class DatabaseService {
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;

  static const table = 'my_table';

  static const columnId = '_id';
  static const columnName = 'name';
  static const columnAge = 'age';

  // Make this a singleton class
  DatabaseService._privateConstructor();
  static final DatabaseService instance = DatabaseService._privateConstructor();

  // Only allow a single open connection to the database.
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnAge INTEGER NOT NULL
          )
          ''');
  }

  Future close() async {
    var dbClient = await database;
    dbClient.close();
  }

  // Insert a row in the database
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // Query the database
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // Update a row in the database
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Delete a row in the database
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
