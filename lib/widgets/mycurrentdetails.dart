import 'package:flutter/material.dart';
import 'package:moon_tracker/widgets/locationweather.dart';
import 'package:moon_tracker/widgets/timeandday.dart';

class CurrentDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /// current day and time
        /// STFL
        MyClock(),

        /// current temperature

        MyLocation(),
        // Stack(
        //   children: [
        //     MyLocation(),
        //     Positioned(
        //       top: 95,
        //       left: MediaQuery.of(context).size.width - 105,
        //       child: FloatingActionButton(
        //         foregroundColor: Colors.black,
        //         backgroundColor: Colors.white.withAlpha(105),
        //         child: Container(child: Icon(Icons.refresh),),
        //         onPressed: (){
        //           setState(() {

        //           });
        //         },
        //       ),
        //     ),
        //   ],
        // )
      ],
    );
  }
}
