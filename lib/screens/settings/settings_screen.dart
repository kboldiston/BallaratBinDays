import 'package:BallaratBinDays/models/config.dart';
import 'package:BallaratBinDays/models/settings.dart';
import 'package:BallaratBinDays/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenFormState createState() {
    return _SettingsScreenFormState();
  }
}

class _SettingsScreenFormState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final addressController = TextEditingController();

  Settings _settings = Settings();

  @override
  void initState() {
    super.initState();
    _read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Config.appTitle)),
      drawer: NavigationDrawer(),
      body: ListView(
        padding: new EdgeInsets.all(30.0),
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: "Enter your address"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onSaved: (String value) => _settings.address = value,
                  controller: addressController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        _save();
                      }
                    },
                    child: Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'BinDays.address';
    _settings.address = prefs.getString(key) ?? "";
    print('read ${_settings.address}');
    addressController.text = Uri.decodeFull(_settings.address);
  }

  _save() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'BinDays.address';
    prefs.setString(key, Uri.encodeFull(_settings.address));
    print('saved ${_settings.address}');
  }
}
