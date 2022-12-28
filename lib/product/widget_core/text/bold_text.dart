import 'package:flutter/material.dart';

class BoldText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  const BoldText(
      {Key? key,
      required this.text,
      this.style,
      this.strutStyle,
      this.textAlign,
      this.textDirection,
      this.locale,
      this.softWrap,
      this.overflow,
      this.textScaleFactor,
      this.maxLines,
      this.semanticsLabel,
      this.textWidthBasis,
      this.textHeightBehavior,
      this.fontSize,
      this.textColor,
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style == null
          ? TextStyle(
              color: textColor ?? Colors.black,
              fontFamily: 'Poppins',
              fontWeight: fontWeight ?? FontWeight.w500,
              fontSize: fontSize ?? 14,
              decoration: TextDecoration.none,
            )
          : style!.copyWith(
              color: textColor ?? Colors.black,
              fontFamily: 'Poppins',
              fontWeight: fontWeight ?? FontWeight.w500,
              fontSize: fontSize ?? 14,
              decoration: TextDecoration.none,
            ),
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }
}
