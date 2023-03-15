// ignore_for_file: unused_import

import 'dart:convert';

import 'package:flutter/widgets.dart';

const String tableEmployees = 'employees';

class EmployeesFields {
  static final List<String> values = [
    /// Add all fields
    id, totalHours, name, createdTime
  ];

  static const String id = '_id';

  static const String totalHours = 'totalHours';
  static const String name = 'name';

  static const String createdTime = 'createdTime';
}

class Employee {
  final int? id;

  final int totalHours;
  final String name;

  final DateTime createdTime;

  const Employee({
    this.id,
    required this.totalHours,
    required this.name,
    required this.createdTime,
  });

  Map<String, Object?> toJson() => {
        EmployeesFields.id: id,
        EmployeesFields.totalHours: totalHours,
        EmployeesFields.name: name,
        EmployeesFields.createdTime: createdTime.toIso8601String(),
      };

  static Employee fromJson(Map<String, Object?> json) => Employee(
        id: json[EmployeesFields.id] as int?,
        totalHours: json[EmployeesFields.totalHours] as int,
        name: json[EmployeesFields.name] as String,
        createdTime:
            DateTime.parse(json[EmployeesFields.createdTime] as String),
      );

  Employee copy({
    int? id,
    int? totalHours,
    String? name,
    DateTime? createdTime,
  }) =>
      Employee(
        id: id ?? this.id,
        totalHours: totalHours ?? this.totalHours,
        name: name ?? this.name,
        createdTime: createdTime ?? this.createdTime,
      );
}
