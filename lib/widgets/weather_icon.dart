import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WeatherIcon extends StatelessWidget {
  final int weatherId;
  WeatherIcon({this.weatherId});

  IconData icon(int id) {
    if (id > 200 && id < 300) {
      return FontAwesomeIcons.bolt;
    } else if (id > 300 && id < 400) {
      return FontAwesomeIcons.smog;
    } else if (id > 500 && id < 600) {
      return FontAwesomeIcons.cloudRain;
    } else if (id > 600 && id < 700) {
      return FontAwesomeIcons.snowflake;
    } else if (id > 700 && id < 800) {
      return FontAwesomeIcons.wind;
    } else if (id == 800) {
      return FontAwesomeIcons.solidSun;
    } else
      return FontAwesomeIcons.cloud;
  }

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon(weatherId),
      size: 150,
    );
  }
}
