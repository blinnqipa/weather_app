import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/network.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weather_app/widgets/daily_weather.dart';
import 'package:weather_app/widgets/weather_icon.dart';

import '../selection.dart';

class HomeScreen extends StatefulWidget {
  final weatherDetails;
  HomeScreen({this.weatherDetails});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  var weatherId;
  List weatherDetails;

  void getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    Network network = Network(
        latitude: position.latitude.toInt(),
        longitude: position.longitude.toInt());
    weatherDetails = await network.getWeatherDetails();
    print('called getLocation');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    weatherDetails = widget.weatherDetails;
  }

  void _onRefresh() async {
    getLocation();
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff08D6CB),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        enablePullDown: true,
        header: BezierHeader(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.refresh,
                  size: 35,
                  color: Theme.of(context).primaryColor,
                )
              ],
            ),
          ),
          bezierColor: Colors.yellow,
          rectHeight: 90,
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${weatherDetails[Provider.of<Selection>(context).getSelectedItem()].getDayTemp()}',
                          style: GoogleFonts.comfortaa(
                              fontSize: 140,
                              fontWeight: FontWeight.w100,
                              letterSpacing: -10.0,
                              color: Colors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: Text(
                            '°',
                            style: GoogleFonts.comfortaa(
                                fontSize: 80, color: Colors.black),
                          ),
                        )
                      ],
                    ),
                    Text(
                      weatherDetails[
                              Provider.of<Selection>(context).getSelectedItem()]
                          .getDay(),
                      style: GoogleFonts.comfortaa(
                          fontSize: 20, color: Colors.black),
                    ),
                    Container(
                      width: 250,
                      height: 250,
                      child: Center(
                        child: WeatherIcon(
                          weatherId: weatherDetails[
                                  Provider.of<Selection>(context)
                                      .getSelectedItem()]
                              .getDayTemp(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.14,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          var selectedDay = weatherDetails[index];
                          Weather currentWeather = Weather(
                              day: selectedDay.day,
                              dayTemperature: selectedDay.dayTemperature,
                              nightTemperature: selectedDay.nightTemperature,
                              id: selectedDay.id);
                          return DailyWeather(
                            day: currentWeather.day,
                            id: currentWeather.id,
                            temperature: currentWeather.getDayTemp(),
                            index: index,
                          );
                        },
                        itemCount: weatherDetails.length,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
