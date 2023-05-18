import 'package:flutter/material.dart';

class ImagePng extends StatelessWidget {
  final String path;
  final double? height;
  final double? width;

  const ImagePng({
    Key? key,
    required this.path,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
    );
  }
}
