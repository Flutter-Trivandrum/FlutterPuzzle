import 'dart:async';
import 'dart:html';
import 'dart:math';
import 'package:clipboard/clipboard.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:puzzle/Reward.dart';
import 'package:puzzle/layout/responsive_layout_builder.dart';
import 'widgets/Menu.dart';
import 'widgets/MyTitle.dart';
import 'widgets/Grid.dart';

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> with TickerProviderStateMixin {
  var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  int move = 0;

  static const duration = const Duration(seconds: 1);
  int secondsPassed = 0;
  bool isActive = false;
  Timer? timer;
  final controller = ConfettiController(duration: 5.days);
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
    if (isSorted(numbers)) {
      controller.play();
    } else {
      controller.stop();
    }

    return SafeArea(
      child: Container(
        height: size.height,
        color: Color(0xff8859A1),
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(colors: [
        //   Color(0xffB8E5FF),
        //   Color(0xff0CAEE5),
        // ])),
        child: Stack(
          children: [

            Positioned(
                right: 30,
                bottom: 30,
                child: GestureDetector(
                  onDoubleTap: checkWin,
                  child: Image.asset(
                    "assets/images/LogoWhite.png",
                    width: size.width / 4,
                  ),
                )),
            Game(size),
            Align(
              alignment: Alignment.topLeft,
              child: ConfettiWidget(
                confettiController: controller,
                // blastDirection: pi/2,
                blastDirectionality: BlastDirectionality.explosive,
                numberOfParticles: 50,
                gravity: 0.1,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: controller,
                // blastDirection: pi/2,
                blastDirectionality: BlastDirectionality.explosive,
                numberOfParticles: 50,
                gravity: 0.1,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: ConfettiWidget(
                confettiController: controller,
                // blastDirection: pi/2,
                blastDirectionality: BlastDirectionality.explosive,
                numberOfParticles: 50,
                gravity: 0.1,
              ),
            ),
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
                    "Venue Hunt",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.height * 0.1,
                        color: Colors.white,
                        decoration: TextDecoration.none),
                  ),
                  Image.asset(
                    "assets/images/Auto.png",
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
    // checkWin();
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
    final size = MediaQuery.of(context).size;

    if (isSorted(numbers)) {
      isActive = false;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: Wrap(
                children: [Container(
                  // height: MediaQuery.of(context).size.height / 1.2,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/images/trophy.json',
                          // controller: AnimationController(vsync: this, duration: 5.seconds),
                          repeat: false,
                          frameRate: FrameRate(60),
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.height / 6,
                        ),
                        // Text(
                        //   "!!YOU WIN!!",
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.bold,
                        //       fontSize: size.height * 0.05,
                        //       color: Colors.black,
                        //       decoration: TextDecoration.none),
                        // ),
                        Image.asset(
                          "assets/images/key.png",
                          width: MediaQuery.of(context).size.width / 3,
                        ),
                        // Text(
                        //   "!!YOU WIN!!",
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.bold,
                        //       fontSize: size.height * 0.05,
                        //       color: Colors.black,
                        //       decoration: TextDecoration.none),
                        // ),
                        // Spacer(),
                        SizedBox(
                          width: 220.0,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Reward(),));
                            },
                            child: Text(
                              "✨ Your Reward Awaits ✨"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff8859A1),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0)),
                              minimumSize: Size(200, 50)),
                          ),
                        )
                      ],
                    ),
                  ),
                )],
              ),
            );
          });
    }
  }
}
