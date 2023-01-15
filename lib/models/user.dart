// ignore_for_file: unused_import

import 'dart:convert';

import 'package:flutter/widgets.dart';

class User {
  int id;
  final String name;
  int workedHours;

  User({
    required this.id,
    required this.name,
    this.workedHours = 0,
  });

  // Convert a User into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'workedHours': workedHours,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'].toInt() ?? 0,
      name: map['name'] ?? '',
      workedHours: map['workedHours']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  // Implement toString to make it easier to see information about
  // each user when using the print statement.
  @override
  String toString() {
    return 'User(id: $id, name: $name, workedHours: $workedHours)';
  }
}
