class Weather {
  int id;
  String day;
  int dayTemperature;

  int nightTemperature;

  int getDayTemp() => dayTemperature;

  String getDay() => day;

  Weather({this.id, this.day, this.dayTemperature, this.nightTemperature});
}
