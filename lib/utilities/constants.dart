import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 75.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 45.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 75.0,
);

const String kAPI_KEY = "c31cbf12a81700fc3e60218d4b565e0d";

const SpinKitSpinningLines kLoadingCircle = SpinKitSpinningLines(
  color: Colors.white,
  size: 75.0,
);

const InputDecoration kInputTextFieldDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  fillColor: Colors.white,
  filled: true,
  icon: Icon(Icons.location_city, color: Colors.white),
  hintText: "Enter City Name",
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
);

const String failedJSNotation =
    "{\"cod\":\"404\",\"message\":\"city not found\"}";
