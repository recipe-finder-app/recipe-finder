import 'package:flutter/material.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';

typedef StringFunction = String? Function(String? value);
/*
class StandardTextFormField extends StatefulWidget {
  final TextEditingController? controller;
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
  final ValueChanged<String>? onChanged;

  const StandardTextFormField(
      {Key? key,
      this.height,
      this.width,
      this.controller,
      this.hintText,
      this.labelText,
      this.maxLines,
      this.keyboardType,
      this.validator,
      this.upLabel,
      this.filled,
      this.filledColor,
      this.enabled,
      this.prefixIcon,
      this.suffixIcon,
      this.initialValue,
      this.obscureText,
      this.borderEnable,
      this.textColor,
      this.onChanged})
      : super(key: key);

  @override
  State<StandardTextFormField> createState() => _StandardTextFormFieldState();
}

class _StandardTextFormFieldState extends State<StandardTextFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        initialValue: widget.initialValue,
        maxLines: widget.maxLines,
        controller: widget.controller,
        autocorrect: false,
        enableSuggestions: false,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText ?? false,
        style: TextStyle(color: widget.textColor),
        textDirection: TextDirection.ltr,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          suffixIcon: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.controller != null
                  ? widget.controller!.text.isEmpty
                      ? const Center()
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              widget.controller!;
                            });
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        )
                  : const Center(),
              widget.suffixIcon ?? const Center(),
            ],
          ),
          enabled: widget.enabled ?? true,
          hintText: widget.hintText,
          contentPadding: context.paddingLowAll,
          floatingLabelBehavior: widget.upLabel == false
              ? FloatingLabelBehavior.never
              : FloatingLabelBehavior.always,
          //floatingLabelBehavior: FloatingLabelBehavior.always,
          label: Text(
            widget.labelText ?? '',
            style: const TextStyle(
                fontFamily: 'Poppins',
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14),
          ),
          labelStyle: const TextStyle(
              fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 14),
          filled: widget.filled ?? true,
          fillColor: widget.filledColor ?? Colors.transparent,
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Colors.grey,
          ),

          border: widget.borderEnable == false
              ? null
              : OutlineInputBorder(
                  borderRadius: context.radiusAllCircularMedium,
                ),

          disabledBorder: widget.borderEnable == false
              ? null
              : OutlineInputBorder(
                  borderRadius: context.radiusAllCircularMin,
                  borderSide: const BorderSide(
                    width: 0.5,
                    color: Colors.black,
                  )),
        ),
        validator: (tfInput) {
          if (widget.validator != null) {
            return widget.validator!(tfInput);
          } else {
            return null;
          }
        },
        onChanged: widget.onChanged,
      ),
    );
  }
}*/

class StandardTextFormField extends StatelessWidget {
  final TextEditingController? controller;
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
  final VoidCallback? onpressedClear;
  final ValueChanged<String>? onChanged;

  const StandardTextFormField(
      {Key? key,
      this.height,
      this.width,
      this.controller,
      this.hintText,
      this.labelText,
      this.maxLines,
      this.keyboardType,
      this.validator,
      this.upLabel,
      this.filled,
      this.filledColor,
      this.enabled,
      this.prefixIcon,
      this.suffixIcon,
      this.initialValue,
      this.obscureText,
      this.borderEnable,
      this.textColor,
      this.onChanged,
      this.onpressedClear})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        initialValue: initialValue,
        maxLines: maxLines,
        controller: controller,
        autocorrect: false,
        enableSuggestions: false,
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        style: TextStyle(color: textColor),
        textDirection: TextDirection.ltr,
        cursorColor: Colors.black,
        cursorWidth: 1,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              controller != null
                  ? controller!.text.isEmpty
                      ? const Center()
                      : IconButton(
                          onPressed: () {
                            controller!.clear();
                            if (onpressedClear != null) {
                              onpressedClear!();
                            }
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        )
                  : const Center(),
              suffixIcon ?? const Center(),
            ],
          ),
          enabled: enabled ?? true,
          hintText: hintText,
          contentPadding: context.paddingLowAll,
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
            color: Colors.grey,
          ),
          focusedBorder:
              borderEnable == false ? null : buildOutlineInputBorder(context),
          enabledBorder:
              borderEnable == false ? null : buildOutlineInputBorder(context),
          border:
              borderEnable == false ? null : buildOutlineInputBorder(context),

          disabledBorder:
              borderEnable == false ? null : buildOutlineInputBorder(context),
        ),
        validator: (tfInput) {
          if (validator != null) {
            return validator!(tfInput);
          } else {
            return null;
          }
        },
        onChanged: (data) {
          if (onChanged != null) {
            onChanged!.call(data);
          }
        },
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder(BuildContext context) {
    return OutlineInputBorder(
        borderRadius: context.radiusAllCircularMin,
        borderSide: const BorderSide(
          width: 0.5,
          color: Colors.black,
        ));
  }
}
