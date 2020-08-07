import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyClock extends StatefulWidget {
  @override
  _MyClockState createState() => _MyClockState();
}

class _MyClockState extends State<MyClock> {
    Timer timer;
  String _timeString;
  DateTime now = DateTime.now();
  DateFormat formatterDayOfWeek = DateFormat('EEEE');
  DateFormat formatterMonthDayYear = DateFormat('MMMM dd, yyyy');
  DateFormat formatterCurrentTime = DateFormat('jms');
  
    @override
  void initState() {
    // // _timeString = "${DateTime.now().hour} : ${DateTime.now().minute} :${DateTime.now().second}";
    // // timer = Timer.periodic(Duration(seconds:1), (Timer t){_getCurrentTime();
    String formattedCurrentTime = formatterCurrentTime.format(now);
    _timeString = "$formattedCurrentTime";
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      DateTime newNow = DateTime.now();

      String formattedNewCurrentTime = formatterCurrentTime.format(newNow);
      setState(() {
        _timeString = "$formattedNewCurrentTime";
      });
      // dispose();
      // t.cancel();
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
        String formattedMonthDayYear = formatterMonthDayYear.format(now);
    String formattedDayOfTheWeek = formatterDayOfWeek.format(now);

    return  Column(
      children: <Widget>[
        Container(
              // color: Colors.green,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                      child: Text(
                    '$formattedDayOfTheWeek, ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 1.0),
                    child: Container(
                        child: Text(
                      formattedMonthDayYear.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
                  ),
                ],
              ),
            ),
        Container(
          // color: Colors.green,
          child: Row(
            children: <Widget>[
              Container(
                  child: Text(
                '$_timeString ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
              )),
              // // Padding(
              // //   padding: const EdgeInsets.only(bottom: 1.0),
              // //   child: Container(child: Text('(GMT -6)', style: TextStyle(fontWeight: FontWeight.bold, fontSize:20),)),
              // // ),
            ],
          ),
        ),
      ],
    );
  }
}