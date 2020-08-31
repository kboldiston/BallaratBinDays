import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

abstract class BinType {
  Widget getIcon();
}

class WasteBinType implements BinType {
  Widget getIcon() {
    return Column(
      children: [
        FaIcon(
          FontAwesomeIcons.trash,
          size: 70.0,
        ),
        Text(
          "Waste",
          style: TextStyle(fontSize: 20.0),
        ),
      ],
    );
  }
}

class RecycleBinType implements BinType {
  Widget getIcon() {
    return Column(
      children: [
        FaIcon(
          FontAwesomeIcons.recycle,
          size: 70.0,
          color: Colors.blue,
        ),
        Text(
          "Recycling",
          style: TextStyle(fontSize: 20.0),
        ),
      ],
    );
  }
}

class GreenBinType implements BinType {
  Widget getIcon() {
    return Column(
      children: [
        FaIcon(
          FontAwesomeIcons.tree,
          size: 70.0,
          color: Colors.green,
        ),
        Text(
          "Green",
          style: TextStyle(fontSize: 20.0),
        ),
      ],
    );
  }
}
