import 'dart:async';
import 'package:flutter/material.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CountdownTimerScreen extends StatefulWidget {
  @override
  _CountdownTimerScreenState createState() => _CountdownTimerScreenState();
}

class _CountdownTimerScreenState extends State<CountdownTimerScreen> {
  int _start = 60; // Set initial countdown time in seconds
  Timer? _timer;

  void startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start > 0) {
        setState(() {
          _start--;
        });
      } else {
        _timer!.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Countdown Timer')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$_start",
              style: AppTextStyles.bold42().copyWith(),
            ),
            20.ph,
            ElevatedButton(
              onPressed: startTimer,
              child: const Text("Start Countdown"),
            ),
          ],
        ),
      ),
    );
  }
}
