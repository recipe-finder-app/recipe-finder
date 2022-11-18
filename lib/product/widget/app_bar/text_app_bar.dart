import 'package:flutter/material.dart';

import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/constant/navigation/navigation_constants.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/core/init/navigation/navigation_service.dart';
import 'package:recipe_finder/feature/home_page/model/vegatables_model.dart';
import 'package:recipe_finder/product/component/image_format/image_svg.dart';
import 'package:recipe_finder/product/component/modal_bottom_sheet/circular_modal_bottom_sheet.dart';
import 'package:recipe_finder/product/component/text/locale_text.dart';
import 'package:recipe_finder/product/widget/button/login_button.dart';

import '../../../feature/home_page/model/essentials_model.dart';

class TextAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Widget? widget;
  final Color? color;
  TextAppBar({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.widget,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: context.veryveryHighValue,
          child: Align(
            alignment: Alignment.centerLeft,
            child: LocaleText(
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                color: ColorConstants.instance.blackbox,
              ),
              text: title,
            ),
          ),
        ),
        Stack(children: [
          SizedBox(
              height: context.highValue,
              child: InkWell(onTap: onPressed, child: widget)),
          Padding(
            padding: context.paddingHighEdges,
            child: CircleAvatar(
              radius: 5,
              backgroundColor: color,
            ),
          )
        ]),
      ],
    );
  }
}
