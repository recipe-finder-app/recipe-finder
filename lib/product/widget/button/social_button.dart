import 'package:flutter/material.dart';
import 'package:recipe_finder/product/model/social_adapter.dart';
import 'package:recipe_finder/product/model/user/user_model.dart';
import 'package:recipe_finder/product/widget/button/recipe_circular_button.dart';

class SocialButton extends StatelessWidget {
  final ISocialAdapter adapter;
  final ValueChanged<UserModel> onCompleted;
  const SocialButton({Key? key, required this.adapter, required this.onCompleted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RecipeCircularButton(
      text: Text(adapter.model.title),
      icon: adapter.model.icon,
      textColor: adapter.model.color,
      color: Colors.white,
      borderColor: Colors.black,
      onPressed: () async {
        final result = await adapter.login.call();
        onCompleted.call(result);
      },
    );
  }
}
