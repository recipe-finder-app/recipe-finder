import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/product/widget/text_field/speech_to_text_formfield.dart';

import '../../../core/constant/design/color_constant.dart';
import '../../../core/constant/enum/image_path_enum.dart';
import '../../../core/widget/image_format/image_svg.dart';

class SearchTextField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final double? width;
  final TextEditingController controller;
  final VoidCallback? onPressedClear;
  final bool? borderEnable;
  final bool? filled;
  final Color? filledColor;
  final String? hintText;
  final Widget? icon;
  const SearchTextField({Key? key, this.width, this.onChanged, required this.controller, this.onPressedClear, this.borderEnable, this.filled, this.filledColor, this.hintText, this.icon}) : super(key: key);

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late CancelableOperation<void> cancelableOperation;

  @override
  void initState() {
    super.initState();
    _start();
  }

  void _start() {
    cancelableOperation = CancelableOperation.fromFuture(Future.delayed(const Duration(milliseconds: 500)), onCancel: () {
      print("canceled");
    });
  }

  void _onTextChanged(String value) {
    cancelableOperation.cancel();
    _start();
    cancelableOperation.value.whenComplete(() {
      if (widget.onChanged != null) widget.onChanged!(value);
      print("onchanged calisti");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SpeechToTextFormField(
      controller: widget.controller,
      width: widget.width,
      borderEnable: widget.borderEnable,
      filled: widget.filled,
      filledColor: widget.filledColor,
      hintText: LocaleKeys.search,
      onPressedClear: widget.onPressedClear,
      icon: widget.icon ?? ImageSvg(path: ImagePath.searchh.path, color: ColorConstants.instance.russianViolet),
      onChanged: _onTextChanged,
    );
  }
}
