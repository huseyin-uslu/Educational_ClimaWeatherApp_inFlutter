import 'dart:convert';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima/utilities/constants.dart' as constants;
import 'package:http/http.dart' as http;

class NetworkHelper {
  Future getDataByCityName({String cityName}) async {
    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?" +
            "q=$cityName" +
            "&appid=$kAPI_KEY" +
            "&units=metric"));

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    }
    {
      return jsonDecode(constants.failedJSNotation);
    }
  }

  Future getDataForCurrentLocation() async {
    Location location = Location();
    Position position = await location.getCurrentLocation();

    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?" +
            "lat=${position.latitude}" +
            "&lon=${position.longitude}" +
            "&appid=$kAPI_KEY" +
            "&units=metric"));

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      return jsonDecode(constants.failedJSNotation);
    }
  }
}
