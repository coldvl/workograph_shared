import 'package:flutter/material.dart';
import 'package:workograph_shared/models/user.dart';
import '../services/database_service.dart';
import 'page_with_list_of_users.dart';
import 'statistics.dart';
import 'overall.dart';
import 'clock.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}
// void main() {
//   runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/',
//       routes: {
//         '/': (context) => const Main(),
//         '/page_1': (context) => const Pageone(),
//         '/Overall': (context) => const OverallStatus(),
//         '/statistics': (context) => const Statistics(),
//         '/HomeApp': (context) => const HomeApp(),
//       },
//     ),
//   );
// }

class _HomePageState extends State<HomePage> {
  final DatabaseService _databaseService = DatabaseService();

  Future<List<User>> _getUsers() async {
    return await _databaseService.users();
  }

  Future<void> _onUserDelete(User user) async {
    await _databaseService.deleteUser(user.id!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 168, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Image.asset(
                'assets/logo2.png',
                width: 250,
                height: 250,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(30),
              child: Text("Workograph",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.black)),
            ),
            TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(20.0),
                minimumSize: const Size(250.0, 30.0),
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (_) => const UserPage(),
                        fullscreenDialog: true,
                      ),
                    )
                    .then((_) => setState(() {}));
                // Navigator.pushNamed(context, '/page_with_list_of_users');
              },
              icon: const Icon(Icons.arrow_forward_ios_outlined),
              label: const Text('    Users    '),
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
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (_) => const UserPage(),
                        fullscreenDialog: true,
                      ),
                    )
                    .then((_) => setState(() {}));
                // Navigator.pushNamed(context, '/Overall');
              },
              icon: const Icon(Icons.arrow_forward_ios_outlined),
              label: const Text('Overall status'),
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
                Navigator.pushNamed(context, '/statistics');
              },
              icon: const Icon(Icons.arrow_forward_ios_outlined),
              label: const Text('    Statistics    '),
            ),
          ],
        ),
      ),
    );
  }
}
