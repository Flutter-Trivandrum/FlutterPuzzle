import 'package:flutter/material.dart';
import 'Time.dart';
import 'ResetButton.dart';
import 'Move.dart';

// ignore: must_be_immutable
class Menu extends StatelessWidget {
  Function reset;
  int move;
  bool isHorizontal;
  int secondsPassed;
  var size;

  Menu(
      {required this.reset,
      required this.move,
      required this.secondsPassed,
      this.size,
      required this.isHorizontal});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: isHorizontal
            ? Container(
                height: size.height * 0.10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ResetButton(reset, "Reset"),
                    Move(move),
                    Time(secondsPassed),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ResetButton(reset, "Reset"),
                  Padding(
                    padding: const EdgeInsets.all(80.0),
                    child: Move(move),
                  ),
                  Time(secondsPassed),
                ],
              ));
  }
}
