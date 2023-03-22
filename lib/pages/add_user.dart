// create an add user page that will allow us to add a new user to the database and display the list of users in a list view. We will also add a delete button to delete a user from the database.
// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:workograph_shared/models/user.dart';
import 'package:workograph_shared/services/database_service.dart';
import 'package:workograph_shared/local_widgets/employee_form_widget.dart';

class AddEditEmployeePage extends StatefulWidget {
  final Employee? employee;

  const AddEditEmployeePage({
    Key? key,
    this.employee,
  }) : super(key: key);
  @override
  _AddEditEmployeePageState createState() => _AddEditEmployeePageState();
}

class _AddEditEmployeePageState extends State<AddEditEmployeePage> {
  final _formKey = GlobalKey<FormState>();

  late int totalHours;
  late String name;

  @override
  void initState() {
    super.initState();

    totalHours = widget.employee?.totalHours ?? 0;
    name = widget.employee?.name ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
          title:
              Text(widget.employee == null ? 'Add Employee' : 'Edit Employee'),
        ),
        body: Form(
          key: _formKey,
          child: EmployeeFormWidget(
            totalHours: totalHours,
            name: name,
            onChangedTotalHours: (totalHours) =>
                setState(() => this.totalHours = totalHours),
            onChangedName: (name) => setState(() => this.name = name),
          ),
        ),
        backgroundColor: const Color.fromARGB(199, 10, 210, 203),
      );

  Widget buildButton() {
    final isFormValid = name.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.black,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateNote,
        child: Text('Save'),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.employee != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final note = widget.employee!.copy(
      totalHours: totalHours,
      name: name,
    );

    await EmployeesDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = Employee(
      name: name,
      totalHours: totalHours,
      createdTime: DateTime.now(),
    );

    await EmployeesDatabase.instance.create(note);
  }
}
