import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Board.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  // await SystemChrome.setEnabledSystemUIMode();
  runApp(puzzle());
}

class puzzle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Puzzle",
      debugShowCheckedModeBanner: false,
      home: Board(),
    );
  }
}