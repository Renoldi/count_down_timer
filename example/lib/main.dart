import 'package:count_down_timer/count_down_timer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalKey<CountdownTimerState> countdownKey =
      GlobalKey<CountdownTimerState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Countdown Timer with Start/Stop/Restart')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CountdownTimer(
                key: countdownKey,
                isRunning: true,
                onFinish: () {
                  debugPrint("Countdown Finished!");
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      countdownKey.currentState?.start(); // Start timer
                    },
                    child: Text("Start"),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      countdownKey.currentState?.stop(); // Stop timer
                    },
                    child: Text("Stop"),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      countdownKey.currentState?.restart(); // Restart timer
                    },
                    child: Text("Restart"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
