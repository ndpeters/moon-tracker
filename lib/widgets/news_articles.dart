import 'dart:async';
import 'dart:convert' as convert;
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:moon_tracker/services/news_factory.dart';

String _myLat;
String _myLon;
String _cityDetails;

class MyNewsArticle extends StatefulWidget {
  final screenWidth;
  final i;

  MyNewsArticle({@required this.screenWidth, @required this.i});

  @override
  _MyNewsArticleState createState() => _MyNewsArticleState();
}

class _MyNewsArticleState extends State<MyNewsArticle> {
  String key = '0a57e72ce8474c749595f074dd00bb32';
  List<Map<String, dynamic>> articles = [
    {
      'author': '',
      'title': '',
      'description': '',
      'img': '',
      'url': '',
    },
    {
      'author': '',
      'title': '',
      'description': '',
      'img': '',
      'url': '',
    },
    {
      'author': '',
      'title': '',
      'description': '',
      'img': '',
      'url': '',
    },
    {
      'author': '',
      'title': '',
      'description': '',
      'img': '',
      'url': '',
    },
  ];
  bool requestComplete;
  Timer timer;

  @override
  initState() {
    requestComplete = false;
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (_myLat != null || _myLon != null) {
        t.cancel();
        // set state to refresh the page once location has been found
        setState(() {});
      }
      // dispose();
      // t.cancel();
    });
    _getCurrentPosition();
    super.initState();
  }

  void _getCurrentPosition() async {
    final position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    _myLat = position.latitude.toString();
    _myLon = position.longitude.toString();

    // print(position);

    /// get city name / address by location coordinates
    final coordinates =
        new Coordinates(double.parse(_myLat), double.parse(_myLon));
    final addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    final first = addresses.first;

    _cityDetails =
        '${first.locality.replaceAll(' ', '+')}&${first.adminArea.replaceAll(' ', '+')}';

    /// once the _cityDetails have been assigned, call getNews() to find articles based on city
    getNews();
  }

  getNews() async {
    // String url =
    // 'http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=$key';
    String url =
        'http://newsapi.org/v2/everything?q=${_cityDetails}&from=2020-07-08&sortBy=publishedAt&apiKey=$key';
    NewsFactory newsFactory = new NewsFactory(url);
    newsFactory.getData().then((value) {
      // print(value[0]['author']);
      articles[0] = value[0];
      articles[1] = value[1];
      articles[2] = value[2];
      articles[3] = value[3];
      // print(articles);

      requestComplete = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (requestComplete) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 3.0, 8.0, 3.0),
        child: Container(
          height: 70,
          width: widget.screenWidth - 16,
          decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: new BorderRadius.all(Radius.circular(15.0)),
              color: Colors.white.withOpacity(.30)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            //TODO: create card styles and a seperate widget
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      //! this will be the article image
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 50,
                              height: 50,
                              child: articles[widget.i]['img'] != null
                                  ? Image.network(
                                      articles[widget.i]['img'],
                                      fit: BoxFit.cover,
                                    )
                                  : Container(),
                            ),
                          ],
                        ),
                      ),
                      //! this will be the article headline + author
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0, left: 8.0),
                        child: Row(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 85,
                                  child: Text(
                                      '${articles[widget.i]['title'].toString()}',
                                      maxLines: 1,
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14)),
                                ),
                                Container(
                                  height: 25,
                                  width: 90,
                                  child: articles[widget.i]['author'] == null
                                      ? Text('Anonymous',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w300))
                                      : Text(
                                          '${articles[widget.i]['author'].toString().split(',')[0]}',
                                          maxLines: 1,
                                          softWrap: false,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 12)),
                                ),
                              ],
                            ),
                            //! this will be a small portion of the content
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 6.0),
                                  child: Container(
                                    width: widget.screenWidth / 2,
                                    child: Text(
                                      '${articles[widget.i]['description'].toString()}',
                                      style: TextStyle(fontSize: 12),
                                      maxLines: 3,
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Center(
          child: Container(
        child: Text('...'),
      ));
    }
  }
}
