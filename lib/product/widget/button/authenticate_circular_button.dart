import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/enum/device_size_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/product/component/text/locale_text.dart';

class AuthenticateCircularButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final VoidCallback? onPressed;
  const AuthenticateCircularButton(
      {Key? key,
      required this.text,
      this.color,
      this.onPressed,
      this.textColor,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight < DeviceSizeEnum.inch_5.size
          ? 40
          : context.screenHeight > DeviceSizeEnum.inch_9.size
              ? 70
              : 50,
      width: context.screenWidth / 1.2,
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              color ?? Colors.transparent,
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                  borderRadius: context.radiusAllCircularMedium,
                  side: BorderSide(color: borderColor ?? Colors.transparent)),
            ),
          ),
          onPressed: onPressed,
          child: LocaleText(
              text: text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: textColor ?? Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16))),
    );
  }
}
