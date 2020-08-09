class Weather {
  int id;
  String day;
  int dayTemperature;

  int nightTemperature;

  int index;

  int getDayTemp() => dayTemperature;

  String getDay() => day;

  int getId() {
    return this.id;
  }

  Weather(
      {this.id = 100,
      this.day,
      this.dayTemperature,
      this.nightTemperature,
      this.index});
}
