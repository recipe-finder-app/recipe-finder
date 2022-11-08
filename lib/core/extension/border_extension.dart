import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BorderConstant {
  static BorderConstant instance = BorderConstant._init();
  BorderConstant._init();

  final radiusAllCircularHigh = const BorderRadius.only(
    topLeft: Radius.circular(35),
    topRight: Radius.circular(35),
  );
}
