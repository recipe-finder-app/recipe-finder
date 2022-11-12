import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageSvg extends StatelessWidget {
  final String path;
  final double? height;
  final double? width;
  final SvgTheme? theme;
  final Color? color;
  const ImageSvg(
      {Key? key,
      required this.path,
      this.height,
      this.width,
      this.theme,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      height: height,
      width: width,
      fit: BoxFit.none,
      theme: theme,
      color: color,
    );
  }
}
