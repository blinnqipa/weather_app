import 'dart:convert';
import 'package:weather_app/common/common_data.dart';
import 'package:http/http.dart' as http;
import 'file:///C:/Users/blinn/AndroidStudioProjects/weather_app/lib/models/weather.dart';

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

    for (int i = 0; i < 8; i++) {
      var weekday;
      switch (DateTime.fromMillisecondsSinceEpoch(weatherArray[i]['dt'] * 1000)
          .weekday) {
        case 1:
          weekday = 'Mon';
          break;
        case 2:
          weekday = 'Tue';
          break;
        case 3:
          weekday = 'Wed';
          break;
        case 4:
          weekday = 'Thu';
          break;
        case 5:
          weekday = 'Fri';
          break;
        case 6:
          weekday = 'Sat';
          break;
        case 7:
          weekday = 'Sun';
          break;
      }

      Weather weather = Weather(id:weatherArray[i]['weather'][0]['id'], dayTemperature:weatherArray[i]['temp']['day'].toInt(), nightTemperature: weatherArray[i]['temp']['night'].toInt(),day: weekday);
      weatherDetailsList.add(weather);
    }
    return weatherDetailsList;
  }

}
