import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/network.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weather_app/widgets/daily_weather.dart';
import 'package:weather_app/widgets/weather_carousel.dart';
import '../widgets/selection.dart';

class HomeScreen extends StatefulWidget {
  final weatherDetails;
  final locationName;
  HomeScreen({this.weatherDetails, this.locationName});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List weatherDetails;
  String locationName;

  void _getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    Network network = Network(
        latitude: position.latitude.toInt(),
        longitude: position.longitude.toInt());
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    this.locationName = placemark[0].name;
    weatherDetails = await network.getWeatherDetails();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    this.locationName = widget.locationName;
    weatherDetails = widget.weatherDetails;
  }

  void _onRefresh() async {
    _getLocation();
    await Future.delayed(Duration(milliseconds: 1000));
    print(weatherDetails[
            Provider.of<Selection>(context, listen: false).getSelectedItem()]
        .getId());
    _refreshController.refreshCompleted();
  }

  bool _isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Selection>(builder: (context, selection, child) {
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
                    color: Color(0xff08D6CB),
                  )
                ],
              ),
            ),
            bezierColor: Colors.white60,
            rectHeight: 90,
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        (_isNumeric(locationName)) ? '' : locationName,
                        style: GoogleFonts.comfortaa(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.black),
                      ),
                      WeatherCarousel(
                        weatherDetails: weatherDetails,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.18,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              var selectedDay = weatherDetails[index];
                              Weather currentWeather = Weather(
                                  day: selectedDay.day,
                                  dayTemperature: selectedDay.dayTemperature,
                                  nightTemperature:
                                      selectedDay.nightTemperature,
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
    });
  }
}
