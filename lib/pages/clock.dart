import 'package:flutter/material.dart';
import 'dart:async';

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  Clock createState() => Clock();
}

class Clock extends State<HomeApp> {
  int seconds = 59,minutes = 59,hours = 3;
  String digitSeconds = "00",digitMinutes = "00",digitHours = "04";
  Timer? timer;
  bool started = false;
  bool _hasBeenPressed = true;
  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      digitSeconds = "00";
      digitMinutes = "00";
      digitHours = "00";

      started = false;
    });
  }

  void start(BuildContext context) {
    started = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int localSeconds = seconds;
      int localMinutes = minutes;
      int localHours = hours;

      if(localSeconds > 0) {
        localSeconds--;
        if (localSeconds == 0 && localMinutes > 0) {
          localMinutes--;
          localSeconds=59;


          if (localSeconds ==0 && localMinutes ==0 &&localHours>0){
            localSeconds==59;
            localMinutes==59;
            localHours--;
          }
        }
      }
      else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Finish')));
        timer.cancel();
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        digitSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
        digitHours = (hours >= 10) ? "$hours" : "0$hours";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('$digitHours:$digitMinutes:$digitSeconds',
              style: const TextStyle(fontSize: 50)),
          TextButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: _hasBeenPressed ? Colors.green : Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(20.0),
              minimumSize: const Size(250.0, 30.0),
            ),
            onPressed: () {
              (!started) ? start(context) : stop();
              setState(() {
                _hasBeenPressed = !_hasBeenPressed;
              });
            },
            icon: _hasBeenPressed
                ? const Icon(Icons.not_started_outlined)
                : const Icon(Icons.stop_circle_outlined),
            label: _hasBeenPressed ? const Text('Start') : const Text('Stop'),
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
        ],
      ),
    ));
  }
}
