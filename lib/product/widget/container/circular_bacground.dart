import 'package:flutter/material.dart';

class CircularBackground extends StatelessWidget {
  final double? circleHeight;
  final double? circleWidth;
  final Widget child;
  final Color? color;
  final Border? border;
  const CircularBackground({Key? key, this.circleHeight, this.circleWidth, required this.child, this.color, this.border}) : super(key: key);

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
            color: color ?? Colors.transparent.withOpacity(0.2),
            border: border,
          ),
        ),
        child
      ],
    );
  }
}
