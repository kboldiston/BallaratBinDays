import 'package:BallaratBinDays/screens/home/home_screen.dart';
import 'package:BallaratBinDays/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';

import 'models/config.dart';

void main() {
  runApp(BinDays());
}

class BinDays extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Config.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/settings': (context) => SettingsScreen(),
        // '/punching': (context) => PunchScreen()
      }
    );
  }
}
