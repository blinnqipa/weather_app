import 'dart:convert';

import 'package:weather_app/common/common_data.dart';
import 'package:http/http.dart' as http;

class Network {
  var apiUrl = 'http://api.openweathermap.org/data/2.5/weather?';
  var latitude;
  var longitude;

  Network({this.latitude, this.longitude});

  Future<int> parseJson() async {
    var request = await http.get(
        apiUrl + 'lat=$latitude&lon=$longitude&units=metric&appid=$apiKey');
    var decodedJson = jsonDecode(request.body);
    var weatherId = decodedJson['weather'][0]['id'];
    print(decodedJson['weather'][0]['id']);
    return weatherId;
  }
}
