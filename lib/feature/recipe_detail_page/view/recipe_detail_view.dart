import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/base/view/base_view.dart';
import '../../../core/constant/design/color_constant.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../../product/model/recipe_model.dart';
import '../../../product/widget/button/recipe_fab_button.dart';
import '../../../product/widget/circle_avatar/ingredient_circle_avatar.dart';
import '../../../product/widget/container/circular_bacground.dart';
import '../../../product/widget_core/text/bold_text.dart';
import '../../../product/widget_core/text/locale_bold_text.dart';
import '../../home_page/cubit/home_cubit.dart';
import '../cubit/recipe_detail_cubit.dart';

class RecipeDetailView extends StatefulWidget {
  RecipeModel recipeModel;
  RecipeDetailView({Key? key, required this.recipeModel}) : super(key: key);

  @override
  State<RecipeDetailView> createState() => _RecipeDetailViewState();
}

class _RecipeDetailViewState extends State<RecipeDetailView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return BaseView<RecipeDetailCubit>(
      init: (cubitRead) {
        cubitRead.init();
        _tabController = TabController(vsync: this, length: 2);
      },
      dispose: (cubitRead) {
        cubitRead.dispose();
        _tabController.dispose();
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
            TabBar(
              controller: _tabController,
              labelColor: ColorConstants.instance.oriolesOrange,
              unselectedLabelColor: Colors.black,
              indicatorColor: ColorConstants.instance.oriolesOrange,
              indicatorWeight: 1,
              tabs: [
                Tab(
                  text: LocaleKeys.ingredients.locale,
                ),
                Tab(
                  text: LocaleKeys.directions.locale,
                ),
              ],
            ),
            SizedBox(
              height: context.screenHeight * 5,
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SingleChildScrollView(child: tabBarIngredients(context)),
                  SingleChildScrollView(child: tabBarDirections(context)),
                  // tabBarDirections(context),
                ],
              ),
            ),
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
