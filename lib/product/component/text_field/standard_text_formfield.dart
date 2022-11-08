import 'package:flutter/material.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';

typedef StringFunction = String? Function(String? value);

class StandardTextFormField extends StatelessWidget {
  final TextEditingController? tfController;
  final String? hintText;
  final String? labelText;
  final double? height;
  final double? width;
  final int? maxLines;
  final bool? upLabel;
  final bool? filled;
  final bool? enabled;
  final Color? filledColor;
  final TextInputType? keyboardType;
  final StringFunction? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? initialValue;
  final bool? obscureText;
  final bool? borderEnable;
  final Color? textColor;

  const StandardTextFormField(
      {Key? key,
      this.height,
      this.width,
      this.tfController,
      this.hintText,
      this.labelText,
      this.maxLines,
      this.keyboardType,
      required this.validator,
      this.upLabel,
      this.filled,
      this.filledColor,
      this.enabled,
      this.prefixIcon,
      this.suffixIcon,
      this.initialValue,
      this.obscureText,
      this.borderEnable,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        initialValue: initialValue,
        maxLines: maxLines,
        controller: tfController,
        autocorrect: false,
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          enabled: enabled ?? true,
          hintText: hintText,
          floatingLabelBehavior: upLabel == false
              ? FloatingLabelBehavior.never
              : FloatingLabelBehavior.always,
          //floatingLabelBehavior: FloatingLabelBehavior.always,
          label: Text(
            labelText ?? '',
            style: const TextStyle(
                fontFamily: 'Poppins',
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14),
          ),
          labelStyle: const TextStyle(
              fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 14),
          filled: filled ?? true,
          fillColor: filledColor ?? Colors.transparent,
          hintStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Colors.grey),
          border: borderEnable == false
              ? null
              : OutlineInputBorder(
                  borderRadius: context.radiusAllCircularMedium),
          disabledBorder: borderEnable == false
              ? null
              : OutlineInputBorder(
                  borderRadius: context.radiusAllCircularMin,
                  borderSide: const BorderSide(width: 0.5)),
        ),
        validator: (tfInput) {
          return validator!(tfInput);
        },
      ),
    );
  }
}
