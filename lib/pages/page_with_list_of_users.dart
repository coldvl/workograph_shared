// ignore_for_file: library_private_types_in_public_api, prefer_final_fields, unused_element, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:workograph_shared/models/user.dart';
import 'package:workograph_shared/services/database_service.dart';
import 'package:workograph_shared/pages/add_user.dart';
import 'package:workograph_shared/local_widgets/clock.dart';
import 'package:flutter/widgets.dart';
import 'package:workograph_shared/local_widgets/employee_form_widget.dart';
import 'package:workograph_shared/local_widgets/employee_card_widget.dart';
import 'package:workograph_shared/pages/employee_detail_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class EmployeesPage extends StatefulWidget {
  @override
  _EmployeesPageState createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
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
                  : buildNotes(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.yellow,
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => const AddEditEmployeePage()),
            );

            refreshNotes();
          },
        ),
      );

  Widget buildNotes() => StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(8),
        itemCount: employees.length,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
        crossAxisCount: 1,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final employee = employees[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    EmployeeDetailPage(employeeId: employee.id!),
              ));

              refreshNotes();
            },
            child: EmployeeCardWidget(employee: employee, index: index),
          );
        },
      );
}
