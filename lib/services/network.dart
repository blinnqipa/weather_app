import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weather_app/common/common_data.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather.dart';

class Network {
  var apiUrl;

  var latitude;
  var longitude;

  Network({this.latitude, this.longitude}) {
    apiUrl =
        'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&%20exclude=minutely,daily&units=metric&appid=$apiKey';
  }

  Color getBackgroundColor(int weatherId) {
    if (weatherId >= 200 && weatherId < 300) {
      return Colors.yellow;
    } else if (weatherId >= 300 && weatherId > 400) {
      return Colors.green;
    } else if (weatherId >= 500 && weatherId > 600) {
      return Colors.blue;
    } else if (weatherId >= 600 && weatherId > 700) {
      return Colors.white;
    } else if (weatherId >= 700 && weatherId > 800) {
      return Colors.black;
    } else if (weatherId == 800) {
      return Colors.purple;
    } else if (weatherId > 800) {
      return Colors.blueGrey;
    } else
      return Colors.deepOrange;
  }

  Future<List> getWeatherDetails() async {
    var request = await http.get(apiUrl);
    var decodedJson = jsonDecode(request.body);
    var weatherArray = decodedJson['daily'];
    var weatherDetailsList = List();

    for (int i = 0; i < 5; i++) {
      var weekday;
      var backgroundColor;
      switch (DateTime.fromMillisecondsSinceEpoch(weatherArray[i]['dt'] * 1000)
          .weekday) {
        case 1:
          weekday = 'MONDAY';
          break;
        case 2:
          weekday = 'TUESDAY';
          break;
        case 3:
          weekday = 'WEDNESDAY';
          break;
        case 4:
          weekday = 'THURSDAY';
          break;
        case 5:
          weekday = 'FRIDAY';
          break;
        case 6:
          weekday = 'SATURDAY';
          break;
        case 7:
          weekday = 'SUNDAY';
          break;
      }
      backgroundColor =
          getBackgroundColor(weatherArray[i]['weather'][0]['id'].toInt());

      Weather weather = Weather(
          id: weatherArray[i]['weather'][0]['id'],
          dayTemperature: weatherArray[i]['temp']['day'].toInt(),
          nightTemperature: weatherArray[i]['temp']['night'].toInt(),
          day: weekday,
          index: i,
          backgroundColor: backgroundColor);
      weatherDetailsList.add(weather);
    }
    return weatherDetailsList;
  }
}
