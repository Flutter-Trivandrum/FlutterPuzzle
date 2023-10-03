import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_text_reveal/random_text_reveal.dart';
import 'package:url_launcher/url_launcher.dart';

class Reward extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF051215),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: 20,
                sigmaY: 20,
              ),
              child: Image.asset('images/hex.png',
                      fit: BoxFit.cover,
                      color: Color(0xFF051215),
                      width: double.infinity,
                      height: double.infinity)
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(
                      delay: 500.ms,
                      duration: 4500.ms,
                      color: Color(0xFF5603AD)),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child:
                        Image.asset("assets/images/LogoWhite.png", width: 400)
                            .animate(delay: 6.5.seconds)
                            .shimmer(
                                duration: 2.5.seconds,
                                color: Color(0xFFFFD700)),
                  ),
                  GestureDetector(
                      onLongPress: () async {
                        final snackBar = SnackBar(
                          content: Text("Key Copied"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        await Clipboard.setData(ClipboardData(
                            text: "32332e30363733373339,37322e36303233373633"));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(50),
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Column(
                            children: [
                              RandomTextReveal(
                                text: '32332e30363733373339',
                                initialText: '૩૨૩૩૨e૩૩૨૩૩૨e૩૩૨૩૩૨e૩૩૨૩૩૨e૩',
                                duration: Duration(seconds: 6),
                                style: GoogleFonts.poppins(
                                  fontSize: 36,
                                  color: Colors.tealAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                                curve: Curves.easeIn,
                              ),
                              RandomTextReveal(
                                text: '37322e36303233373633',
                                duration: Duration(seconds: 6),
                                style: GoogleFonts.poppins(
                                  fontSize: 36,
                                  color: Colors.tealAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                                curve: Curves.easeIn,
                              ),
                            ],
                          ).animate(delay: 7.seconds).shimmer(
                              duration: 2.5.seconds, color: Color(0xFFFFD700)),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Hold The Key to Copy, You might have a ",
                        style: TextStyle(color: Colors.white)),
                        Icon(Icons.flutter_dash_rounded,color: Colors.white),
                        Text(" waiting for you", style: TextStyle(color: Colors.white))
                      ]
                    )
                        .animate(delay: 4.seconds)
                        .fadeIn(duration: 2.5.seconds),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                        "!! keep the key safe somewhere it might be useful later !!",
                        style: TextStyle(color: Colors.white))
                        .animate(delay: 4.seconds)
                        .fadeIn(duration: 2.5.seconds),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(
                          text: "32332e30363733373339,37322e36303233373633"));
                      launchUrl(Uri.parse(
                          'https://drive.google.com/file/d/14lr3hbX6mthca9Lyw8wVyIRruGwrB9Q_/view'));
                    },
                    child: Text("Claim your Reward 🎉"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color(0xFF5603AD),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        minimumSize: Size(200, 50)),
                  ).animate(delay: 5.seconds).fadeIn(duration: 2.5.seconds),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
