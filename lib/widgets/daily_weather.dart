import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'selection.dart';

class DailyWeather extends StatefulWidget {
  final int temperature;
  final int id;
  final String day;
  final int index;

  DailyWeather({this.temperature, this.id, this.day, this.index});

  @override
  _DailyWeatherState createState() => _DailyWeatherState();
}

class _DailyWeatherState extends State<DailyWeather> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(2),
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.only(left: 10),
        child: Material(
          child: InkWell(
            customBorder:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 3.0),
              child: Container(
                width: 60,
                child: Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Column(
                    children: <Widget>[
                      Icon(FontAwesomeIcons.sun, color: Colors.black),
                      SizedBox(height: 10),
                      Text(
                        '${widget.temperature}°',
                        style: GoogleFonts.comfortaa(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.day.substring(0, 3),
                        style: GoogleFonts.comfortaa(
                            color: Colors.black, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: (Provider.of<Selection>(context).getSelectedItem() ==
                            widget.index)
                        ? Colors.white
                        : Colors.transparent,
                    boxShadow: [
                      (Provider.of<Selection>(context).getSelectedItem() ==
                              widget.index)
                          ? BoxShadow(
                              color: Colors.black12,
                              offset: Offset(1, 1),
                              blurRadius: 10)
                          : BoxShadow(color: Colors.transparent),
                    ]),
              ),
            ),
            onTap: () {
              Provider.of<Selection>(context, listen: false)
                  .changeSelectedItem(widget.index);
            },
            borderRadius: BorderRadius.all(Radius.circular(5)),
            splashColor: Colors.white30,
          ),
          color: Colors.transparent,
        ),
      ),
    );
  }
}
