// ignore_for_file: library_private_types_in_public_api, prefer_final_fields, unused_element, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:workograph_shared/models/user.dart';
import 'package:workograph_shared/services/database_service.dart';
import 'package:workograph_shared/pages/add_user.dart';
import 'package:workograph_shared/pages/clock.dart';
import 'package:flutter/widgets.dart';

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

  Future<void> _onUserDelete(User user) async {
    await _databaseService.deleteUser(user.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(199, 10, 210, 203),
        body: Column(children: [
          FutureBuilder<List<User>>(
            future: _databaseService.getUsers(),
            builder:
                (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
              final List<User> users = snapshot.data ?? [];
              if (snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  final User user = users[index];
                  return Card(
                    child: ListTile(
                      title: const Text('txt'),
                      subtitle: Text('${user.workedHours}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _onUserDelete(user),
                      ),
                      onTap: () {
                        setState(() {
                          _selectedUser = user.id;
                          _selectedWorkingHours = user.workedHours;
                        });
                      },
                    ),
                  );
                },
              );

              /* */
            },

            /*child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(20),
            //   child: TextButton(
            //     style: TextButton.styleFrom(
            //       backgroundColor: Colors.black,
            //       foregroundColor: Colors.white,
            //       padding: const EdgeInsets.all(20.0),
            //       minimumSize: const Size(250.0, 30.0),
            //     ),
            //     onPressed: () {
            //       Navigator.of(context)
            //           .push(
            //             MaterialPageRoute(
            //               builder: (_) => const HomeApp(),
            //               fullscreenDialog: true,
            //             ),
            //           )
            //           .then((_) => setState(() {}));
            //     },
            //     child: const Text('*тут можуть бути наші юзери*'),
            //   ),
            // ),
            
          ],
        ),
        */
          ),
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
        ]));
  }

// E/SQLiteLog( 4064): (1) no such table: users in "SELECT * FROM users ORDER BY id"
}
