import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/services/network.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weather_app/widgets/weather_carousel.dart';
import 'package:weather_app/widgets/weather_list.dart';
import 'package:weather_app/services/selection.dart';

class HomeScreen extends StatefulWidget {
  final weatherDetails;
  final locationName;
  final backgroundColor;
  HomeScreen({this.weatherDetails, this.locationName, this.backgroundColor});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  CarouselController carouselController = CarouselController();
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
    return Consumer<Selection>(
      builder: (context, selection, child) {
        return Scaffold(
          backgroundColor: widget.backgroundColor,
          body: SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            enablePullDown: true,
            header: BezierHeader(
              child: Center(
                child: Icon(
                  Icons.refresh,
                  size: 35,
                  color: Colors.black,
                ),
              ),
              bezierColor: Colors.white,
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
                          carouselController: carouselController,
                          weatherDetails: weatherDetails,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.07),
                        Center(
                          child: WeatherList(
                            weatherDetails: weatherDetails,
                            carouselController: carouselController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
