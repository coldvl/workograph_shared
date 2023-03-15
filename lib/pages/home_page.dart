// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'page_with_list_of_users.dart';
import 'statistics_for_month.dart';
import 'statistics_for_today.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                        builder: (_) => EmployeesPage(),
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
                        builder: (_) => const StatsForToday(),
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
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (_) => const StatsForMonth(),
                        fullscreenDialog: true,
                      ),
                    )
                    .then((_) => setState(() {}));
                // Navigator.pushNamed(context, '/statistics');
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
