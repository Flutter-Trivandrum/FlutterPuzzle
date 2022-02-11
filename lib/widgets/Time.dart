import 'package:flutter/material.dart';

String formatTime(int secs) {
  var hours = (secs ~/ 3600).toString().padLeft(2, '0');
  var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
  var seconds = (secs % 60).toString().padLeft(2, '0');
  return " $hours:$minutes:$seconds ";
}

class Time extends StatelessWidget {
  final int secondsPassed;

  Time(this.secondsPassed);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(18),
      ),
      padding: EdgeInsets.symmetric(vertical: 11, horizontal: 21),
      child: Text(
        formatTime(secondsPassed),
        style: TextStyle(
            color: Colors.white, decoration: TextDecoration.none, fontSize: 18),
      ),
    );
  }
}
