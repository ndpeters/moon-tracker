import 'package:flutter/material.dart';
import 'package:moon_tracker/shared/constants.dart' as Constants;
import 'package:moon_tracker/widgets/my_current_details.dart';
import 'package:moon_tracker/widgets/news_articles.dart';
import 'package:moon_tracker/widgets/stack_tile_template.dart';

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

          //TODO: create view for most recent news
          // StackTileTemplate(
          //   positionedValue: 385,
          //   cardWidth: w - 16,
          //   cardHeight: 95,
          //   containerHeight: 285,
          //   cardAmount: 3,
          //   // content: MyNews(),
          // ),

          //TODO: create view for main details
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
          Positioned(
              top: 385,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      for (var i = 0; i < 4; i++)
                      MyNewsArticle(screenWidth: w, i: i)

                      // for (var i = 0; i < 4; i++)
                      //   Padding(
                      //     padding:
                      //         const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 6.0),
                      //     child: Container(
                      //         width: 60, height: 60, color: Colors.red),
                      //   ),
                    ],
                  ),
                ),
              ))
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
