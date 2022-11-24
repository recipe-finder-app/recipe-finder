import 'package:flutter/material.dart';

import '../../../core/constant/design/color_constant.dart';

class RecipeScrollBar extends StatelessWidget {
  final Widget child;
  final ScrollController? controller;
  const RecipeScrollBar({Key? key, required this.child, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      controller:
          ScrollController(keepScrollOffset: true, initialScrollOffset: 50.0),
      thickness: 5,
      interactive: true,
      trackVisibility: true,
      thumbVisibility: true,
      radius: const Radius.circular(15),
      scrollbarOrientation: ScrollbarOrientation.right,
      thumbColor: ColorConstants.instance.oriolesOrange,
      trackColor: ColorConstants.instance.oriolesOrange,
      child: child,
    );
  }
}
