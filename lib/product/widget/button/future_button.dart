import 'package:flutter/material.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/product/widget/button/recipe_circular_button.dart';

class FutureButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color color;

  final double? width;
  const FutureButton({Key? key, this.onPressed, required this.text, required this.color, this.width}) : super(key: key);

  @override
  State<FutureButton> createState() => _FutureButtonState();
}

class _FutureButtonState extends State<FutureButton> {
  bool _processState = false;
  void _changeProcessState() {
    setState(() {
      _processState = !_processState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RecipeCircularButton(
      width: widget.width ?? context.screenWidth / 1.5,
      text: _processState == true
          ? const CircularProgressIndicator(
              strokeWidth: 2.5,
              color: Colors.blue,
            )
          : Text(widget.text, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16)),
      color: widget.color,
      onPressed: _processState == true
          ? null
          : () async {
              if (widget.onPressed != null) {
                _changeProcessState();
                await Future(widget.onPressed!).then((value) {
                  _changeProcessState();
                });
              }
            },
    );
  }
}
