import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workograph_shared/models/user.dart';
import 'package:workograph_shared/services/database_service.dart';

class EmployeeTable extends StatefulWidget {
  @override
  _EmployeeTableState createState() => _EmployeeTableState();
}

class _EmployeeTableState extends State<EmployeeTable> {
  late List<Employee> employees;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    EmployeesDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.employees = await EmployeesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : employees.isEmpty
                  ? const Text(
                      'No Employees',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    )
                  : buildTable(),
        ),
      );

  Widget buildTable() => DataTable(
        columns: const [
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Elapsed')),
        ],
        rows: employees
            .map(
              (employee) => DataRow(cells: [
                DataCell(Text(employee.name)),
                DataCell(Text(employee.elapsed.inHours.toString())),
              ]),
            )
            .toList(),
      );
}
