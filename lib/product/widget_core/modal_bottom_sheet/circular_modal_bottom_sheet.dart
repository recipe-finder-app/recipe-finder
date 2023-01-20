import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';

enum CircularBottomSheetHeight {
  short,
  standard,
  high,
  full,
  medium,
}

class CircularBottomSheet {
  static CircularBottomSheet? _instance;
  static CircularBottomSheet get instance {
    _instance ??= CircularBottomSheet._init();
    return _instance!;
  }

  //static CircularBottomSheet instance = CircularBottomSheet._init();
  CircularBottomSheet._init();
  Future<void> show(
    context, {
    required Widget child,
    CircularBottomSheetHeight? bottomSheetHeight,
    bool? resizeToAvoidBottomInset,
    bool? scrollable,
    AnimationController? controller,
    VoidCallback? onDismiss,
  }) {
    return showModalBottomSheet<void>(
      transitionAnimationController: controller,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35), topRight: Radius.circular(35))),
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            bottom: resizeToAvoidBottomInset == true
                ? MediaQuery.of(context).viewInsets.bottom
                : 0),
        child: SizedBox(
          height: bottomSheetHeight == CircularBottomSheetHeight.short
              ? context.screenHeight / 2.4
              : bottomSheetHeight == CircularBottomSheetHeight.full
                  ? context.screenHeight
                  : bottomSheetHeight == CircularBottomSheetHeight.medium
                      ? context.screenHeight / 1.40
                      : bottomSheetHeight == CircularBottomSheetHeight.high
                          ? context.screenHeight / 1.1
                          : context.screenHeight / 1.2,
          child: Padding(
            padding: context.paddingNormalTopBottom,
            child: Padding(
              padding: context.paddingMediumEdges,
              child: scrollable == true
                  ? buildChildScrollable(context, child)
                  : buildChild(context, child),
            ),
          ),
        ),
      ),
    ).then((value) => onDismiss?.call());
  }

  Widget buildChild(BuildContext context, Widget child) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: buildDivider(context),
        ),
        Flexible(flex: 100, child: child),
      ],
    );
  }

  Widget buildChildScrollable(BuildContext context, Widget child) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          buildDivider(context),
          context.mediumSizedBox,
          child,
        ],
      ),
    );
  }

  Widget buildDivider(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: 5,
        width: 50,
        decoration: BoxDecoration(
          color: ColorConstants.instance.brightGraySolid,
          borderRadius: context.radiusAllCircularVeryHigh,
        ),
      ),
    );
  }
}
