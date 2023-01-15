// create an add user page that will allow us to add a new user to the database and display the list of users in a list view. We will also add a delete button to delete a user from the database.
// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:workograph_shared/models/user.dart';
import 'package:workograph_shared/services/database_service.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({Key? key, this.user}) : super(key: key);
  final User? user;

  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final TextEditingController _nameController = TextEditingController();
  static final List<User> _users = [];

  final DatabaseService _databaseService = DatabaseService();

  int _selectedUser = 0;
  int _selectedWorkingHours = 0;
  int? _selectedId = 0;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _nameController.text = widget.user!.name;
      _selectedWorkingHours = widget.user!.workedHours;
      _selectedId = widget.user!.id;
    }
  }

  Future<List<User>> _getUsers() async {
    final users = await _databaseService.users();
    if (_users.isEmpty) _users.addAll(users);
    if (widget.user != null) {
      _selectedUser = _users.indexWhere((e) => e.id == widget.user!.id);
    }
    return _users;
  }

  Future<void> _onSave() async {
    final name = _nameController.text;
    final workingHours = _selectedWorkingHours;
    final user = _users[_selectedUser];

    // Add save code here
    widget.user == null
        ? await _databaseService.insertUser(
            User(name: name, workedHours: workingHours, id: user.id!),
          )
        : await _databaseService.updateUser(
            User(
              id: widget.user!.id,
              name: name,
              workedHours: workingHours,
            ),
          );

    Navigator.pop(context);
  }

  Future<void> _onUserDelete(User user) async {
    await _databaseService.deleteUser(user.id!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
        actions: [
          if (widget.user != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _onUserDelete(widget.user!),
            ),
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: _getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<int>(
                    value: _selectedUser,
                    items: _users
                        .map(
                          (e) => DropdownMenuItem<int>(
                            value: _users.indexOf(e),
                            child: Text(e.name), //!
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedUser = value!;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<int>(
                    value: _selectedWorkingHours,
                    items: List.generate(
                      24,
                      (index) => DropdownMenuItem<int>(
                        value: index,
                        child: Text('$index hours'),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _selectedWorkingHours = value!;
                      });
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: _onSave,
                  child: const Text('Save'),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
