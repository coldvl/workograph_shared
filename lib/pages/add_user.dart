// create an add user page that will allow us to add a new user to the database and display the list of users in a list view. We will also add a delete button to delete a user from the database.
// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:workograph_shared/models/user.dart';
import 'package:workograph_shared/services/database_service.dart';
import 'package:workograph_shared/local_widgets/employee_form_widget.dart';

// class AddUserPage extends StatefulWidget {
//   const AddUserPage({Key? key, this.user}) : super(key: key);
//   final User? user;

//   @override
//   _AddUserPageState createState() => _AddUserPageState();
// }

// class _AddUserPageState extends State<AddUserPage> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _idController = TextEditingController();
//   static final List<User> _users = [];

//   final DatabaseService _databaseService = DatabaseService();

//   int _selectedUser = 0;
//   int _selectedWorkingHours = 0;
//   int _selectedId = 0;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.user != null) {
//       _nameController.text = widget.user!.name;
//       _selectedWorkingHours = widget.user!.workedHours;
//       widget.user!.id = int.parse(_idController.text); //edited so keep in mind
//     }
//   }

//   Future<List<User>> _getUsers() async {
//     final users = await _databaseService.users();
//     if (_users.isEmpty) _users.addAll(users);
//     if (widget.user != null) {
//       _selectedUser = _users.indexWhere((e) => e.id == widget.user!.id);
//     }
//     return _users;
//   }

//   Future<void> _onSave() async {
//     final name = _nameController.text;
//     final id = int.parse(_idController.text);

//     // Add save code here
//     widget.user == null
//         ? _databaseService.addUser(
//             User(name: name, id: id),
//           )
//         : _databaseService.updateUser(
//             User(
//               id: id,
//               name: name,
//             ),
//           );

//     Navigator.pop(context);
//   }

//   Future<void> _onUserDelete(User user) async {
//     await _databaseService.deleteUser(user.id);
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add User'),
//         actions: [
//           if (widget.user != null)
//             IconButton(
//               icon: const Icon(Icons.delete),
//               onPressed: () => _onUserDelete(widget.user!),
//             ),
//         ],
//       ),
//       body: FutureBuilder<List<User>>(
//         future: _getUsers(),
//         builder: (context, snapshot) {
//           return ListView(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextField(
//                   controller: _nameController,
//                   decoration: const InputDecoration(
//                     labelText: 'Name',
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextField(
//                   controller: _idController,
//                   decoration: const InputDecoration(
//                     labelText: 'ID',
//                   ),
//                 ),
//                 // may be needed in future
//                 // child: DropdownButtonFormField<int>(
//                 //   value: _selectedUser,
//                 //   items: _users
//                 //       .map(
//                 //         (e) => DropdownMenuItem<int>(
//                 //           value: _users.indexOf(e),
//                 //           child: Text(e.name), //!
//                 //         ),
//                 //       )
//                 //       .toList(),
//                 //   onChanged: (value) {
//                 //     setState(() {
//                 //       _selectedUser = value!;
//                 //     });
//                 //   },
//                 // ),
//               ),
//               // Padding(
//               //   padding: const EdgeInsets.all(8.0),
//               //   child: DropdownButtonFormField<int>(
//               //     value: _selectedWorkingHours,
//               //     items: List.generate(
//               //       24,
//               //       (index) => DropdownMenuItem<int>(
//               //         value: index,
//               //         child: Text('$index hours'),
//               //       ),
//               //     ),
//               //     onChanged: (value) {
//               //       setState(() {
//               //         _selectedWorkingHours = value!;
//               //       });
//               //     },
//               //   ),
//               // ),
//               ElevatedButton(
//                 onPressed: _onSave,
//                 style: ElevatedButton.styleFrom(
//                   primary: const Color.fromARGB(255, 255, 168, 1),
//                   minimumSize: const Size(25.0, 40.0),
//                   maximumSize: const Size(35.0, 40.0),
//                 ),
//                 child: const Text('Save'),
//               ),
//             ],
//           );
//         },
//       ),
//       backgroundColor: const Color.fromARGB(199, 10, 210, 203),
//     );
//   }
// }

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
      );

  Widget buildButton() {
    final isFormValid = name.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
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
