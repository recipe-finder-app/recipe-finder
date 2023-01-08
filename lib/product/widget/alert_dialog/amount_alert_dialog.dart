import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/product/model/ingradient_model.dart';
import 'package:recipe_finder/product/widget/button/recipe_circular_button.dart';
import 'package:recipe_finder/product/widget/circle_avatar/ingredient_circle_avatar.dart';
import 'package:recipe_finder/product/widget/text_field/amount_text_field.dart';
import 'package:recipe_finder/product/widget_core/text/bold_text.dart';

class AmountAlertDialog extends StatefulWidget {
  final IngredientModel model;
  const AmountAlertDialog({Key? key, required this.model}) : super(key: key);

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
      contentPadding: EdgeInsets.only(
          top: context.lowValue,
          right: context.lowValue,
          left: context.lowValue),
      actionsPadding: EdgeInsets.only(
          bottom: context.normalValue,
          right: context.lowValue,
          left: context.lowValue),
      titlePadding: EdgeInsets.only(
          top: context.lowValue,
          bottom: context.lowValue,
          right: context.normalValue,
          left: context.normalValue),
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
        height: context.screenHeight / 4,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IngredientCircleAvatar(
                model: widget.model,
                showText: false,
              ),
              BoldText(text: '${controller.text} ${widget.model.title}'),
              context.normalSizedBox,
              AmountTextField(model: widget.model, controller: controller)
            ],
          ),
        ),
      ),
      actions: [
        Align(
          alignment: Alignment.center,
          child: RecipeCircularButton(
            width: context.screenWidth / 2,
            text: LocaleKeys.add,
            color: ColorConstants.instance.oriolesOrange,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                print('validate');
              } else {
                print('validate değil');
              }
            },
          ),
        ),
      ],
    );
  }
}
