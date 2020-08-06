import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screens/loading_screen.dart';
import 'selection.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Selection(),
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(accentColor: Colors.yellow),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => LoadingScreen(),
        },
      ),
    );
  }
}
