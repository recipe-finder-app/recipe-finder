import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/feature/recipe_detail_page/cubit/recipe_detail_cubit.dart';
import 'package:recipe_finder/feature/recipe_detail_page/view/landscape_player_view.dart';
import 'package:recipe_finder/product/component/image_format/image_svg.dart';
import 'package:recipe_finder/product/widget/button/recipe_fab_button.dart';
import 'package:recipe_finder/product/widget/container/transparent_circular_bacground.dart';
import 'package:video_player/video_player.dart';

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      cubitRead.videoPlayerController.value.isPlaying
                          ? AspectRatio(
                              aspectRatio: cubitRead
                                  .videoPlayerController.value.aspectRatio,
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  VideoPlayer(cubitRead.videoPlayerController),
                                  IconButton(
                                    icon: const Icon(Icons.pause),
                                    color: Colors.white,
                                    onPressed: () {
                                      cubitRead.clickRunVideoButton();
                                    },
                                  ),
                                  Positioned(
                                    bottom: 50,
                                    right: 5,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.fullscreen,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return LandscapePlayerView(
                                              controller: cubitRead
                                                  .videoPlayerController);
                                        }));
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 45,
                                    right: 50,
                                    left: 50,
                                    child: VideoProgressIndicator(
                                        cubitRead.videoPlayerController,
                                        colors: VideoProgressColors(
                                            backgroundColor: ColorConstants
                                                .instance.brightGraySolid,
                                            playedColor: Colors.white),
                                        allowScrubbing: true),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              height: context.screenHeight / 2.5,
                              width: context.screenWidth,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(context
                                        .read<LikesCubit>()
                                        .likeRecipeItems[cardIndex]
                                        .imagePath)),
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
                                    icon: const Icon(
                                      Icons.arrow_back_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                  cubitRead
                                          .videoPlayerController.value.isPlaying
                                      ? const SizedBox()
                                      : TransparentCircularBackground(
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
                                  cubitRead
                                          .videoPlayerController.value.isPlaying
                                      ? const SizedBox()
                                      : InkWell(
                                          onTap: () {
                                            cubitRead.clickRunVideoButton();
                                          },
                                          child: TransparentCircularBackground(
                                            circleHeight: 70,
                                            circleWidth: 70,
                                            child: Icon(
                                              cubitRead.videoPlayerController
                                                      .value.isPlaying
                                                  ? Icons.pause
                                                  : Icons.play_circle_outline,
                                              color: Colors.white,
                                              size: 25,
                                            ),
                                          ),
                                        ),
                                  cubitRead
                                          .videoPlayerController.value.isPlaying
                                      ? const SizedBox()
                                      : InkWell(
                                          onTap: () {},
                                          child:
                                              const TransparentCircularBackground(
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
                      cubitRead.videoPlayerController.value.isPlaying
                          ? const SizedBox()
                          : Padding(
                              padding: context.paddingMediumEdges,
                              child: BoldText(
                                text: context
                                    .read<LikesCubit>()
                                    .likeRecipeItems[cardIndex]
                                    .title,
                                fontSize: 20,
                                maxLines: 3,
                                textColor: Colors.white,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                      context.lowSizedBox,
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
                        context.read<LikesCubit>().myFrizeItems == null
                            ? const Center()
                            : SizedBox(
                                height: context.screenHeight / 8,
                                width: context.screenWidth,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: context
                                        .read<LikesCubit>()
                                        .myFrizeItems
                                        .length,
                                    itemBuilder: (BuildContext context,
                                        int missingItemIndex) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            right: context.lowValue),
                                        child: IngredientCircleAvatar(
                                          color: ColorConstants
                                              .instance.russianViolet
                                              .withOpacity(0.1),
                                          model: context
                                              .read<LikesCubit>()
                                              .myFrizeItems[missingItemIndex],
                                          iconBottomWidget: Text(
                                            context
                                                .read<LikesCubit>()
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
                          context
                              .read<LikesCubit>()
                              .likeRecipeItems[cardIndex]
                              .recipeModel
                              .description,
                          style:
                              const TextStyle(overflow: TextOverflow.ellipsis),
                          maxLines: 3,
                        ),
                        context.lowSizedBox,
                        const LocaleBoldText(text: LocaleKeys.directions),
                        context.lowSizedBox,
                        Text(
                          context
                              .read<LikesCubit>()
                              .likeRecipeItems[cardIndex]
                              .recipeModel
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
