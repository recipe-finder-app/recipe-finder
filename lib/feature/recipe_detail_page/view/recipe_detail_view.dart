import 'package:chewie/chewie.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/feature/recipe_detail_page/cubit/recipe_detail_cubit.dart';
import 'package:recipe_finder/product/utils/constant/image_path_enum.dart';
import 'package:recipe_finder/product/widget/alert_dialog/question_alert_dialog.dart';
import 'package:recipe_finder/product/widget/button/recipe_fab_button.dart';
import 'package:recipe_finder/product/widget/container/circular_bacground.dart';
import 'package:recipe_finder/product/widget/modal_bottom_sheet/add_to_basket_bottom_sheet/view/add_to_basket_bottom_sheet.dart';

import '../../../core/base/view/base_view.dart';
import '../../../core/constant/design/color_constant.dart';
import '../../../core/init/language/language_manager.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../../core/widget/text/bold_text.dart';
import '../../../core/widget/text/locale_bold_text.dart';
import '../../../core/widget/text/locale_text.dart';
import '../../../product/model/recipe/recipe.dart';
import '../../../product/widget/circle_avatar/amount_ingredient_circle_avatar.dart';
import '../../home_page/cubit/home_cubit.dart';
import '../../likes_page/cubit/likes_cubit.dart';
import '../../likes_page/cubit/likes_state.dart';

class RecipeDetailView extends StatefulWidget {
 final Recipe recipeModel;
 const RecipeDetailView({Key? key, required this.recipeModel}) : super(key: key);

  @override
  State<RecipeDetailView> createState() => _RecipeDetailViewState();
}

class _RecipeDetailViewState extends State<RecipeDetailView> with SingleTickerProviderStateMixin {
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
        cubitRead.setContext(context);
        cubitRead.init();

