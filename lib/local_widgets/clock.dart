import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workograph_shared/models/user.dart';
import 'package:workograph_shared/services/database_service.dart';

class TimerWidget extends StatefulWidget {
  final Employee employee;

  const TimerWidget({Key? key, required this.employee}) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int _remainingSeconds = 4 * 60 * 60; // 4 hours in seconds
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _stopTimer();
    _saveTime(); // save the remaining time when the page is left
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _stopTimer();
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  Future<void> _saveTime() async {
    // save the remaining time to the database using the sqflite package
    final db = await openDatabase('notes.db');
    await db.update(
      'employees',
      {EmployeesFields.elapsed: _remainingSeconds},
      where: '${EmployeesFields.id} = ?',
      whereArgs: [widget.employee.id],
    );
    await db.close();
  }

  @override
  Widget build(BuildContext context) {
    final hours = (_remainingSeconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((_remainingSeconds ~/ 60) % 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return Text('$hours:$minutes:$seconds');
  }
}
