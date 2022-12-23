import 'dart:ui';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/feature/recipe_detail_page/cubit/recipe_detail_cubit.dart';
import 'package:recipe_finder/product/widget/button/recipe_fab_button.dart';
import 'package:recipe_finder/product/widget/container/circular_bacground.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/base/view/base_view.dart';
import '../../../core/constant/design/color_constant.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../../product/component/text/bold_text.dart';
import '../../../product/component/text/locale_bold_text.dart';
import '../../../product/component/text/locale_text.dart';
import '../../../product/model/recipe_model.dart';
import '../../../product/widget/circle_avatar/ingredient_circle_avatar.dart';
import '../../home_page/cubit/home_cubit.dart';

class RecipeDetailView2 extends StatefulWidget {
  RecipeModel recipeModel;
  RecipeDetailView2({Key? key, required this.recipeModel}) : super(key: key);

  @override
  State<RecipeDetailView2> createState() => _RecipeDetailView2State();
}

class _RecipeDetailView2State extends State<RecipeDetailView2>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  void _startAnimation() {
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<RecipeDetailCubit>(
      init: (cubitRead) {
        cubitRead.init();
        _animationController = AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 500),
        );
        _animation =
            Tween<double>(begin: 0, end: 1).animate(_animationController);
        _startAnimation();
      },
      dispose: (cubitRead) {
        cubitRead.dispose();
        _animationController.dispose();
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

  Widget videoPlayer(RecipeDetailCubit cubitRead, BuildContext context) {
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
            height: 50,
            width: context.screenWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: context.radiusTopCircularVeryHigh,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: context.mediumValue, top: context.lowValue),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          String ingredientsText = '';
                          for (var ingredient
                              in widget.recipeModel.ingredients!) {
                            ingredientsText =
                                '$ingredientsText\n ${ingredient.quantity} ${ingredient.title}';
                          }

                          String message = '${LocaleKeys.ingredients.locale}\n'
                              '$ingredientsText\n\n'
                              '${LocaleKeys.description}\n\n'
                              '${widget.recipeModel.description}\n\n'
                              '${LocaleKeys.directions}\n\n'
                              '${widget.recipeModel.directions}\n\n';
                          Share.share(message);
                        },
                        child: CircularBackground(
                          circleHeight: 30,
                          circleWidth: 30,
                          color: ColorConstants.instance.russianViolet,
                          child: const Icon(
                            Icons.share_outlined,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),
                      context.lowSizedBoxWidth,
                      CircularBackground(
                          circleHeight: 30,
                          circleWidth: 30,
                          color: ColorConstants.instance.russianViolet,
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 15,
                          )),
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

  Widget topOfVideoPlayerStack(BuildContext context) {
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

  Widget recipe(BuildContext context, RecipeDetailCubit cubitRead) {
    return Padding(
      padding: context.paddingMediumEdges,
      child: Padding(
        padding: EdgeInsets.only(bottom: context.highValue),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            context.lowSizedBox,
            BoldText(
              text: widget.recipeModel.title,
              fontSize: 16,
              maxLines: 3,
              textColor: Colors.black,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
            ),
            context.lowSizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    cubitRead.changeSelectedCategoryIndex(0);
                    _startAnimation();
                  },
                  child: Container(
                    height: 45,
                    width: context.screenWidth / 2.5,
                    decoration: BoxDecoration(
                      border: cubitRead.selectedCategoryIndex == 0
                          ? null
                          : Border.all(color: Colors.black, width: 0.5),
                      color: cubitRead.categoryItemColor(0),
                      borderRadius: context.radiusAllCircularMedium,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: context.paddingLowEdges,
                        child: LocaleText(
                          text: LocaleKeys.ingredients.locale,
                          style: TextStyle(
                              fontSize: 16,
                              color: cubitRead.categoryTextColor(0)),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    cubitRead.changeSelectedCategoryIndex(1);
                    _startAnimation();
                  },
                  child: Container(
                    height: 45,
                    width: context.screenWidth / 2.5,
                    decoration: BoxDecoration(
                      border: cubitRead.selectedCategoryIndex == 1
                          ? null
                          : Border.all(color: Colors.black, width: 0.5),
                      color: cubitRead.categoryItemColor(1),
                      borderRadius: context.radiusAllCircularMedium,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: context.paddingLowEdges,
                        child: LocaleText(
                          text: LocaleKeys.directions.locale,
                          style: TextStyle(
                              fontSize: 16,
                              color: cubitRead.categoryTextColor(1)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            cubitRead.selectedCategoryIndex == 0
                ? FadeTransition(
                    opacity: _animation, child: tabBarIngredients(context))
                : cubitRead.selectedCategoryIndex == 1
                    ? FadeTransition(
                        opacity: _animation, child: tabBarDirections(context))
                    : const SizedBox(),
            /*  AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _animation.value,
                  child: FadeTransition(opacity: _animation, child: child),
                );
              },
              child: cubitRead.selectedCategoryIndex == 0
                  ? tabBarIngredients(context)
                  : cubitRead.selectedCategoryIndex == 1
                      ? tabBarDirections(context)
                      : const SizedBox(),
            ),*/
          ],
        ),
      ),
    );
  }

  Widget tabBarDirections(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        context.normalSizedBox,
        Text(
          widget.recipeModel.directions ?? '',
          style: const TextStyle(overflow: TextOverflow.clip),
        ),
      ],
    );
  }

  Widget tabBarIngredients(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        context.normalSizedBox,
        ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.recipeModel.ingredients?.length,
            itemBuilder: (BuildContext context, int recipeIngredientsIndex) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget
                      .recipeModel.ingredients![recipeIngredientsIndex].quantity
                      .toString()),
                  context.lowSizedBoxWidth,
                  Text(widget
                      .recipeModel.ingredients![recipeIngredientsIndex].title),
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
                    itemCount: context.read<HomeCubit>().myFrizeItems.length,
                    itemBuilder: (BuildContext context, int missingItemIndex) {
                      return Padding(
                        padding: EdgeInsets.only(right: context.lowValue),
                        child: IngredientCircleAvatar(
                          color: ColorConstants.instance.russianViolet
                              .withOpacity(0.1),
                          model: context
                              .read<HomeCubit>()
                              .myFrizeItems[missingItemIndex],
                          iconTopWidget: Text(
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
          widget.recipeModel?.description ?? '',
          style: const TextStyle(overflow: TextOverflow.ellipsis),
          maxLines: 3,
        ),
      ],
    );
  }
}
