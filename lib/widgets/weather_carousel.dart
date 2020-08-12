import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/services/selection.dart';
import 'package:weather_app/widgets/weather_icon.dart';

class WeatherCarousel extends StatelessWidget {
  final List weatherDetails;
  final CarouselController carouselController;
  WeatherCarousel({this.weatherDetails, this.carouselController});
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController: carouselController,
      options: CarouselOptions(
          onPageChanged: (pageNo, reason) {
            Provider.of<Selection>(context, listen: false)
                .changeSelectedItem(pageNo);
          },
          height: MediaQuery.of(context).size.height * 0.63),
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
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        padding: const EdgeInsets.only(top: 100.0),
                        child: Text(
                          '°',
                          style: GoogleFonts.comfortaa(
                              fontSize: 80, color: Colors.black),
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),
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
    );
  }
}
