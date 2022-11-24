import 'package:flutter/material.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';

import '../../../core/extension/border_extension.dart';

enum CircularBottomSheetHeight {
  short,
  standard,
  high,
  full,
  medium,
}

class CircularBottomSheet {
  static CircularBottomSheet instance = CircularBottomSheet._init();
  CircularBottomSheet._init();
  Future<void> show(
    context, {
    required Widget child,
    CircularBottomSheetHeight? bottomSheetHeight,
    bool? resizeToAvoidBottomInset,
    bool? scrollable,
    AnimationController? controller,
  }) {
    return showModalBottomSheet(
      transitionAnimationController: controller,
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
              ? context.screenHeight / 1.8
              : bottomSheetHeight == CircularBottomSheetHeight.full
                  ? context.screenHeight
                  : bottomSheetHeight == CircularBottomSheetHeight.medium
                      ? context.screenHeight / 1.40
                      : bottomSheetHeight == CircularBottomSheetHeight.high
                          ? context.screenHeight / 1.1
                          : context.screenHeight / 1.2,
          child: Padding(
            padding: resizeToAvoidBottomInset == true
                ? context.paddingMediumOnlyTop
                : context.paddingMediumTopBottom,
            child: Center(
              child: Padding(
                  padding: context.paddingMediumEdges,
                  child: scrollable == true
                      ? SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal, child: child),
                        )
                      : child),
            ),
          ),
        ),
      ),
    );
  }
}

/*Padding(
padding: EdgeInsets.only(top: 5),
child: Container(
height: 5,
width: 20,
decoration: BoxDecoration(
border: Border.all(width: 3, color: Colors.grey)),
),
),*/
