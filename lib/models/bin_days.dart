import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'bin_type.dart';

class BinData {
  final String address;
  final String collectionDay;
  final DateTime nextGreen;
  final DateTime nextWaste;
  final DateTime nextRecycle;
  final String helpLink;

  BinData({
    this.address,
    this.collectionDay,
    this.nextGreen,
    this.nextWaste,
    this.nextRecycle,
    this.helpLink,
  });

  factory BinData.fromJson(Map<String, dynamic> json) {
    String helpLink = json['help'];

    if (json['result']['records'].length == 0)
      return new BinData(helpLink: helpLink);

    return BinData(
      address: json['result']['records'][0]['address'],
      collectionDay:
          json['result']['records'][0]['collectionday'].split(" ")[0],
      nextGreen: toDate(json['result']['records'][0]['nextgreen']),
      nextWaste: toDate(json['result']['records'][0]['nextwaste']),
      nextRecycle: toDate(json['result']['records'][0]['nextrecycle']),
      helpLink: helpLink,
    );
  }

  static DateTime toDate(String dateString) {
    return DateFormat("dd-MM-yyyy").parse(dateString);
  }

  Widget binsToTakeOut() {
    if (address == null) {
      return new Column();
    }
    List<BinType> binTypes = new List<BinType>();

    binTypes.add(new WasteBinType());

    BinType otherBin =
        nextWaste == nextRecycle ? new RecycleBinType() : new GreenBinType();
    binTypes.add(otherBin);

    List<Widget> binIcons =
        binTypes.map((BinType bin) => bin.getIcon()).toList();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: binIcons,
    );
  }
}
