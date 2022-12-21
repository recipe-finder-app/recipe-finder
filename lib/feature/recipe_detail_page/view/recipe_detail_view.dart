import 'dart:ui';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/feature/home_page/cubit/home_cubit.dart';
import 'package:recipe_finder/feature/recipe_detail_page/cubit/recipe_detail_cubit.dart';
import 'package:recipe_finder/product/widget/button/recipe_fab_button.dart';
import 'package:recipe_finder/product/widget/container/transparent_circular_bacground.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/base/view/base_view.dart';
import '../../../core/constant/design/color_constant.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../../product/component/text/bold_text.dart';
import '../../../product/component/text/locale_bold_text.dart';
import '../../../product/model/recipe_model.dart';
import '../../../product/widget/circle_avatar/ingredient_circle_avatar.dart';

class RecipeDetailView extends StatelessWidget {
  RecipeModel recipeModel;
  RecipeDetailView({Key? key, required this.recipeModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<RecipeDetailCubit>(
      init: (cubitRead) {
        cubitRead.init();
      },
      dispose: (cubitRead) {
        cubitRead.dispose();
      },
      visibleProgress: false,
      onPageBuilder: (BuildContext context, cubitRead, cubitWatch) => Scaffold(
        floatingActionButton: const RecipeFabButton(
          text: LocaleKeys.addToBasket,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                videoPlayer(cubitRead, context),
                recipe(context, cubitRead),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stack videoPlayer(RecipeDetailCubit cubitRead, BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        AspectRatio(
          aspectRatio: cubitRead.chewieController.aspectRatio!,
          child: Chewie(
            controller: cubitRead.chewieController,
          ),
        ),
        cubitRead.chewieController.isPlaying == true
            ? const SizedBox()
            : topOfVideoPlayerStack(context),
        Positioned(
          bottom: 0,
          child: Container(
            height: 30,
            width: context.screenWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: context.radiusTopCircularVeryHigh,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 5, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Row(
                    children: [
                      CircularBackground(
                          color: ColorConstants.instance.russianViolet,
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 15,
                          )),
                      InkWell(
                        onTap: () {
                          String ingredientsText = '';
                          for (var ingredient in recipeModel.ingredients!) {
                            ingredientsText =
                                '$ingredientsText\n ${ingredient.quantity} ${ingredient.title}';
                          }

                          String message = '${LocaleKeys.ingredients.locale}\n'
                              '$ingredientsText\n\n'
                              '${LocaleKeys.description}\n\n'
                              '${recipeModel.description}\n\n'
                              '${LocaleKeys.directions}\n\n'
                              '${recipeModel.directions}\n\n';
                          Share.share(message);
                        },
                        child: CircularBackground(
                          circleHeight: 35,
                          circleWidth: 35,
                          color: ColorConstants.instance.russianViolet,
                          child: const Icon(
                            Icons.share_outlined,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Padding topOfVideoPlayerStack(BuildContext context) {
    return Padding(
      padding: context.paddingNormalAll,
      child: Padding(
        padding: context.paddingHighOnlyTop,
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Container recipe(BuildContext context, RecipeDetailCubit cubitRead) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: context.paddingMediumEdges,
        child: Padding(
          padding: EdgeInsets.only(bottom: context.veryHighValue),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BoldText(
                text: recipeModel.title,
                fontSize: 16,
                maxLines: 3,
                textColor: Colors.black,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
              context.lowSizedBox,
              const LocaleBoldText(text: LocaleKeys.ingredients),
              context.lowSizedBox,
              ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: recipeModel.ingredients?.length,
                  itemBuilder:
                      (BuildContext context, int recipeIngredientsIndex) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(recipeModel
                            .ingredients![recipeIngredientsIndex].quantity
                            .toString()),
                        context.lowSizedBoxWidth,
                        Text(recipeModel
                            .ingredients![recipeIngredientsIndex].title),
                      ],
                    );
                  }),
              context.lowSizedBox,
              const LocaleBoldText(text: LocaleKeys.yourFrize),
              context.lowSizedBox,
              context.read<HomeCubit>().myFrizeItems == null
                  ? const Center()
                  : SizedBox(
                      height: context.screenHeight / 7,
                      width: context.screenWidth,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount:
                              context.read<HomeCubit>().myFrizeItems.length,
                          itemBuilder:
                              (BuildContext context, int missingItemIndex) {
                            return Padding(
                              padding: EdgeInsets.only(right: context.lowValue),
                              child: IngredientCircleAvatar(
                                color: ColorConstants.instance.russianViolet
                                    .withOpacity(0.1),
                                model: context
                                    .read<HomeCubit>()
                                    .myFrizeItems[missingItemIndex],
                                iconBottomWidget: Text(
                                  context
                                      .read<HomeCubit>()
                                      .myFrizeItems[missingItemIndex]
                                      .quantity
                                      .toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          }),
                    ),
              const LocaleBoldText(text: LocaleKeys.description),
              context.lowSizedBox,
              Text(
                recipeModel?.description ?? '',
                style: const TextStyle(overflow: TextOverflow.ellipsis),
                maxLines: 3,
              ),
              context.lowSizedBox,
              const LocaleBoldText(text: LocaleKeys.directions),
              context.lowSizedBox,
              Text(
                recipeModel.directions ?? '',
                style: const TextStyle(overflow: TextOverflow.clip),
              ),
              context.lowSizedBox,
            ],
          ),
        ),
      ),
    );
  }
}
