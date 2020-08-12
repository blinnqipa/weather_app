import 'dart:convert';
import 'package:flutter/cupertino.dart';
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
      if (weatherArray[i]['weather'][0]['id'] > 200 &&
          weatherArray[i]['weather'][0]['id'] < 300) {
        backgroundColor = Color(0xff01CFFF);
      } else if (weatherArray[i]['weather'][0]['id'] > 300 &&
          weatherArray[i]['weather'][0]['id'] < 400) {
        backgroundColor = Color(0xff0097a7);
      } else if (weatherArray[i]['weather'][0]['id'] > 500 &&
          weatherArray[i]['weather'][0]['id'] < 600) {
        backgroundColor = Color(0xff2196f3);
      } else if (weatherArray[i]['weather'][0]['id'] > 600 &&
          weatherArray[i]['weather'][0]['id'] < 700) {
        backgroundColor = Color(0xff01CBFF);
      } else if (weatherArray[i]['weather'][0]['id'] > 700 &&
          weatherArray[i]['weather'][0]['id'] < 800) {
        backgroundColor = Color(0xff616161);
      } else if (weatherArray[i]['weather'][0]['id'] == 800) {
        backgroundColor = Color(0xff18ffff);
      } else
        backgroundColor = Color(0xffffffff);

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
