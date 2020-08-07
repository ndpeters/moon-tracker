import 'package:flutter/material.dart';
import 'package:moon_tracker/shared/constants.dart' as Constants;

class MyFriends extends StatefulWidget {
  @override
  _MyFriendsState createState() => _MyFriendsState();
}

class _MyFriendsState extends State<MyFriends> 
with TickerProviderStateMixin {
AnimationController _scaleAnimationController;
  AnimationController _fadeAnimationController;

  @override
  void initState() {
    super.initState();
    _scaleAnimationController = AnimationController(
        // ...
        duration: Duration(seconds: 2),
        vsync: this,
        )..forward();
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
            child: ScaleTransition(
              scale: _scaleAnimationController,
              child: Container(width: 250, height: 250, color: Colors.red)),
          ),
        ],
      ),
    );
  }

    @override
  void dispose() {
    _scaleAnimationController.dispose();
    _fadeAnimationController.dispose();
    super.dispose();
  }
}
