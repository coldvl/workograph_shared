import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:workograph_shared/services/database_service.dart';
import 'package:workograph_shared/models/user.dart';

import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  final Employee employee;

  TimerWidget({required this.employee});

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late DateTime startTime;
  late Duration elapsed;

  @override
  void initState() {
    super.initState();
    if (widget.employee.isOn) {
      startTime = widget.employee.startedTime;
      elapsed = DateTime.now().difference(startTime);
    } else {
      startTime = DateTime.now();
      elapsed = Duration.zero;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Time elapsed: ${_formatDuration(elapsed)}',
          style: TextStyle(fontSize: 24.0),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: Text(widget.employee.isOn ? 'Stop' : 'Start'),
              onPressed: () {
                setState(() {
                  if (widget.employee.isOn) {
                    widget.employee.isOn = false;
                    widget.employee.startedTime = DateTime.now();
                    elapsed = Duration.zero;
                  } else {
                    widget.employee.isOn = true;
                    widget.employee.startedTime = startTime;
                  }
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${duration.inHours}:$twoDigitMinutes:$twoDigitSeconds";
  }
}







//   void stop() {
//     timer!.cancel();
//     setState(() {
//       started = false;
//     });
//   }

//   void reset() {
//     timer!.cancel();
//     setState(() {
//       seconds = 0;
//       minutes = 0;
//       hours = 0;

//       digitSeconds = "00";
//       digitMinutes = "00";
//       digitHours = "00";

//       started = false;
//     });
//   }

//   void start(BuildContext context) {
//     started = true;
//     timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       int localSeconds = seconds;
//       int localMinutes = minutes;
//       int localHours = hours;

//       if (localSeconds > 0) {
//         localSeconds--;
//         if (localSeconds == 0 && localMinutes > 0) {
//           localMinutes--;
//           localSeconds = 59;

//           if (localSeconds == 0 && localMinutes == 0 && localHours > 0) {
//             localSeconds == 59;
//             localMinutes == 59;
//             localHours--;
//           }
//         }
//       } else {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(const SnackBar(content: Text('Finish')));
//         timer.cancel();
//       }
//       setState(() {
//         seconds = localSeconds;
//         minutes = localMinutes;
//         hours = localHours;
//         digitSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
//         digitMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
//         digitHours = (hours >= 10) ? "$hours" : "0$hours";
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Text('$digitHours:$digitMinutes:$digitSeconds',
//               style: const TextStyle(fontSize: 50)),
//           TextButton.icon(
//             style: TextButton.styleFrom(
//               backgroundColor: _hasBeenPressed ? Colors.green : Colors.red,
//               foregroundColor: Colors.white,
//               padding: const EdgeInsets.all(20.0),
//               minimumSize: const Size(250.0, 30.0),
//             ),
//             onPressed: () {
//               (!started) ? start(context) : stop();
//               setState(() {
//                 _hasBeenPressed = !_hasBeenPressed;
//               });
//             },
//             icon: _hasBeenPressed
//                 ? const Icon(Icons.not_started_outlined)
//                 : const Icon(Icons.stop_circle_outlined),
//             label: _hasBeenPressed ? const Text('Start') : const Text('Stop'),
//           ),
//           TextButton.icon(
//             style: TextButton.styleFrom(
//               backgroundColor: Colors.black,
//               foregroundColor: Colors.white,
//               padding: const EdgeInsets.all(20.0),
//               minimumSize: const Size(250.0, 30.0),
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(Icons.arrow_back_ios_new),
//             label: const Text('Back'),
//           ),
//         ],
//       ),
//     ));
//   }
// }
