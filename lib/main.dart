import 'package:flutter/material.dart';
import 'page_1.dart';
import 'statistics.dart';
import 'overall.dart';
import 'clock.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Main(),
        '/page_1': (context) => const Pageone(),
        '/Overall': (context) => const OverallStatus(),
        '/statistics': (context) => const Statistics(),
        '/HomeApp': (context) => const HomeApp(),

      },
    ),
  );
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key) ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 168,1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/logo2.png'),),
            const Text(''),
            const Text(''),
            const Text(''),
            const Text(''),
            const Text(''),
            const Text(''),


            const  Text('Workograph',style: TextStyle(fontSize: 30.0,  fontStyle: FontStyle.italic),),
            const Text(''),
            const Text(''),
            const Text(''),
            const Text(''),
            const Text(''),
            const Text(''),
            const Text(''),
            const Text(''),
            const Text(''),
            TextButton.icon(
              style: TextButton.styleFrom(

                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(20.0),
                minimumSize: const Size(250.0, 30.0),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/page_1');
              },
              icon: const Icon(Icons.arrow_forward_ios_outlined),
              label: const Text('    Continue    '),
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
                Navigator.pushNamed(context, '/Overall');
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