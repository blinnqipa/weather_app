import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/services/network.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  final weatherId;
  final weatherTemp;
  final weekdayList;
  HomeScreen({this.weatherId, this.weatherTemp, this.weekdayList});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  var weatherId;
  List weatherTemp;
  List weekdayList;

  void getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    Network network = Network(
        latitude: position.latitude.toInt(),
        longitude: position.longitude.toInt());
    weatherId = await network.idAndDateList();
    weatherTemp = await network.temperatureList();
    weekdayList = await network.weekdayList();

    print('called getLocation');
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weatherId = widget.weatherId;
    weatherTemp = widget.weatherTemp;
    weekdayList = widget.weekdayList;
  }

  void _onRefresh() async {
    getLocation();
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          '${weatherTemp.elementAt(0)}',
                          style: GoogleFonts.comfortaa(
                            fontSize: 140,
                            fontWeight: FontWeight.w100,
                            letterSpacing: -10.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 108.0),
                          child: Text(
                            '°',
                            style: GoogleFonts.comfortaa(fontSize: 80),
                          ),
                        )
                      ],
                    ),
                    Text(
                      weekdayList.elementAt(0),
                      style: GoogleFonts.comfortaa(fontSize: 20),
                    ),
                    Container(
                      width: 250,
                      height: 250,
                      color: Colors.yellow,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.09,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Text('w');
                        },
                        itemCount: weekdayList.length,
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
