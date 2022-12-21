import 'dart:ui';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/feature/home_page/cubit/home_cubit.dart';
import 'package:recipe_finder/feature/recipe_detail_page/cubit/recipe_detail_cubit.dart';
import 'package:recipe_finder/product/component/image_format/image_svg.dart';
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
        backgroundColor: Colors.grey,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: [
                    AspectRatio(
                      aspectRatio: cubitRead.chewieController.aspectRatio!,
                      child: Chewie(
                        controller: cubitRead.chewieController,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                Visibility(
                                  visible:
                                      !cubitRead.chewieController.isPlaying,
                                  child: TransparentCircularBackground(
                                    circleHeight: 35,
                                    circleWidth: 35,
                                    child: ImageSvg(
                                      path: ImagePath.likeWhite.path,
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(),
                                Visibility(
                                  visible:
                                      !cubitRead.chewieController.isPlaying,
                                  child: InkWell(
                                    onTap: () {
                                      String ingredientsText = '';
                                      for (var ingredient
                                          in recipeModel.ingredients!) {
                                        ingredientsText =
                                            '$ingredientsText\n ${ingredient.quantity} ${ingredient.title}';
                                      }

                                      String message =
                                          '${LocaleKeys.ingredients.locale}\n'
                                          '$ingredientsText\n\n'
                                          '${LocaleKeys.description}\n\n'
                                          '${recipeModel.description}\n\n'
                                          '${LocaleKeys.directions}\n\n'
                                          '${recipeModel.directions}\n\n';
                                      Share.share(message);
                                    },
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
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    cubitRead.chewieController.isPlaying
                        ? const SizedBox()
                        : Padding(
                            padding: EdgeInsets.only(top: 180, left: 40),
                            child: BoldText(
                              text: recipeModel.title,
                              fontSize: 20,
                              maxLines: 3,
                              textColor: Colors.white,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(context.mediumValue),
                          topRight: Radius.circular(context.mediumValue))),
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
                              itemCount: recipeModel.ingredients?.length,
                              itemBuilder: (BuildContext context,
                                  int recipeIngredientsIndex) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(recipeModel
                                        .ingredients![recipeIngredientsIndex]
                                        .quantity
                                        .toString()),
                                    context.lowSizedBoxWidth,
                                    Text(recipeModel
                                        .ingredients![recipeIngredientsIndex]
                                        .title),
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
                                      itemCount: context
                                          .read<HomeCubit>()
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
                                                .read<HomeCubit>()
                                                .myFrizeItems[missingItemIndex],
                                            iconBottomWidget: Text(
                                              context
                                                  .read<HomeCubit>()
                                                  .myFrizeItems[
                                                      missingItemIndex]
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
                            recipeModel?.description ?? '',
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
