import 'package:flutter/material.dart';

class TransparentCircularBackground extends StatelessWidget {
  final double? circleHeight;
  final double? circleWidth;
  final Widget child;
  const TransparentCircularBackground(
      {Key? key, this.circleHeight, this.circleWidth, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          height: circleHeight ?? 35,
          width: circleWidth ?? 35,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent.withOpacity(0.2),
          ),
        ),
        child
      ],
    );
  }
}
