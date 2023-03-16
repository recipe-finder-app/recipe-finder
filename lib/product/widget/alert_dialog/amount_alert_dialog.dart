import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/constant/enum/device_size_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/product/model/ingredient/ingredient_model.dart';
import 'package:recipe_finder/product/widget/button/recipe_circular_button.dart';
import 'package:recipe_finder/product/widget/circle_avatar/ingredient_circle_avatar.dart';
import 'package:recipe_finder/product/widget/text_field/amount_text_field.dart';

class AmountAlertDialog extends StatefulWidget {
  final IngredientModel model;
  final ValueChanged<double>? onPressedAdd;
  const AmountAlertDialog({Key? key, required this.model, this.onPressedAdd}) : super(key: key);

  @override
  State<AmountAlertDialog> createState() => _AmountAlertDialogState();
}

class _AmountAlertDialogState extends State<AmountAlertDialog> {
  late GlobalKey<FormState> formKey;
  late TextEditingController controller;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    controller = TextEditingController();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.only(right: context.normalValue, left: context.normalValue),
      titlePadding: EdgeInsets.only(top: context.lowValue, right: context.normalValue, left: context.normalValue),
      shape: RoundedRectangleBorder(
        borderRadius: context.radiusAllCircularMedium,
      ),
      title: Align(
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.close,
              color: Colors.grey,
              size: 36,
            ),
          )),
      content: SizedBox(
        height: context.screenHeight < DeviceSizeEnum.inch_5.size ? context.screenHeight / 2.8 : context.screenHeight / 3.5,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IngredientCircleAvatar(
                model: widget.model,
                showText: true,
                textRowText: controller.text,
                textFontSize: 14,
                textColor: Colors.black,
                textFontWeight: FontWeight.normal,
              ),
              AmountTextField(model: widget.model, controller: controller),
              Align(
                alignment: Alignment.center,
                child: RecipeCircularButton(
                  width: context.screenWidth / 2,
                  text: LocaleKeys.add,
                  color: ColorConstants.instance.oriolesOrange,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      widget.onPressedAdd != null ? widget.onPressedAdd!(double.parse(controller.text)) : null;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [],
    );
  }
}
