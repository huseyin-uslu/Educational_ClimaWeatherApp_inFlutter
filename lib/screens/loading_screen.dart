import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/networking.dart';
import 'location_screen.dart';

//url:https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=c31cbf12a81700fc3e60218d4b565e0d
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    NetworkHelper networkHelper = NetworkHelper();
    var weatherData = await networkHelper.getDataForCurrentLocation();

    Navigator.push(
      this.context,
      MaterialPageRoute(
          builder: (context) => LocationScreen(
                weatherData: weatherData,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: Center(child: kLoadingCircle),
    );
  }
}
