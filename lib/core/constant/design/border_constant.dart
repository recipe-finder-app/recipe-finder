import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BorderConstant {
  static BorderConstant instance = BorderConstant._init();
  BorderConstant._init();

  final radiusAllCircularMin = BorderRadius.circular(10.0);
  final radiusAllCircularMedium = BorderRadius.circular(15.0);
  final radiusAllCircularHigh = BorderRadius.circular(35.0);
  final radiusAllCircularVeryHigh = BorderRadius.circular(50.0);
}
