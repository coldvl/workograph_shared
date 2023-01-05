import 'package:flutter/material.dart';

class OverallStatus extends StatelessWidget {
  const OverallStatus({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(

    backgroundColor: const Color.fromARGB(255, 231, 11, 11),
    body: Column(
      children: [
        Table(
        border: TableBorder.all(),

        children: [
          buildRow(['Option A',' ']),
          buildRow(['Option B',' ']),
          buildRow(['Option C',' ']),
          buildRow(['Option D',' ']),
          buildRow(['Option E',' ']),
          buildRow(['Option F',' ']),
          buildRow(['Option H',' ']),
          buildRow(['Option I',' ']),
        ],
      ),
        const Text(' '),
        Column(
          children: [
            TextButton.icon(
              style: TextButton.styleFrom(

                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(20.0),
                minimumSize: const Size(250.0, 30.0),
              ),
              onPressed:() {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new),
              label: const Text('Back'),
            )
          ],
        )
      ],
    ),
  );


  TableRow buildRow(List<String> celles) => TableRow(
    children: celles.map((cell) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Center(child: Text(cell)),
      );
    }).toList(),
  );
}