        _animationController = AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 500),
        );
        _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
        _startAnimation();
      },
      dispose: (cubitRead) {
        cubitRead.dispose();
        _animationController.dispose();
      },
      visibleProgress: false,
      onPageBuilder: (BuildContext context, cubitRead, cubitWatch) => Scaffold(
        floatingActionButton: RecipeFabButton(
          heroTag: 'recipeFabButton',
          text: LocaleKeys.addToBasket,
          onPressed: () {
            AddToBasketBottomSheet.instance.show(context, widget.recipeModel);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              imageOrVideoPlayer(cubitRead, context,widget.recipeModel),
              recipe(context, cubitRead),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageOrVideoPlayer(RecipeDetailCubit cubitRead, BuildContext context,Recipe model) {
    return Stack(
      children: [
      (model.imagePath!=null && model.imagePath!.isNotEmpty) ? 
      Image.network(model.imagePath!,width: context.screenWidth,height: context.screenHeight/2.8,fit: BoxFit.fill,) : 
      Image.asset(ImagePathConstant.imageSample1.path,width: context.screenWidth,height: context.screenHeight/2.8,fit: BoxFit.fill,),
       /*AspectRatio(
          aspectRatio: cubitRead.chewieController.aspectRatio!,
          child: Chewie(controller: cubitRead.chewieController),
        ),*/
        Positioned(
          bottom: -5,
          height: 50,
          width: context.screenWidth,
          child: Container(
            padding: EdgeInsets.only(right: context.mediumValue, top: context.lowValue),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: context.radiusTopCircularVeryHigh,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    cubitRead.share(widget.recipeModel);
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
                context.normalSizedBoxWidth,
                BlocBuilder<LikesCubit, LikesState>(builder: (context, state) {
                  if (context.read<LikesCubit>().state.likedRecipeList!.contains(widget.recipeModel)) {
                    return InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return QuestionAlertDialog(
                                explanation: LocaleKeys.deleteSavedRecipeQuestion,
                                onPressedYes: () {
                                 // context.read<LikesCubit>().removeItemFromLikedRecipeList(widget.recipeModel);
                                },
                              );
                            });
                      },
                      child: CircularBackground(
                          circleHeight: 30,
                          circleWidth: 30,
                          color: ColorConstants.instance.russianViolet,
                          child: const Icon(
                            Icons.favorite_outlined,
                            color: Colors.white,
                            size: 15,
                          )),
                    );
                  } else {
                    return InkWell(
                      onTap: () {
                       // context.read<LikesCubit>().addItemFromLikedRecipeList(widget.recipeModel);
                        Fluttertoast.showToast(timeInSecForIosWeb: 2, gravity: ToastGravity.CENTER, msg: LocaleKeys.favoriteRecipeMessage.locale, backgroundColor: ColorConstants.instance.oriolesOrange, textColor: Colors.white);
                      },
                      child: CircularBackground(
                          circleHeight: 30,
                          circleWidth: 30,
                          color: Colors.white,
                          border: Border.all(width: 1, color: ColorConstants.instance.russianViolet),
                          child: Icon(
                            Icons.favorite_outline_outlined,
                            color: ColorConstants.instance.russianViolet,
                            size: 18,
                          )),
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /*Widget videoPlayerStack(BuildContext context) {
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
  }*/

  Widget recipe(BuildContext context, RecipeDetailCubit cubitRead) {
     String recipeName = context.locale == LanguageManager.instance.trLocale ? (widget.recipeModel.nameTR ?? '') : (widget.recipeModel.nameEN ?? '');
    return Padding(
      padding: context.paddingMediumEdges,
      child: Container(
        padding: EdgeInsets.only(bottom: context.veryHighValue * 1.25),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            context.lowSizedBox,
            BoldText(
              text: recipeName,
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
                    cubitRead.changePreviousSelectedTabBarIndex(cubitRead.selectedTabBarIndex);
                    cubitRead.changeSelectedTabBarIndex(0);
      
                    cubitRead.selectedPreviousTabBarIndex == 0 ? null : _startAnimation();
                  },
                  child: Container(
                    height: 45,
                    width: context.screenWidth / 2.5,
                    decoration: BoxDecoration(
                      border: cubitRead.selectedTabBarIndex == 0 ? null : Border.all(color: Colors.black, width: 0.5),
                      color: cubitRead.categoryItemColor(0),
                      borderRadius: context.radiusAllCircularMedium,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: context.paddingLowEdges,
                        child: LocaleText(
                          text: LocaleKeys.ingredients.locale,
                          style: TextStyle(fontSize: 16, color: cubitRead.categoryTextColor(0)),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    cubitRead.changePreviousSelectedTabBarIndex(cubitRead.selectedTabBarIndex);
                    cubitRead.changeSelectedTabBarIndex(1);
                    cubitRead.selectedPreviousTabBarIndex == 1 ? null : _startAnimation();
                  },
                  child: Container(
                    height: 45,
                    width: context.screenWidth / 2.5,
                    decoration: BoxDecoration(
                      border: cubitRead.selectedTabBarIndex == 1 ? null : Border.all(color: Colors.black, width: 0.5),
                      color: cubitRead.categoryItemColor(1),
                      borderRadius: context.radiusAllCircularMedium,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: context.paddingLowEdges,
                        child: LocaleText(
                          text: LocaleKeys.directions.locale,
                          style: TextStyle(fontSize: 16, color: cubitRead.categoryTextColor(1)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            cubitRead.selectedTabBarIndex == 0
                ? Hero(tag: 'tabBarIngredients', child: FadeTransition(opacity: _animation, child: tabBarIngredients(context)))
                : cubitRead.selectedTabBarIndex == 1 //bu hero widget'ını fab button tag değeriyle bu animasyonların tag değeri çakıştığı için veriyoruz.Fab butona da farklı tag verdik.
                    ? Hero(tag: 'tabBarDirections', child: FadeTransition(opacity: _animation, child: tabBarDirections(context)))
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
    String directions = context.locale == LanguageManager.instance.trLocale ? (widget.recipeModel.directionsTR ?? '') : (widget.recipeModel.directionsEN ?? '');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        context.normalSizedBox,
        Text(
          directions,
          style: const TextStyle(overflow: TextOverflow.clip),
        ),
      ],
    );
  }

  Widget tabBarIngredients(BuildContext context) {
  String description = context.locale == LanguageManager.instance.trLocale ? (widget.recipeModel.descriptionTR ?? '') : (widget.recipeModel.descriptionEN ?? '');   
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        context.normalSizedBox,
        ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.recipeModel.ingredients?.length ?? 0,
            itemBuilder: (BuildContext context, int recipeIngredientsIndex) {
         String ingredientName = context.locale == LanguageManager.instance.trLocale ? (widget.recipeModel.ingredients?[recipeIngredientsIndex].nameTR ?? '') : (widget.recipeModel.ingredients?[recipeIngredientsIndex].nameEN  ?? '');    
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.recipeModel.ingredients![recipeIngredientsIndex].quantity.toString()),
                  context.lowSizedBoxWidth,
                  Text(ingredientName),
                ],
              );
            }),
        context.lowSizedBox,
        const LocaleBoldText(text: LocaleKeys.yourFrize),
        context.lowSizedBox,
            
             FutureBuilder(
              future:context.read<RecipeDetailCubit>().fetchFrizeIngredientList(),
              builder: (context,snapshot){
                if(snapshot.data==null || (snapshot.data!=null && snapshot.data!.isEmpty)){
                   return  const SizedBox.shrink();
                }
                 else if(snapshot.connectionState== ConnectionState.waiting){
                    return CircularProgressIndicator(color: ColorConstants.instance.oriolesOrange,strokeWidth: 2.5,);
                  }
                  else if(snapshot.connectionState== ConnectionState.done){
               return SizedBox(
                  height: context.screenHeight / 7,
                  width: context.screenWidth,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (BuildContext context, int missingItemIndex) {
                        return Padding(
                          padding: EdgeInsets.only(right: context.lowValue),
                          child: AmountIngredientCircleAvatar(
                            model:snapshot.data![missingItemIndex],
                          ),
                        );
                      }),
                );
                  }
                  else {
                    return  const SizedBox.shrink();
                  }
              },
            ),
        const LocaleBoldText(text: LocaleKeys.description),
        context.lowSizedBox,
        Text(
          description,
          style: const TextStyle(overflow: TextOverflow.ellipsis),
          maxLines: 3,
        ),
      ],
    );
  }
}
