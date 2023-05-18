import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';

typedef StringFunction = String? Function(String? value);

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
  final VoidCallback? onPressedClear;
  final bool? isValid;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixText;
  final Widget? prefix;
  final TextStyle? prefixStyle;
  final String? suffixText;
  final Widget? suffix;
  final TextStyle? suffixStyle;
  final bool? showClearButton;
  final bool? canBeEmpty;
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
      this.onPressedClear,
      this.isValid,
      this.inputFormatters,
      this.prefixText,
      this.prefix,
      this.prefixStyle,
      this.suffixText,
      this.suffix,
      this.suffixStyle,
      this.showClearButton,
      this.canBeEmpty})
      : super(key: key);

  @override
  State<StandardTextFormField> createState() => _StandardTextFormFieldState();
}

class _StandardTextFormFieldState extends State<StandardTextFormField> {
  bool _isValid = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? calculateTextFieldHeight(),
      width: widget.width ?? context.screenWidth / 1.2,
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        initialValue: widget.initialValue,
        maxLines: widget.maxLines ?? 1,
        controller: widget.controller,
        autocorrect: false,
        enableSuggestions: false,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText ?? false,
        style: TextStyle(color: widget.textColor, decoration: TextDecoration.none),
        textDirection: TextDirection.ltr,
        cursorColor: Colors.black,
        cursorWidth: 1,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          prefix: widget.prefix,
          prefixStyle: widget.prefixStyle,
          prefixText: widget.prefixText,
          suffix: widget.suffix,
          suffixStyle: widget.suffixStyle,
          suffixText: widget.suffixText,
          errorMaxLines: 1,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.showClearButton == false
              ? null
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    widget.controller != null
                        ? widget.controller!.text.isEmpty
                            ? const SizedBox.shrink()
                            : IconButton(
                                onPressed: () {
                                  widget.controller!.clear();
                                  setState(() {});
                                  if (widget.onPressedClear != null) {
                                    widget.onPressedClear!();
                                  }
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              )
                        : const SizedBox.shrink(),
                    widget.suffixIcon ?? const SizedBox.shrink(),
                  ],
                ),
          enabled: widget.enabled ?? true,
          hintText: widget.hintText,
          contentPadding: context.paddingLowAll,
          floatingLabelBehavior: widget.upLabel == false ? FloatingLabelBehavior.never : FloatingLabelBehavior.always,
          //floatingLabelBehavior: FloatingLabelBehavior.always,
          label: Text(
            widget.labelText ?? '',
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          labelStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
          filled: widget.filled ?? true,
          fillColor: widget.filledColor ?? Colors.white,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Colors.grey,
          ),

          focusedBorder: widget.borderEnable == false ? null : _buildOutlineInputBorder(context),
          enabledBorder: widget.borderEnable == false ? null : _buildOutlineInputBorder(context),
          border: widget.borderEnable == false ? null : _buildOutlineInputBorder(context),

          disabledBorder: widget.borderEnable == false ? null : _buildOutlineInputBorder(context),
        ),
        validator: (tfInput) {
          if (widget.validator != null) {
            return widget.validator!(tfInput);
          } else if (widget.canBeEmpty == false) {
            if (tfInput!.isEmpty) {
              setState(() {
                _isValid = false;
              });
              return LocaleKeys.dontEmptyThisField;
            } else {
              setState(() {
                _isValid = true;
              });
              return null;
            }
          }
        },
        onChanged: (data) {
          if (widget.controller != null && (widget.controller!.text.length == 1 || widget.controller!.text.isEmpty)) {
            setState(() {});
          }
          if (widget.onChanged != null) {
            widget.onChanged!.call(data);
          }
        },
      ),
    );
  }

  OutlineInputBorder _buildOutlineInputBorder(BuildContext context) {
    return OutlineInputBorder(
        borderRadius: context.radiusAllCircularMin,
        borderSide: const BorderSide(
          width: 0.5,
          color: Colors.black,
        ));
  }

  double calculateTextFieldHeight() {
    if (widget.isValid == false || _isValid == false) {
      if (context.screenHeightIsLessThan5Inch) {
        return 65;
      } else if (context.screenHeightIsLargerThan9Inch) {
        return 95;
      } else {
        return 75;
      }
    } else {
      if (context.screenHeightIsLessThan5Inch) {
        return 40;
      } else if (context.screenHeightIsLargerThan9Inch) {
        return 70;
      } else {
        return 50;
      }
    }
  }
}
