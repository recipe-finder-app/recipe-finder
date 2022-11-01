import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/border_constant.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';

enum CircularBottomSheetHeight {
  short,
  standard,
  high,
  full,
}

class CircularBottomSheet {
  static CircularBottomSheet instance = CircularBottomSheet._init();
  CircularBottomSheet._init();
  Future<void> show(context,
      {required Widget child,
      CircularBottomSheetHeight? bottomSheetHeight,
      bool? resizeToAvoidBottomInset}) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderConstant.instance.radiusAllCircularHigh),
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            bottom: resizeToAvoidBottomInset == true
                ? MediaQuery.of(context).viewInsets.bottom
                : 0),
        child: SizedBox(
          height: bottomSheetHeight == CircularBottomSheetHeight.short
              ? context.screenHeight / 2
              : bottomSheetHeight == CircularBottomSheetHeight.full
                  ? context.screenHeight
                  : bottomSheetHeight == CircularBottomSheetHeight.high
                      ? context.screenHeight / 1.1
                      : context.screenHeight / 1.2,
          child: Padding(
            padding: resizeToAvoidBottomInset == true
                ? context.paddingMediumOnlyTop
                : context.paddingMediumTopBottom,
            child: Center(
              child: Padding(padding: context.paddingMediumEdges, child: child),
            ),
          ),
        ),
      ),
    );
  }
}
