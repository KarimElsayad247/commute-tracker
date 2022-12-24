import 'dart:async';

import 'package:flutter/material.dart';
import 'Styles.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({
    Key? key,
    this.active = false,
  }) : super(key: key);

  final bool active;

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {



  Duration duration = Duration();
  Timer? timer;

  @override
  void initState() {
    super.initState();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(milliseconds: 1), (_) => addTime());
  }

  void stopTimer() {
    timer?.cancel();
  }

  void addTime() {
    const secondsToAdd = 1;
    setState(() {
      final newSeconds = duration.inSeconds + secondsToAdd;
      duration = Duration(seconds: newSeconds);
    });
  }

  @override
  Widget build(BuildContext context) {

    bool? timerActive = timer?.isActive;

    if (!widget.active && timerActive != null && timerActive) {
      stopTimer();
    }
    else if (widget.active){
      if (timerActive == null || !timerActive) {
        startTimer();
      }
    }

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return Container(
      color: Styles.backgroundGray,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: Center(
        child: Text(
          '$hours : $minutes : $seconds',
          style: Styles.gigaFont,
        ),
      ),
    );
  }
}
