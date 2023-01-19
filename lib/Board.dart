import 'dart:async';
import 'package:flutter/material.dart';
import 'package:puzzle/layout/responsive_layout_builder.dart';
import 'widgets/Menu.dart';
import 'widgets/MyTitle.dart';
import 'widgets/Grid.dart';


class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  int move = 0;

  static const duration = const Duration(seconds: 1);
  int secondsPassed = 0;
  bool isActive = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    numbers.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (timer == null) {
      timer = Timer.periodic(duration, (Timer t) {
        startTime();
      });
    }

    return SafeArea(
      child: Container(
        height: size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff893a9f),
          Color(0xff7c2ae8),
        ])),
        child: Stack(
          children: [
            Positioned(
                right: 10,
                bottom: 10,
                child: GestureDetector(
                  onDoubleTap: checkWin,
                  child: Image.asset(
                    "assets/images/LogoWhite.png",
                    width: size.width / 4,
                  ),
                )),
            Game(size),
          ],
        ),
      ),
    );
  }

  Column Game(Size size) {
    if (Responsiveness.isLargeScreen(context)) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Flutter Puzzle",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.height * 0.1,
                        color: Colors.white,
                        decoration: TextDecoration.none),
                  ),
                  Image.asset(
                    "assets/images/Dashatars.png",
                    width: 400,
                  )
                ],
              ),
              Grid(numbers, size, clickGrid),
              Menu(
                reset: reset,
                move: move,
                secondsPassed: secondsPassed,
                size: size,
                isHorizontal: false,
              ),
            ],
          ),
        ],
      );
    } else if (Responsiveness.isMediumScreen(context)) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MyTitle(size),
          Grid(numbers, size, clickGrid),
          Menu(
            reset: reset,
            move: move,
            secondsPassed: secondsPassed,
            size: size,
            isHorizontal: true,
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MyTitle(size),
          Grid(numbers, size, clickGrid),
          Menu(
            reset: reset,
            move: move,
            secondsPassed: secondsPassed,
            size: size,
            isHorizontal: true,
          ),
        ],
      );
    }
  }

  void clickGrid(index) {
    if (secondsPassed == 0) {
      isActive = true;
    }
    if (index - 1 >= 0 && numbers[index - 1] == 0 && index % 4 != 0 ||
        index + 1 < 16 && numbers[index + 1] == 0 && (index + 1) % 4 != 0 ||
        (index - 4 >= 0 && numbers[index - 4] == 0) ||
        (index + 4 < 16 && numbers[index + 4] == 0)) {
      setState(() {
        move++;
        numbers[numbers.indexOf(0)] = numbers[index];
        numbers[index] = 0;
      });
    }
    checkWin();
  }

  void startTime() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  void reset() {
    setState(() {
      numbers.shuffle();
      move = 0;
      secondsPassed = 0;
      isActive = false;
    });
  }

  bool isSorted(List list) {
    int prev = list.first;
    for (var i = 1; i < list.length - 1; i++) {
      int next = list[i];
      if (prev > next) return false;
      prev = next;
    }
    return true;
  }

  void checkWin() {
    if (isSorted(numbers)) {
      isActive = false;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: Container(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "You Win!!",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 220.0,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Close",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }
}
