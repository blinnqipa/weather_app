import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../selection.dart';

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
            child: Container(
              width: 65,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.sun,
                      color:
                          (Provider.of<Selection>(context).getSelectedItem() ==
                                  widget.index)
                              ? Colors.black
                              : null,
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${widget.temperature}°',
                      style: GoogleFonts.comfortaa(
                        color: (Provider.of<Selection>(context)
                                    .getSelectedItem() ==
                                widget.index)
                            ? Colors.black
                            : null,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.day,
                      style: GoogleFonts.comfortaa(
                        color: (Provider.of<Selection>(context)
                                    .getSelectedItem() ==
                                widget.index)
                            ? Colors.black
                            : null,
                      ),
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
          borderRadius: BorderRadius.all(
            Radius.circular(1),
          ),
        ),
      ),
    );
  }
}
//InkWell(
//splashColor: Colors.yellow,
//onTap: () {
//Provider.of<Selection>(context, listen: false)
//    .changeSelectedItem(widget.index);
//},
//child: Container(
//width: 60,
//color: Colors.transparent,
//child: Card(
//color: (Provider.of<Selection>(context).getSelectedItem() ==
//widget.index)
//? Colors.white
//    : Colors.transparent,
//child: Padding(
//padding: const EdgeInsets.all(8.0),
//child: Column(
//children: <Widget>[
//Icon(
//FontAwesomeIcons.sun,
//color:
//(Provider.of<Selection>(context).getSelectedItem() ==
//widget.index)
//? Colors.black
//    : null,
//),
//SizedBox(height: 10),
//Text(
//'${widget.temperature}°',
//style: GoogleFonts.comfortaa(
//color: (Provider.of<Selection>(context)
//.getSelectedItem() ==
//widget.index)
//? Colors.black
//    : null,
//),
//),
//SizedBox(height: 10),
//Text(
//widget.day,
//style: GoogleFonts.comfortaa(
//color: (Provider.of<Selection>(context)
//.getSelectedItem() ==
//widget.index)
//? Colors.black
//    : null,
//),
//),
//],
//),
//),
//),
//),
//)
