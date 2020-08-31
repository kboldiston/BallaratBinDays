import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'bin_type.dart';

class RecyleBinType implements BinType {
  Widget getIcon() {
    return FaIcon(FontAwesomeIcons.recycle);
  }
}
