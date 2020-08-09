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

      Weather weather = Weather(
          id: weatherArray[i]['weather'][0]['id'],
          dayTemperature: weatherArray[i]['temp']['day'].toInt(),
          nightTemperature: weatherArray[i]['temp']['night'].toInt(),
          day: weekday,
          index: i);
      weatherDetailsList.add(weather);
    }
    return weatherDetailsList;
  }
}
