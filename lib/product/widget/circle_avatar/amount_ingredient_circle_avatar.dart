import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/product/widget/circle_avatar/ingredient_circle_avatar.dart';

import '../../../core/widget/text/bold_text.dart';
import '../../model/ingredient_quantity/ingredient_quantity.dart';
import '../alert_dialog/amount_alert_dialog.dart';

class AmountIngredientCircleAvatar extends StatefulWidget {
  final IngredientQuantity model;
  const AmountIngredientCircleAvatar({Key? key, required this.model}) : super(key: key);

  @override
  State<AmountIngredientCircleAvatar> createState() => _AmountIngredientCircleAvatarState();
}

class _AmountIngredientCircleAvatarState extends State<AmountIngredientCircleAvatar> {
  double? _selectedAmount;
  @override
  Widget build(BuildContext context) {
    return IngredientCircleAvatar(
      model: widget.model,
      iconTopWidget: _selectedAmount != null
          ? BoldText(
              text: _selectedAmount == 0.0 ? '' : _selectedAmount.toString(),
              textColor: ColorConstants.instance.russianViolet,
              fontSize: 18,
            )
          : null,
      showText: true,
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return AmountAlertDialog(
                model: widget.model,
                onPressedAdd: (double value) {
                  setState(() {
                    _selectedAmount = value;
                  });
                  Navigator.pop(context);
                },
              );
            });
      },
    );
  }
}
