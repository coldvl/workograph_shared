// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/widgets.dart';

const String tableEmployees = 'employees';

class EmployeesFields {
  static final List<String> values = [
    /// Add all fields
    id, totalHours, name, createdTime, isOn, startedTime, isPaused
  ];

  static const String id = '_id';

  static const String totalHours = 'totalHours';
  static const String name = 'name';
  static const String isOn = 'isOn';
  static const String startedTime = 'startedTime';
  static const String isPaused = 'isPaused';
  static const String createdTime = 'createdTime';
  static const String elapsed = 'elapsed';
}

class Employee {
  final int? id;

  final int totalHours;
  final String name;
  bool isOn;
  DateTime startedTime;
  Duration elapsed;
  bool isPaused = false;
  final DateTime createdTime;

  Employee({
    this.id,
    required this.isOn,
    required this.totalHours,
    required this.name,
    required this.createdTime,
    required this.isPaused,
    required this.elapsed,
    required this.startedTime,
  });

  Map<String, Object?> toJson() => {
        EmployeesFields.id: id,
        EmployeesFields.totalHours: totalHours,
        EmployeesFields.name: name,
        EmployeesFields.createdTime: createdTime.toIso8601String(),
        EmployeesFields.isOn: isOn,
        EmployeesFields.startedTime: startedTime.toIso8601String(),
        EmployeesFields.isPaused: isPaused,
        EmployeesFields.elapsed: elapsed.inSeconds,
      };

  static Employee fromJson(Map<String, Object?> json) => Employee(
        id: json[EmployeesFields.id] as int?,
        totalHours: json[EmployeesFields.totalHours] as int,
        name: json[EmployeesFields.name] as String,
        createdTime:
            DateTime.parse(json[EmployeesFields.createdTime] as String),
        isOn: false,
        startedTime: DateTime.now(),
        isPaused: false,
        // set elased time as 4 hours
        elapsed: const Duration(hours: 4),
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
        isOn: isOn,
        startedTime: startedTime,
        isPaused: isPaused,
        elapsed: elapsed,
      );

  void toggleOn() {
    isOn = !isOn;
  }
}
