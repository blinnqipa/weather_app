import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DailyWeather extends StatelessWidget {
  final int temperature;
  final int id;
  final String day;

  DailyWeather({this.temperature, this.id, this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: <Widget>[
          Icon(FontAwesomeIcons.sun),
          SizedBox(height: 10),
          Text('$temperature°'),
          SizedBox(height: 10),
          Text(day),
        ],
      ),
    );
  }
}
