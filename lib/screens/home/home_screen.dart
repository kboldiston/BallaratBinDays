import 'package:BallaratBinDays/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bin Days')),
      drawer: NavigationDrawer(),
      body: ListView(
        children: <Widget>[
          Text("Your bin day is:")
        ],
      )
    );
  }
}