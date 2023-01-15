// ignore_for_file: library_private_types_in_public_api, prefer_final_fields, unused_element, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:workograph_shared/models/user.dart';
import 'package:workograph_shared/services/database_service.dart';
import 'package:workograph_shared/pages/add_user.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key, this.user}) : super(key: key);
  final User? user;

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final TextEditingController _nameController = TextEditingController();
  static final List<User> _users = [];

  final DatabaseService _databaseService = DatabaseService();

  int _selectedUser = 0;
  int _selectedWorkingHours = 0;

  @override
  void initState() {
    super.initState();
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
            User(name: name, id: user.id),
          )
        : await _databaseService.updateUser(
            User(
              id: widget.user!.id,
              name: name,
            ),
          );

    Navigator.pop(context);
  }

  Future<void> _onUserDelete(User user) async {
    await _databaseService.deleteUser(user.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(199, 10, 210, 203),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(20.0),
                minimumSize: const Size(250.0, 30.0),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new),
              label: const Text('Back'),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (_) => const AddUserPage(),
                          fullscreenDialog: true,
                        ),
                      )
                      .then((_) => setState(() {}));
                },
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
