import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final Duration duration;
  final VoidCallback onFinish;
  final bool isRunning;
  final TextStyle textStyle;

  const CountdownTimer({
    super.key,
    this.duration = const Duration(minutes: 1),
    required this.onFinish,
    this.isRunning = true,
    this.textStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  });

  @override
  CountdownTimerState createState() => CountdownTimerState();
}

class CountdownTimerState extends State<CountdownTimer> {
  late StreamController<int> _controller;
  late Duration _currentDuration;
  Timer? _timer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _controller = StreamController<int>.broadcast();
    _currentDuration = widget.duration;
    _controller.add(_currentDuration.inSeconds);

    if (widget.isRunning) start();
  }

  void start() {
    if (_isRunning) return;
    _isRunning = true;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_currentDuration.inSeconds > 0) {
        _currentDuration -= Duration(seconds: 1);
        _controller.add(_currentDuration.inSeconds);
      } else {
        timer.cancel();
        _isRunning = false;
        widget.onFinish();
      }
    });
  }

  void stop() {
    _timer?.cancel();
    _isRunning = false;
  }

  void restart() {
    _timer?.cancel();
    _isRunning = false;
    _currentDuration = widget.duration;
    _controller.add(_currentDuration.inSeconds);
    start();
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _controller.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return snapshot.data! <= 0
            ? Text("")
            : Text(formatTime(snapshot.data!), style: widget.textStyle);
      },
    );
  }
}
