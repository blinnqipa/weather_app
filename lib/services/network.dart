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

  Future<List> idAndDateList() async {
    var request = await http.get(apiUrl);
    var decodedJson = jsonDecode(request.body);
    var weatherArray = decodedJson['daily'];
    var idList = List();

    for (int i = 0; i < 8; i++) {
      idList.add(weatherArray[i]['weather'][0]['id']);
    }
    return idList;
  }

  Future<List> weekdayList() async {
    var request = await http.get(apiUrl);
    var decodedJson = jsonDecode(request.body);
    var weatherArray = decodedJson['daily'];
    var weekdayList = List();
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
      weekdayList.add(weekday);
    }
    return weekdayList;
  }

  Future<List> temperatureList() async {
    var request = await http.get(apiUrl);
    var decodedJson = jsonDecode(request.body);
    var weatherArray = decodedJson['daily'];
    var dayTempList = List();
    for (int i = 0; i < 8; i++) {
      dayTempList.add(weatherArray[i]['temp']['day'].toInt());
//      dailyWeatherNightTempList.add(weatherArray[i]['temp']['night']);
//      print(dailyWeatherDayTempList.elementAt(i));
//      print(dailyWeatherNightTempList.elementAt(i));
    }
    return dayTempList;
  }
}
