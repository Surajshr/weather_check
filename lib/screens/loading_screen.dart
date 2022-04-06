import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../services/location.dart';

const apiKey = "00f2f5b85d1ad2d8b1a081ffc873199b";

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longitude;

  void getLocation() async {
    location newLocation = location();
    await newLocation.getCurrentLocation();
    latitude = newLocation.latitude;
    longitude = newLocation.longitude;
    getData();
  }

  void getData() async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);

      double cityTemprature = decodedData['main']['temp'];
      int weatherCondition = decodedData['weather'][0]['id'];
      String cityName = decodedData['name'];

      print(cityTemprature);
      print(weatherCondition);
      print(cityName);
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {

    String myMargin = '15';
    double? myMarginAsADouble;
    try {
      myMarginAsADouble = double.parse(myMargin);
    } catch (e) {
      print(e);
    }

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(myMarginAsADouble ?? 45),
        color: Colors.red,
      ),
    );
  }
}
