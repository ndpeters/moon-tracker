import 'package:flutter/material.dart';
import 'package:moon_tracker/pages/home.dart';
import 'package:moon_tracker/shared/constants.dart' as Constants;
import 'package:moon_tracker/widgets/mycurrentdetails.dart';
import 'package:moon_tracker/widgets/stacktiletemplate.dart';

class MyNews extends StatefulWidget {
  @override
  _MyNewsState createState() => _MyNewsState();
}

class _MyNewsState extends State<MyNews> with TickerProviderStateMixin {
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
    /// constants for screen size
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return FadeTransition(
      opacity: _fadeAnimationController,
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              width: w,
              height: h,
              color: Colors.lightBlue.withOpacity(.85),
            ),
          ),

          // //TODO: create view for most recent news
          // StackTileTemplate(
          //   positionedValue: 410,
          //   cardWidth: w - 16,
          //   cardHeight: 85,
          //   containerHeight: 255,
          //   cardAmount: 3,
          // ),

          // //TODO: create view for main details
          // Positioned(
          //   top: 140,
          //   child: CurrentDetails()),
          Stack(
            children: <Widget>[
              StackTileTemplate(
                positionedValue: 140,
                cardWidth: w - 16,
                //? height might not be needed
                //? maybe wrap the entire page with a singlechildscrollview to prevent overflow
                // cardHeight: 260,
                containerHeight: 260,
                cardAmount: 1,
                content: CurrentDetails(),
              ),
            ],
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
