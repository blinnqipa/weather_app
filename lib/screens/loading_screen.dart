import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/services/network.dart';
import 'home_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  List weatherDetails;

  void getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    Network network = Network(
        latitude: position.latitude.toInt(),
        longitude: position.longitude.toInt());
    weatherDetails = await network.getWeatherDetails();
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          weatherDetails: weatherDetails,
          locationName: placemark[0].name,
        ),
      ),
    );
    print('called getLocation');
    setState(() {});
  }

  Future<String> getAddress() async {}

  @override
  void initState() {
    super.initState();
    getLocation();
    getAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitPulse(
              color: Colors.yellow,
            ),
            Text(
              'getting location...',
              style: GoogleFonts.comfortaa(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
