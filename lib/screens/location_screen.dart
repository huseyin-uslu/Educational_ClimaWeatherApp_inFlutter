import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({@required this.weatherData});
  final weatherData; //dynamic

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  bool loading;
  WeatherModel weather = WeatherModel();
  int temp;
  String weatherIcon;
  String weatherMessage;
  String cityName;

  @override
  void initState() {
    updateUI(widget.weatherData);
    loading = false;
    super.initState();
  }

  void updateUI(dynamic weatherData) {
    var cod = weatherData["cod"];
    var message = weatherData["message"];

    if (weatherData == null || cod == "404") {
      temp = 0;
      weatherIcon = "";
      weatherMessage = message != null ? "$message" : "Couldn't find location";
      cityName = "";
      loading = false;
      setState(() {
        loading = false;
      });
      return;
    }
    var temperature = weatherData["main"]["temp"];
    temp = temperature.toInt();

    var condition = weatherData["weather"][0]["id"];
    weatherIcon = weather.getWeatherIcon(condition);
    weatherMessage = weather.getMessage(temp);

    cityName = weatherData["name"];
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      updateUI(await WeatherModel().getCurrentWeatherData());
                      //this is done in callaboration with loading that is false
                      // so if you use it in a set state statement ,
                      // you will get failed.
                    },
                    child: loading
                        ? kLoadingCircle
                        : Icon(
                            Icons.near_me,
                            size: 50.0,
                          ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return CityScreen();
                      }));
                      setState(() {
                        loading = true;
                      });
                      if (typedName != null &&
                          typedName.toString().isNotEmpty) {
                        updateUI(await weather.getWeatherByCityName(
                            cityName: typedName));
                      } else {
                        updateUI(jsonDecode(failedJSNotation));
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
