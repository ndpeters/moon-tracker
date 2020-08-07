import 'package:flutter/material.dart';
import 'package:moon_tracker/shared/constants.dart' as Constants;

class MyMessages extends StatefulWidget {
  @override
  _MyMessagesState createState() => _MyMessagesState();
}

class _MyMessagesState extends State<MyMessages>
with TickerProviderStateMixin {
  AnimationController _spinAnimationController;
  AnimationController _fadeAnimationController;

  @override
  void initState() {
    super.initState();
    _spinAnimationController = AnimationController(
        // ...
        duration: Duration(seconds: Constants.SPIN_TIMER),
        vsync: this,
        )..repeat();
            _fadeAnimationController = AnimationController(
        // ...
        duration: Duration(milliseconds: Constants.FADE_TIMER),
        vsync: this,
        )..forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimationController,
          child: Stack(
        children: <Widget>[
          Positioned(
            child: Container(
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 125,
            left: MediaQuery.of(context).size.width / 2 - 125,
            child: RotationTransition(
                alignment: Alignment.center,
                turns: _spinAnimationController,
                child: Container(width: 250, height: 250, color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _spinAnimationController.dispose();
    _fadeAnimationController.dispose();
    super.dispose();
  }
}
