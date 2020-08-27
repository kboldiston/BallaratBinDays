import 'package:BallaratBinDays/models/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  List<Widget> listItems(BuildContext context) {
    return <Widget> [
      DrawerHeader(
        child: Text(
          Config.appTitle,
          style: TextStyle(fontSize: 24)          
        )
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text('Home'),
        onTap: () => Navigator.pushNamed(context, '/'),
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text('Settings'),
        onTap: () => Navigator.pushNamed(context, '/settings'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: listItems(context),
      )
    );
  }
}