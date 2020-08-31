import 'dart:convert';

import 'package:BallaratBinDays/models/bin_days.dart';
import 'package:BallaratBinDays/models/config.dart';
import 'package:BallaratBinDays/models/settings.dart';
import 'package:BallaratBinDays/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
          children: <Widget>[
            Text("Your bin day is: ${_binDays.collectionDay}"),
            Text("Next waste collection: ${_binDays.nextWaste}"),
            Text("Next recycle collection: ${_binDays.nextRecycle}"),
            Text("Next green collection: ${_binDays.nextGreen}"),
          ],
        ));
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
  }
}
