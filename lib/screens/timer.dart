import 'dart:async';

import 'package:flutter/material.dart';


String formatTime(int milliseconds) {
  var secs = milliseconds ~/ 1000;
  var hours = (secs ~/ 3600).toString().padLeft(2, '0');
  var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
  var seconds = (secs % 60).toString().padLeft(2, '0');

  return "$hours:$minutes:$seconds";
}

late String tm = "00:00:00";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Stopwatch Example', home: StopwatchPage());
  }
}

class StopwatchPage extends StatefulWidget {
  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  Stopwatch? stopwatch;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    start();
  }

  void start() {
    stopwatch = Stopwatch();

    timer = new Timer.periodic(new Duration(milliseconds: 60), (timer) {
      setState(() {
        tm = formatTime(stopwatch!.elapsedMilliseconds);
      });
    });
  }
 

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  void handleStartStop() {
    if (stopwatch!.isRunning) {
      stopwatch!.stop();
    
    } else {
      
      start();
      stopwatch!.start();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stopwatch Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(stopwatch!.isRunning ? tm : '00:00:00', style: TextStyle(fontSize: 48.0)),
            ElevatedButton(
                onPressed: () {
                  handleStartStop();
                  setState(() {
                    tm = "00:00:00";
                  });
                },
                child: Text(stopwatch!.isRunning ? 'Stop' : 'Start')),
          ],
        ),
      ),
    );
  }
}
