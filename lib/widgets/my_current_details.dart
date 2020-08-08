import 'package:flutter/material.dart';
import 'package:moon_tracker/pages/home.dart';
import 'package:moon_tracker/widgets/location_weather.dart';
import 'package:moon_tracker/widgets/time_day.dart';

class CurrentDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /// current day and time
        /// STFL

        /// current temperature
        Container(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              MyClock(),
               Positioned(
              right: 0,
              left: MediaQuery.of(context).size.width - 105,
              child: FloatingActionButton(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white.withAlpha(105),
                child: Container(child: Icon(Icons.refresh),),
                onPressed: (){
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) => HomePage()));
                    Navigator.of(context).pushReplacement(_createRoute());
                },
              ),
            ),
            ],
          ),
        ),

        MyLocation(),
        // // Stack(
        // //   children: [
        // //     MyLocation(),
        // //     Positioned(
        // //       top: 95,
        // //       left: MediaQuery.of(context).size.width - 105,
        // //       child: FloatingActionButton(
        // //         foregroundColor: Colors.black,
        // //         backgroundColor: Colors.white.withAlpha(105),
        // //         child: Container(child: Icon(Icons.refresh),),
        // //         onPressed: (){
        // //             // Navigator.pushReplacement(context,
        // //             //     MaterialPageRoute(builder: (context) => HomePage()));
        // //             Navigator.of(context).pushReplacement(_createRoute());
        // //         },
        // //       ),
        // //     ),
        // //   ],
        // // )
      ],
    );
  }
}
Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}