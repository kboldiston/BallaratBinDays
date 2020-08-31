import 'dart:convert';

import 'package:BallaratBinDays/models/bin_days.dart';
import 'package:BallaratBinDays/models/config.dart';
import 'package:BallaratBinDays/models/settings.dart';
import 'package:BallaratBinDays/widgets/navigation_drawer.dart';
import 'package:BallaratBinDays/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  Settings _settings = Settings();
  BinData _binDays = BinData();
  bool _isLoading = true;
  bool _addressFound = true;

  @override
  void initState() {
    super.initState();
    _read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Bin Days')),
        drawer: NavigationDrawer(),
        body: ListView(
          padding: new EdgeInsets.all(30.0),
          children: _getDisplay(),
        ),
        floatingActionButton: _getFloatingActionButton());
  }

  List<Widget> _getDisplay() {
    if (_isLoading) {
      return _getLoadingDisplay();
    }
    if (_addressFound) {
      return _getDisplayBinDays();
    } else {
      return _getInvalidAddress();
    }
  }

  List<Widget> _getDisplayBinDays() {
    return <Widget>[
      Center(
        child: Column(
          children: [
            Text("${_binDays.address}"),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(children: [
                Text("Your next collection is"),
                Text(
                  "${_binDays.collectionDay}",
                  style: TextStyle(fontSize: 45.0),
                  textAlign: TextAlign.center,
                ),
              ]),
            ),
            Text(
              "Put these bins out the night before",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      _binDays.binsToTakeOut(),
    ];
  }

  List<Widget> _getInvalidAddress() {
    return <Widget>[
      Column(children: [
        FaIcon(
          FontAwesomeIcons.searchLocation,
          size: 70.0,
        ),
        SizedBox(height: 10),
        Text(
          "Sorry, we were unable to find your address...",
          style: TextStyle(fontSize: 30.0),
        ),
        SizedBox(height: 10),
        Text(
          "Please update it in the settings and we'll try again!",
          style: TextStyle(fontSize: 20.0),
        ),
      ]),
    ];
  }

  Widget _getFloatingActionButton() {
    if (!_addressFound) {
      return FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/settings'),
        child: Icon(Icons.settings),
      );
    }
    return null;
  }

  List<Widget> _getLoadingDisplay() {
    return <Widget>[
      Center(
        child: Spinner(icon: FontAwesomeIcons.spinner),
      )
    ];
  }

  _read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'BinDays.address';
    _settings.address = prefs.getString(key) ?? "";

    _fetchDays();
  }

  _fetchDays() async {
    if (_settings.address.isEmpty) return null;

    String query = Config.query;
    query = query.replaceAll(
        new RegExp(r'\{1\}'), "${_settings.address.toLowerCase()}");

    String endpoint = "${Config.endpoint}${Uri.encodeComponent(query)}";
    final response = await http.get(endpoint);

    switch (response.statusCode) {
      case 200:
        setState(() => _binDays = BinData.fromJson(json.decode(response.body)));
        break;
    }

    setState(() => _addressFound = _binDays.address != null);
    setState(() => _isLoading = false);
  }
}
