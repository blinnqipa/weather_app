import 'package:weather_app/common/common_data.dart';
import 'package:http/http.dart' as http;

class Network {
  var apiUrl = 'http://api.openweathermap.org/data/2.5/weather?';
  var latitude;
  var longitude;

  Network({this.latitude, this.longitude});

  Future<void> parseJson() async {
    var request =
        await http.get(apiUrl + 'lat=$latitude&lon=$longitude&appid=$apiKey');
    print(request.body);
  }
}
