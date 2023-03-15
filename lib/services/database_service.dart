import 'package:workograph_shared/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:async';

class EmployeesDatabase {
  static final EmployeesDatabase instance = EmployeesDatabase._init();

  static Database? _database;

  EmployeesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';

    const intType = 'INTEGER NOT NULL';
    const textType = 'TEXT NOT NULL';
    await db.execute('''
                    CREATE TABLE $tableEmployees (
                      ${EmployeesFields.id} $idType,
                      
                      ${EmployeesFields.totalHours} $intType,
                      ${EmployeesFields.name} $textType,
                      
                      ${EmployeesFields.createdTime} $textType
                    )
                    ''');
  }

  Future<Employee> create(Employee employee) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns = '${NotesFields.title}, ${NotesFields.description}, ${NotesFields.createdTime}';
    // final values = '${json[NotesFields.title]}, ${json[NotesFields.description]}, ${json[NotesFields.createdTime]]}}';

    // final id = await db
    //     .rawinsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableEmployees, employee.toJson());
    return employee.copy(id: id);
  }

  Future<Employee> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableEmployees,
      columns: EmployeesFields.values,
      where: '${EmployeesFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Employee.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Employee>> readAllNotes() async {
    final db = await instance.database;

    const orderBy = '${EmployeesFields.createdTime} ASC';
    // final result = await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableEmployees, orderBy: orderBy);

    return result.map((json) => Employee.fromJson(json)).toList();
  }

  Future<int> update(Employee note) async {
    final db = await instance.database;

    return db.update(
      tableEmployees,
      note.toJson(),
      where: '${EmployeesFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableEmployees,
      where: '${EmployeesFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
