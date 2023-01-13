import 'package:flutter/material.dart';



class Pageone extends StatelessWidget{
  const Pageone ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(199, 10, 210, 203),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(' '),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFFFFC401),
                          Color(0xC70AD2CB),

                        ],
                      ),
                    ),
                  ),
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(20.0),
                        minimumSize: const Size(250.0, 30.0),
                        foregroundColor: Colors.white
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context,'/HomeApp');
                    },
                    icon: const Icon(Icons.arrow_forward_ios_outlined),
                    label: const Text('Option A'),
                  ),
                ],
              ),
            ),
            const Text(''),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFFFFC401),
                          Color(0xC70AD2CB),

                        ],
                      ),
                    ),
                  ),
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(20.0),
                        minimumSize: const Size(250.0, 30.0),
                        foregroundColor: Colors.white
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context,'/HomeApp');
                    },
                    icon: const Icon(Icons.arrow_forward_ios_outlined),
                    label: const Text('Option B'),
                  ),
                ],
              ),
            ),
            const Text(''),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFFFFC401),
                          Color(0xC70AD2CB),

                        ],
                      ),
                    ),
                  ),
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(20.0),
                        minimumSize: const Size(250.0, 30.0),
                        foregroundColor: Colors.white
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context,'/HomeApp');
                    },
                    icon: const Icon(Icons.arrow_forward_ios_outlined),
                    label: const Text('Option C'),
                  ),
                ],
              ),
            ),
            const Text(''),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFFFFC401),
                          Color(0xC70AD2CB),

                        ],
                      ),
                    ),
                  ),
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(20.0),
                        minimumSize: const Size(250.0, 30.0),
                        foregroundColor: Colors.white
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context,'/HomeApp');
                    },
                    icon: const Icon(Icons.arrow_forward_ios_outlined),
                    label: const Text('Option D'),
                  ),
                ],
              ),
            ),
            const Text(''),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFFFFC401),
                          Color(0xC70AD2CB),

                        ],
                      ),
                    ),
                  ),
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(20.0),
                        minimumSize: const Size(250.0, 30.0),
                        foregroundColor: Colors.white
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context,'/HomeApp');
                    },
                    icon: const Icon(Icons.arrow_forward_ios_outlined),
                    label: const Text('Option E'),
                  ),
                ],
              ),
            ),
            const Text(''),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFFFFC401),
                          Color(0xC70AD2CB),

                        ],
                      ),
                    ),
                  ),
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(20.0),
                        minimumSize: const Size(250.0, 30.0),
                        foregroundColor: Colors.white
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context,'/HomeApp');
                    },
                    icon: const Icon(Icons.arrow_forward_ios_outlined),
                    label: const Text('Option F'),
                  ),
                ],
              ),
            ),
            const Text(''),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFFFFC401),
                          Color(0xC70AD2CB),

                        ],
                      ),
                    ),
                  ),
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(20.0),
                        minimumSize: const Size(250.0, 30.0),
                        foregroundColor: Colors.white
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context,'/HomeApp');
                    },
                    icon: const Icon(Icons.arrow_forward_ios_outlined),
                    label: const Text('Option H'),
                  ),
                ],
              ),
            ),
            const Text(''),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFFFFC401),
                          Color(0xC70AD2CB),

                        ],
                      ),
                    ),
                  ),
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(20.0),
                        minimumSize: const Size(250.0, 30.0),
                        foregroundColor: Colors.white
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context,'/HomeApp');
                    },
                    icon: const Icon(Icons.arrow_forward_ios_outlined),
                    label: const Text('Option I',style: TextStyle(),),
                  ),
                ],
              ),
            ),
            const Text(''),
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
            ),
          ],
        ),
      ),
    );
  }
}