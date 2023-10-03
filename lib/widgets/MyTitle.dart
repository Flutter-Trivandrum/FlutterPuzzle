import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  var size;

  MyTitle(this.size);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          "assets/images/Auto.png",
          width: size.width * 0.20,
        ),
        Container(
          padding: EdgeInsets.all(5.0),
          child: Text(
            "Venue Hunt",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: size.height * 0.050,
                color: Colors.white,
                decoration: TextDecoration.none),
          ),
        ),
        Image.asset(
          "assets/images/community-hero.png",
          width: size.width * 0.20,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
