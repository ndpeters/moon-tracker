import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_icons/weather_icons.dart';

enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }

String _myLat;
String _myLon;
String _address;
String _cityDetails;
String _country;

class MyLocation extends StatefulWidget {
  @override
  _MyLocationState createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              // color: Colors.green,
              child: _myLat != null
                  ? Text(
                      'Lat: $_myLat, Lon: $_myLon',
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                    )
                  : Text('Loading...',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              // color: Colors.green,
              child: _cityDetails != null
                  ? Text(
                      '$_cityDetails',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      textAlign: TextAlign.start,
                    )
                  : Text('Loading...',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
          ],
        ),
        MyWeather(),
      ],
    );
  }
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

  _address = '${first.subThoroughfare} ${first.thoroughfare}';
  _cityDetails = '${first.locality}, ${first.adminArea}';
// _cityDetails = '${first.locality}, ${first.adminArea} ${first.postalCode}';
  _country = '${first.countryName}';

  // print("${first.subThoroughfare} ${first.thoroughfare}\n${first.locality}, ${first.adminArea} ${first.postalCode} \n${first.countryName}");

  // print("${first.locality}, ${first.adminArea}, ${first.countryName}");
  // print("${first.addressLine.replaceFirst(',', '\n').trimRight()}");
}

class MyWeather extends StatefulWidget {
  @override
  _MyWeatherState createState() => _MyWeatherState();
}

class _MyWeatherState extends State<MyWeather> {
  Timer timer;
  String key = '856822fd8e22db5e1ba48c0e7d69844a';
  WeatherFactory ws;
  List<Weather> _data = [];
  String _jmsSunrise;
  String _jmsSunset;
  AppState _state = AppState.NOT_DOWNLOADED;

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (_myLat.isNotEmpty || _myLon.isNotEmpty) {
        t.cancel();
        // set state to refresh the page once location has been found
        setState(() {});
        queryWeather();
      }
      // dispose();
      // t.cancel();
    });
    super.initState();
    ws = new WeatherFactory(key);
  }

  void queryForecast() async {
    /// Removes keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _state = AppState.DOWNLOADING;
    });

    List<Weather> forecasts = await ws.fiveDayForecastByLocation(
        double.parse(_myLat), double.parse(_myLon));
    setState(() {
      _data = forecasts;
      _state = AppState.FINISHED_DOWNLOADING;
    });
  }

  Widget contentDownloading() {
    return Container(
        child: Column(children: [
      Text(
        '\nFetching Weather...',
        style: TextStyle(fontSize: 20),
      ),
      Container(
          child: Center(child: CircularProgressIndicator(strokeWidth: 10)))
    ]));
  }

  Widget contentNotDownloaded() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '\nFetching Weather...',
          ),
        ],
      ),
    );
  }

  void queryWeather() async {
    /// Removes keyboard
    FocusScope.of(context).requestFocus(FocusNode());

    setState(() {
      _state = AppState.DOWNLOADING;
    });

    Weather weather = await ws.currentWeatherByLocation(
        double.parse(_myLat), double.parse(_myLon));
    setState(() {
      _data = [weather];
      _jmsSunrise =
          DateFormat("jms").format(DateTime.parse('${_data[0].sunrise}'));
      _jmsSunset =
          DateFormat("jms").format(DateTime.parse('${_data[0].sunset}'));

      _state = AppState.FINISHED_DOWNLOADING;
      // print(_data);
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(_data);

    return _state == AppState.FINISHED_DOWNLOADING
        ? Column(
            children: <Widget>[
              Container(
                // color: Colors.green,
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Container(
                          width: 60,
                          child: Image.network(
                              'http://openweathermap.org/img/wn/${_data[0].weatherIcon}@2x.png')),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${_data[0].temperature}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          Text(
                            '${_data[0].weatherDescription}',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 15),
                          ),
                        ],
                      ),
                    ),

                    /// sunrise and sunset
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Container(
                    width: 70,
                    child: Text(
                      'Sunrise: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                        //color: Colors.green,
                        child: Text(
                      '${_jmsSunrise}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 70,
                    child: Text(
                      'Sunset: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                        // color: Colors.green,
                        child: Text(
                      '${_jmsSunset}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
                  ),
                  // FloatingActionButton(
                  //     foregroundColor: Colors.black,
                  //     backgroundColor: Colors.white.withAlpha(105),
                  //     child: Container(
                  //       child: Icon(Icons.refresh),
                  //     ),
                  //     onPressed: () {
                  //       queryWeather();
                  //     }),
                ],
              ),
            ],
          )
        : _state == AppState.DOWNLOADING
            ? contentDownloading()
            : contentNotDownloaded();
  }
}
