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
  Future<Database> get database async => _database ??= await _initDatabase();

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
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''
      CREATE TABLE groceries(
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
