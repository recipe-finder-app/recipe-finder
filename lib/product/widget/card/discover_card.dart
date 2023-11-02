import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/feature/likes_page/cubit/likes_cubit.dart';
import 'package:recipe_finder/feature/likes_page/cubit/likes_state.dart';
import 'package:recipe_finder/product/model/recipe/recipe.dart';
import 'package:recipe_finder/product/widget/container/circular_bacground.dart';

import '../../../core/init/language/language_manager.dart';
import '../../utils/constant/image_path_enum.dart';
import '../../../core/widget/text/bold_text.dart';

class DiscoverCard extends StatelessWidget {
  final Recipe model;
  final double? width;
  final VoidCallback? onPressed;
  final VoidCallback? likeIconOnPressed;
  const DiscoverCard({Key? key, required this.model, this.width, this.onPressed, this.likeIconOnPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     String recipeName = context.locale == LanguageManager.instance.trLocale ? (model.nameTR ?? '') : (model.nameEN ?? '');
    return InkWell(
      onTap: onPressed,
      child: Stack(
        children: [
          recipeImage(context),
          likeImage(context),
          Padding(
            padding: context.paddingLowAll,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: BoldText(
                text: recipeName,
                textColor: ColorConstants.instance.white,
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.start,
                fontSize: 12,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
    );
  }

  SizedBox recipeImage(BuildContext context) {

    return SizedBox(
      width: width ?? context.screenWidth / 1.3,
      child: Container(
        decoration: BoxDecoration(
          image:model.imagePath!=null && model.imagePath!.isNotEmpty ? DecorationImage(
              fit: BoxFit.cover,
              image:NetworkImage(model.imagePath!),
              ) : DecorationImage(
              fit: BoxFit.cover,
              image:AssetImage(ImagePathConstant.imageSample1.path)
              ),
          borderRadius: context.radiusAllCircularMin,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: context.radiusBottomCircularMin,
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 0, 0.6, 1],
              colors: [
                Colors.black,
                Colors.transparent,
                Colors.transparent,
                Colors.black,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding likeImage(BuildContext context) {
    return Padding(
      padding: context.paddingNormalAll,
      child: Align(
        alignment: Alignment.topRight,
        child: InkWell(
          onTap: likeIconOnPressed,
          child: BlocBuilder<LikesCubit, ILikesState>(
            builder: (context, state) {
              if (context.read<LikesCubit>().recipeList.contains(model)) {
                return CircularBackground(
                  circleHeight: 35,
                  circleWidth: 35,
                  child: Icon(
                    Icons.favorite_outlined,
                    color: ColorConstants.instance.white,
                    size: 18,
                  ),
                );
              } else {
                return CircularBackground(
                  circleHeight: 35,
                  circleWidth: 35,
                  child: Icon(
                    Icons.favorite_border_outlined,
                    color: ColorConstants.instance.white,
                    size: 18,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
