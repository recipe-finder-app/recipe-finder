import 'package:flutter/material.dart';
import 'package:recipe_finder/product/widget/button/recipe_circular_button.dart';
import 'package:recipe_finder/product/widget_core/circular_progress_indicator/circular_progress_indicator_blue.dart';

import '../../widget_core/text/locale_text.dart';

class LoginButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color color;
  final Color? textColor;
  const LoginButton({Key? key, this.onPressed, required this.text, required this.color, this.textColor}) : super(key: key);

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool _processState = false;
  void _changeProcessSate() {
    setState(() {
      _processState = !_processState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RecipeCircularButton(
      textWidget: _processState == true
          ? const CircularProgressIndicatorBlue(
              strokeWidth: 2,
            )
          : LocaleText(textAlign: TextAlign.center, text: widget.text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: widget.textColor ?? Colors.white, fontWeight: FontWeight.w500, fontSize: 16)),
      textColor: widget.textColor,
      color: widget.color,
      onPressed: _processState == true
          ? null
          : () async {
              _changeProcessSate();
              if (widget.onPressed != null) {
                await Future(() => widget.onPressed!()).then((_) {
                  _changeProcessSate();
                });
              } else {
                _changeProcessSate();
              }
            },
    );
  }
}
