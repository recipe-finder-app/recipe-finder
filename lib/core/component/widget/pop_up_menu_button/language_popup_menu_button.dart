import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';

import '../../../constant/design/border_constant.dart';
import '../../../init/language/language_manager.dart';

class LanguagePopupMenu extends StatelessWidget {
  final ValueChanged<int?> onChanged;
  final String? selectedValue;
  final int? initialValue;
  final AlignmentGeometry? align;
  final Color? color;
  const LanguagePopupMenu(
      {Key? key,
      required this.onChanged,
      this.initialValue,
      this.align,
      this.selectedValue,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: const Offset(0, 0),
      padding: EdgeInsets.only(
        top: context.screenHeight / 100,
      ),
      shape: OutlineInputBorder(
          borderRadius: BorderConstant.instance.radiusAllCircularMin),
      color: Colors.white.withOpacity(0.8),
      initialValue: initialValue,
      itemBuilder: (context) => [
        const PopupMenuItem(
            value: 1,
            child: Text(
              'EN',
            )),
        const PopupMenuItem(
            value: 2,
            child: Text(
              'TR',
            )),
      ],
      onSelected: (int? value) {
        switch (value) {
          case 1:
            context.setLocale(LanguageManager.instance.enLocale);
            break;
          case 2:
            context.setLocale(LanguageManager.instance.trLocale);
            break;
          default:
            context.setLocale(LanguageManager.instance.enLocale);
        }
        onChanged(value);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            selectedValue ?? 'Language',
            style: TextStyle(color: color ?? Colors.white),
          ),
          Icon(
            Icons.language,
            color: color ?? Colors.white,
          )
        ],
      ),
    );
  }
}
