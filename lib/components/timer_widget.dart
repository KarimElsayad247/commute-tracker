import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/styles.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({
    Key? key,
    this.active = false,
    required this.duration,
    required this.setDuration,
  }) : super(key: key);

  final bool active;
  final Duration duration;
  final Function(Duration) setDuration;

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {

  Timer? timer;

  @override
  void initState() {
    super.initState();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 10), (_) => addTime());
  }

  void stopTimer() {
    timer?.cancel();
  }

  void addTime() {
    const millisecondsToAdd = 10;
    final newMilliseconds = widget.duration.inMilliseconds + millisecondsToAdd;
    widget.setDuration(Duration(milliseconds: newMilliseconds));
  }

  @override
  Widget build(BuildContext context) {

    bool? timerActive = timer?.isActive;
    timerActive ??= false;

    if (!widget.active && timerActive) {
      stopTimer();
    }
    else if (widget.active && !timerActive){
      startTimer();
    }

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final duration = widget.duration;
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    final milliseconds = twoDigits(duration.inMilliseconds.remainder(1000) ~/ 10);

    return Container(
      color: Styles.backgroundGray,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: Center(
        child: Text(
          '$hours : $minutes : $seconds : $milliseconds',
          style: Styles.gigaFont,
        ),
      ),
    );
  }
}
