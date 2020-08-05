import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DailyWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: <Widget>[
          Icon(FontAwesomeIcons.sun),
          SizedBox(height: 10),
          Text('25°'),
          SizedBox(height: 10),
          Text('Thur'),
        ],
      ),
    );
  }
}
