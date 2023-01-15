import 'package:workograph_shared/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

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

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'allUsers.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
          id INTEGER PRIMARY KEY,
          name TEXT,
          workedHours INTEGER
      )
      ''');
  }

  // Future<Database> _initDatabase() async {
  //   final databasePath = await getDatabasesPath();

  //   // Set the path to the database. Note: Using the `join` function from the
  //   // `path` package is best practice to ensure the path is correctly
  //   // constructed for each platform.
  //   final path = join(databasePath, 'flutter_sqflite_database.db');

  //   // Set the version. This executes the onCreate function and provides a
  //   // path to perform database upgrades and downgrades.
  //   return await openDatabase(
  //     path,
  //     onCreate: _onCreate,
  //     version: 1,
  //     onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
  //   );
  // }

  // // When the database is first created, create a table to store users
  // Future<void> _onCreate(Database db, int version) async {
  //   // Run the CREATE {users} TABLE statement on the database.
  //   await db.execute(
  //     'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, workedHours INTEGER)',
  //   );
  // }

  // Define a function that inserts users into the database

  Future<void> insertUser(User user) async {
    final db = await _databaseService.database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the users from the breeds table.
  Future<List<User>> users() async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Query the table for all the Users.
    final List<Map<String, dynamic>> maps = await db.query('users');

    // Convert the List<Map<String, dynamic> into a List<User>.
    return List.generate(maps.length, (index) => User.fromMap(maps[index]));
  }

  // A method that updates a user data from the users table.
  Future<void> updateUser(User user) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Update the given user
    await db.update(
      'users',
      user.toMap(),
      // Ensure that the User has a matching id.
      where: 'id = ?',
      // Pass the User's id as a whereArg to prevent SQL injection.
      whereArgs: [user.id],
    );
  }

  // A method that deletes a user data from the breeds table.

  Future<void> deleteUser(int id) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Remove the User from the database.
    await db.delete('users',
        // Use a `where` clause to delete a specific user.
        where: 'id = ?',
        // Pass the User's id as a whereArg to prevent SQL injection.
        whereArgs: [id]);
  }
}
