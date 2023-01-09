import 'package:flutter/material.dart';
import 'package:workograph_shared/services/database_service.dart';

import '../models/user.dart';

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
    // if (widget.user != null) {
    //   _selectedUser = _users.indexWhere((e) => e.id == widget.user!.userId);
    // }
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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(199, 10, 210, 203),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(' '),
            TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(20.0),
                minimumSize: const Size(250.0, 30.0),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/HomeApp');
              },
              icon: const Icon(Icons.arrow_forward_ios_outlined),
              label: const Text('Option A'),
            ),
            const Text(''),
            TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(20.0),
                minimumSize: const Size(250.0, 30.0),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/HomeApp');
              },
              icon: const Icon(Icons.arrow_forward_ios_outlined),
              label: const Text('Option B'),
            ),
            const Text(''),
            TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(20.0),
                minimumSize: const Size(250.0, 30.0),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/HomeApp');
              },
              icon: const Icon(Icons.arrow_forward_ios_outlined),
              label: const Text('Option C'),
            ),
            const Text(''),
            TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(20.0),
                minimumSize: const Size(250.0, 30.0),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/HomeApp');
              },
              icon: const Icon(Icons.arrow_forward_ios_outlined),
              label: const Text('Option D'),
            ),
            const Text(''),
            TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(20.0),
                minimumSize: const Size(250.0, 30.0),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/HomeApp');
              },
              icon: const Icon(Icons.arrow_forward_ios_outlined),
              label: const Text('Option E'),
            ),
            const Text(''),
            TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(20.0),
                minimumSize: const Size(250.0, 30.0),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/HomeApp');
              },
              icon: const Icon(Icons.arrow_forward_ios_outlined),
              label: const Text('Option F'),
            ),
            const Text(''),
            TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(20.0),
                minimumSize: const Size(250.0, 30.0),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/HomeApp');
              },
              icon: const Icon(Icons.arrow_forward_ios_outlined),
              label: const Text('Option H'),
            ),
            const Text(''),
            TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(20.0),
                minimumSize: const Size(250.0, 30.0),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/HomeApp');
              },
              icon: const Icon(Icons.arrow_forward_ios_outlined),
              label: const Text('Option I'),
            ),
            const Text(''),
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
          ],
        ),
      ),
    );
  }
}
