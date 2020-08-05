import 'dart:convert';
import 'package:weather_app/common/common_data.dart';
import 'package:http/http.dart' as http;

class Network {
  var apiUrl;

  var latitude;
  var longitude;

  Network({this.latitude, this.longitude}) {
    apiUrl =
        'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&%20exclude=minutely,daily&units=metric&appid=$apiKey';
  }

  Future<List> returnWeatherIdAndDate() async {
    var request = await http.get(apiUrl);
    var decodedJson = jsonDecode(request.body);
    var weatherArray = decodedJson['daily'];
    var dailyWeatherIdList = List();
    var weekdayArray = List();

    for (int i = 0; i < 8; i++) {
      var weekday;
      dailyWeatherIdList.add(weatherArray[i]['weather'][0]['id']);
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
      weekdayArray.add(weekday);
      print(dailyWeatherIdList.elementAt(i));
    }
    print(weekdayArray);
//    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
//    print(weatherArray);

    return dailyWeatherIdList;
  }

  Future<int> returnWeatherTemp() async {
    var request = await http.get(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&%20exclude=minutely,daily&units=metric&appid=52c1d862c3051641d2f1eb05dbdae674');
    var decodedJson = jsonDecode(request.body);
    var weatherArray = decodedJson['daily'];
    var dailyWeatherDayTempList = List();
    var dailyWeatherNightTempList = List();
    for (int i = 0; i < 8; i++) {
      dailyWeatherDayTempList.add(weatherArray[i]['temp']['day']);
      dailyWeatherNightTempList.add(weatherArray[i]['temp']['night']);
      print(dailyWeatherDayTempList.elementAt(i));
      print(dailyWeatherNightTempList.elementAt(i));
    }
    return null;
  }
}
