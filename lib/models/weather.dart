import 'package:flutter/material.dart';

class Weather {
  int id;
  String day;
  int dayTemperature;
  int nightTemperature;
  int index;
  Color backgroundColor;

  Weather({
    this.id = 100,
    this.day,
    this.dayTemperature,
    this.nightTemperature,
    this.index,
    this.backgroundColor,
  });

  int getDayTemp() => dayTemperature;

  String getDay() => day;

  int getId() => this.id;

  Color getColor() => this.backgroundColor;
}
