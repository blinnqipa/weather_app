import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/network.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weather_app/widgets/daily_weather.dart';
import 'package:weather_app/widgets/weather_carousel.dart';
import 'package:weather_app/widgets/weather_icon.dart';
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

  CarouselController carouselController = CarouselController();

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
                      CarouselSlider(
                        carouselController: carouselController,
                        options: CarouselOptions(
                            initialPage: 0,
                            onPageChanged: (pageNo, reason) {
                              selection.changeSelectedItem(pageNo);
                            },
                            height: MediaQuery.of(context).size.height * 0.629),
                        items: weatherDetails.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                color: Colors.transparent,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '${i.getDayTemp()}',
                                          style: GoogleFonts.comfortaa(
                                            fontSize: 140,
                                            fontWeight: FontWeight.w300,
                                            letterSpacing: -10.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 100.0),
                                          child: Text(
                                            '°',
                                            style: GoogleFonts.comfortaa(
                                                fontSize: 80,
                                                color: Colors.black),
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      width: 200,
                                      height: 200,
                                      child: WeatherIcon(
                                        weatherId: i.getId(),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.07),
                                    Text(
                                      i.getDay(),
                                      style: GoogleFonts.comfortaa(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }).toList(),
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
                              return Material(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.transparent,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Material(
                                    child: InkWell(
                                      customBorder: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 3.0),
                                        child: Container(
                                          width: 60,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 18.0),
                                            child: Column(
                                              children: <Widget>[
                                                Icon(FontAwesomeIcons.sun,
                                                    color: Colors.black),
                                                SizedBox(height: 10),
                                                Text(
                                                  '${currentWeather.getDayTemp()}°',
                                                  style: GoogleFonts.comfortaa(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  currentWeather
                                                      .getDay()
                                                      .substring(0, 3),
                                                  style: GoogleFonts.comfortaa(
                                                      color: Colors.black,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: (Provider.of<Selection>(
                                                              context)
                                                          .getSelectedItem() ==
                                                      selectedDay.index)
                                                  ? Colors.white
                                                  : Colors.transparent,
                                              boxShadow: [
                                                (Provider.of<Selection>(context)
                                                            .getSelectedItem() ==
                                                        selectedDay.index)
                                                    ? BoxShadow(
                                                        color: Colors.black12,
                                                        offset: Offset(1, 1),
                                                        blurRadius: 10)
                                                    : BoxShadow(
                                                        color:
                                                            Colors.transparent),
                                              ]),
                                        ),
                                      ),
                                      onTap: () {
                                        //TODO: local function
                                        Provider.of<Selection>(context,
                                                listen: false)
                                            .changeSelectedItem(
                                                selectedDay.index);
                                        carouselController.animateToPage(index,
                                            duration:
                                                Duration(milliseconds: 800),
                                            curve:
                                                Curves.fastLinearToSlowEaseIn);
                                      },
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      splashColor: Colors.white30,
                                    ),
                                    color: Colors.transparent,
                                  ),
                                ),
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
