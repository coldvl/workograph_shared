import 'package:workograph_shared/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';

class DatabaseService {
  // Singleton pattern
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  //the fuction below is for inserting a user into the database
  Future<List<User>> users() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        name: maps[i]['name'],
        workedHours: maps[i]['workedHours'],
      );
    });
  }

  //function for initializing the database without the await keyword

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'users.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
          id INTEGER PRIMARY KEY,
          name TEXT
      )
      ''');
  }

  //getUsers function
  Future<List<User>> getUsers() async {
    Database db = await database;
    var users = await db.query('users', orderBy: 'id');
    List<User> userList = users.isNotEmpty
        ? users.map((user) => User.fromMap(user)).toList()
        : [];
    return userList;
  }

  //addUser function
  Future<int> addUser(User user) async {
    Database db = await database;
    var result = await db.insert('users', user.toMap());
    return result;
  }

  //updateUser function
  Future<int> updateUser(User user) async {
    Database db = await database;
    var result = await db
        .update('users', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
    return result;
  }

  //deleteUser function
  Future<int> deleteUser(int id) async {
    Database db = await database;
    var result = await db.delete('users', where: 'id = ?', whereArgs: [id]);
    return result;
  }
}

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
