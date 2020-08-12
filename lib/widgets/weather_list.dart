import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/selection.dart';

class WeatherList extends StatelessWidget {
  final List weatherDetails;
  final CarouselController carouselController;
  WeatherList({this.weatherDetails, this.carouselController});
  @override
  Widget build(BuildContext context) {
    void _changeCarouselPage(int index) {
      Provider.of<Selection>(context, listen: false).changeSelectedItem(index);
      carouselController.animateToPage(index,
          duration: Duration(milliseconds: 800),
          curve: Curves.fastLinearToSlowEaseIn);
    }

    return Consumer<Selection>(builder: (context, selection, child) {
      return Container(
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
                  nightTemperature: selectedDay.nightTemperature,
                  id: selectedDay.id);
              return Material(
                borderRadius: BorderRadius.circular(2),
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Material(
                    child: InkWell(
                      customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.161,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Column(
                              children: <Widget>[
                                Icon(FontAwesomeIcons.sun, color: Colors.black),
                                SizedBox(height: 10),
                                Text(
                                  '${currentWeather.getDayTemp()}°',
                                  style: GoogleFonts.comfortaa(
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  currentWeather.getDay().substring(0, 3),
                                  style: GoogleFonts.comfortaa(
                                      color: Colors.black, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: (Provider.of<Selection>(context)
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
                                    : BoxShadow(color: Colors.transparent),
                              ]),
                        ),
                      ),
                      onTap: () {
                        _changeCarouselPage(index);
                      },
                      borderRadius: BorderRadius.all(Radius.circular(5)),
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
      );
    });
  }
}
