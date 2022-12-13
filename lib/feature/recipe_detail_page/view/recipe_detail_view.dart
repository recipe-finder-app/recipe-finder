import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/product/component/image_format/image_svg.dart';
import 'package:recipe_finder/product/widget/button/recipe_fab_button.dart';
import 'package:recipe_finder/product/widget/container/transparent_circular_bacground.dart';

import '../../../core/base/view/base_view.dart';
import '../../../core/constant/design/color_constant.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../../product/component/text/bold_text.dart';
import '../../../product/component/text/locale_bold_text.dart';
import '../../../product/widget/circle_avatar/ingredient_circle_avatar.dart';
import '../../likes_page/cubit/likes_cubit.dart';

class RecipeDetailView extends StatelessWidget {
  int cardIndex;
  RecipeDetailView({Key? key, required this.cardIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<LikesCubit>(
      init: (cubitRead) {
        cubitRead.init();
      },
      visibleProgress: false,
      onPageBuilder: (BuildContext context, cubitRead, cubitWatch) => Scaffold(
        floatingActionButton: const RecipeFabButton(
          text: LocaleKeys.addToBasket,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      Container(
                        height: context.screenHeight / 2.5,
                        width: context.screenWidth,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(cubitRead
                                  .likeRecipeItems[cardIndex].imagePath)),
                        ),
                      ),
                      Padding(
                        padding: context.paddingNormalAll,
                        child: Padding(
                          padding: context.paddingHighOnlyTop,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TransparentCircularBackground(
                                    circleHeight: 35,
                                    circleWidth: 35,
                                    child: ImageSvg(
                                      path: ImagePath.likeWhite.path,
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(),
                                  const TransparentCircularBackground(
                                    circleHeight: 70,
                                    circleWidth: 70,
                                    child: Icon(
                                      Icons.play_circle_outline,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: const TransparentCircularBackground(
                                      circleHeight: 35,
                                      circleWidth: 35,
                                      child: Icon(
                                        Icons.share_outlined,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: context.paddingMediumEdges,
                        child: BoldText(
                          text: cubitRead.likeRecipeItems[cardIndex].title,
                          fontSize: 20,
                          maxLines: 3,
                          textColor: Colors.white,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(context.mediumValue),
                                topRight:
                                    Radius.circular(context.mediumValue))),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: context.paddingMediumEdges,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: context.veryHighValue),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const LocaleBoldText(text: LocaleKeys.ingredients),
                        context.lowSizedBox,
                        ListView.builder(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: context
                                .read<LikesCubit>()
                                .likeRecipeItems[cardIndex]
                                .recipeModel
                                .ingredients
                                .length,
                            itemBuilder: (BuildContext context,
                                int recipeIngredientsIndex) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(context
                                      .read<LikesCubit>()
                                      .likeRecipeItems[cardIndex]
                                      .recipeModel
                                      .ingredients[recipeIngredientsIndex]
                                      .quantity
                                      .toString()),
                                  context.lowSizedBoxWidth,
                                  Text(context
                                      .read<LikesCubit>()
                                      .likeRecipeItems[cardIndex]
                                      .recipeModel
                                      .ingredients[recipeIngredientsIndex]
                                      .title),
                                ],
                              );
                            }),
                        context.lowSizedBox,
                        const LocaleBoldText(text: LocaleKeys.yourFrize),
                        context.lowSizedBox,
                        cubitRead.myFrizeItems == null
                            ? const Center()
                            : SizedBox(
                                height: context.screenHeight / 8,
                                width: context.screenWidth,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: cubitRead.myFrizeItems.length,
                                    itemBuilder: (BuildContext context,
                                        int missingItemIndex) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            right: context.lowValue),
                                        child: IngredientCircleAvatar(
                                          color: ColorConstants
                                              .instance.russianViolet
                                              .withOpacity(0.1),
                                          model: cubitRead
                                              .myFrizeItems[missingItemIndex],
                                          iconBottomWidget: Text(
                                            cubitRead
                                                .myFrizeItems[missingItemIndex]
                                                .quantity
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                        const LocaleBoldText(text: LocaleKeys.description),
                        context.lowSizedBox,
                        Text(
                          cubitRead.likeRecipeItems[cardIndex].recipeModel
                              .description,
                          style:
                              const TextStyle(overflow: TextOverflow.ellipsis),
                          maxLines: 3,
                        ),
                        context.lowSizedBox,
                        const LocaleBoldText(text: LocaleKeys.directions),
                        context.lowSizedBox,
                        Text(
                          cubitRead.likeRecipeItems[cardIndex].recipeModel
                              .directions,
                          style: const TextStyle(overflow: TextOverflow.clip),
                        ),
                        context.lowSizedBox,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
