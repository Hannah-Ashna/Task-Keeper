import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PetDataModel {
  final String title;
  final int value;
  final charts.Color barColor;
  final charts.Color bgColor = charts.ColorUtil.fromDartColor(Colors.red);

  PetDataModel(
      {@required this.title,
        @required this.value,
        @required this.barColor});
}