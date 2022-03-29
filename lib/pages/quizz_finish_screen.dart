import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:gurucoolv1/pages/home_page.dart';
import '/commons/theme.dart';
import 'dart:math';

class QuizzFinish extends StatefulWidget {

  final int score;
  final int total;

  QuizzFinish({this.score, this.total});

  @override
  _QuizzFinishState createState() => _QuizzFinishState();
}

class _QuizzFinishState extends State<QuizzFinish> {

  ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 5));
    _controllerCenter.play();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HomepageBackgroundLight.withOpacity(0.3),
        child: Stack(
          children: [
            Positioned.fill(
              top: 150,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("SCORE", style: TextStyle(color: HomepageBackground, fontSize: 30.0, fontWeight: FontWeight.w900, fontFamily: 'Alpha'),),
                      Text("${widget.score} / ${widget.total}", style: TextStyle(color: HomepageBackground, fontSize: 50.0, fontWeight: FontWeight.w900, fontFamily: 'Alpha'),),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset("assets/finish.png"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: _controllerCenter,
                blastDirectionality: BlastDirectionality.explosive, // don't specify a direction, blast randomly
                emissionFrequency: 0.2,
                shouldLoop: false, // start again as soon as the animation is finished
                maxBlastForce: 21,
                minBlastForce: 20,
                maximumSize: Size(30, 30),
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ], // manually specify the colors to be used
                createParticlePath: drawStar, // define a custom shape/path.
              ),
            ),
          ],
        ),
      ),
    );
  }
}
