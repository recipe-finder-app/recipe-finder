import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/base/view/base_view.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/constant/navigation/navigation_constants.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/core/init/navigation/navigation_service.dart';
import 'package:recipe_finder/feature/finder_page/cubit/finder_cubit.dart';
import 'package:recipe_finder/feature/finder_page/cubit/finder_state.dart';
import 'package:recipe_finder/feature/likes_page/cubit/likes_cubit.dart';
import 'package:recipe_finder/feature/likes_page/cubit/likes_state.dart';
import 'package:recipe_finder/feature/likes_page/model/like_recipe_model.dart';
import 'package:recipe_finder/product/component/card/card_overlay.dart';
import 'package:recipe_finder/product/component/card/tinder_card.dart';
import 'package:recipe_finder/product/component/modal_bottom_sheet/circular_modal_bottom_sheet.dart';
import 'package:recipe_finder/product/component/text/bold_text.dart';
import 'package:recipe_finder/product/component/text/locale_bold_text.dart';
import 'package:recipe_finder/product/component/text/locale_text.dart';
import 'package:recipe_finder/product/model/ingradient_model.dart';
import 'package:recipe_finder/product/widget/button/recipe_circular_button.dart';
import 'package:recipe_finder/product/widget/circle_avatar/draggable_ingredient_circle_avatar.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../../product/component/image_format/image_svg.dart';
import '../../../product/widget/bottom_nav_bar_controller/bottom_nav_bar_cubit.dart';

class FinderView extends StatefulWidget {
  const FinderView({Key? key}) : super(key: key);

  @override
  State<FinderView> createState() => _FinderViewState();
}

class _FinderViewState extends State<FinderView> {
  late final SwipableStackController _controller;

  @override
  void initState() {
    super.initState();
  }

  void _listenController() => setState(() {});
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<FinderCubit>(
        init: (cubitRead) {
          _controller = SwipableStackController()
            ..addListener(_listenController);
          cubitRead.init();
        },
        dispose: (cubitRead) {
          _controller
            ..removeListener(_listenController)
            ..dispose();
          cubitRead.dispose();
        },
        visibleProgress: false,
        onPageBuilder: (BuildContext context, cubitRead, cubitWatch) =>
            Scaffold(
              backgroundColor: ColorConstants.instance.ephemeralBlue,
              body: Padding(
                padding: context.paddingHighOnlyTop,
                child: Container(
                  height: context.screenHeight,
                  width: context.screenWidth,
                  decoration: BoxDecoration(
                      color: ColorConstants.instance.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(context.mediumValue),
                          topRight: Radius.circular(context.mediumValue))),
                  child: Padding(
                    padding: context.paddingNormalTopLeftRight,
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: SizedBox(
                        height: context.screenHeight,
                        child: Column(
                          children: [
                            _textRow(context),
                            context.normalSizedBox,
                            cubitRead.finderRecipeItems == null
                                ? Text('Şimdilik bu kadar...')
                                : BlocSelector<FinderCubit, IFinderState,
                                    LikeRecipeModel>(
                                    selector: (state) {
                                      if (state is CurrentSwipedCard) {
                                        return state.currentSwipedCardModel;
                                      } else {
                                        return cubitRead.currentSwipedCardModel;
                                      }
                                    },
                                    builder: (context, state) {
                                      return buildTinderCard(
                                          context, cubitRead, state);
                                    },
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }

  Column buildTinderCard(
      BuildContext context, FinderCubit cubitRead, LikeRecipeModel state) {
    return Column(
      children: [
        SizedBox(
          height: context.cardhighValue,
          width: context.cardValueWidth,
          child: SwipableStack(
            controller: _controller,
            stackClipBehaviour: Clip.none,
            swipeAnchor: SwipeAnchor.bottom,
            onWillMoveNext: (
              index,
              swipeDirection,
            ) {
              cubitRead
                  .changeCurrentSwipedCard(cubitRead.finderRecipeItems![index]);
              switch (swipeDirection) {
                case SwipeDirection.left:
                case SwipeDirection.right:
                case SwipeDirection.up:
                  return true;
                case SwipeDirection.down:
                  return false;
              }
            },
            onSwipeCompleted: (index, direction) {
              cubitRead
                  .changeCurrentSwipedCard(cubitRead.finderRecipeItems![index]);
            },
            horizontalSwipeThreshold: 0.8,
            verticalSwipeThreshold: 1,
            overlayBuilder: (
              context,
              properties,
            ) =>
                CardOverlay(
              swipeProgress: properties.swipeProgress,
              direction: properties.direction,
            ),
            builder: (
              context,
              properties,
            ) {
              return TinderCard(
                  model: cubitRead.finderRecipeItems![properties.index],
                  recipeOnPressed: () {
                    NavigationService.instance.navigateToPage(
                        path: NavigationConstants.RECIPE_DETAIL,
                        data: cubitRead
                            .finderRecipeItems![properties.index].recipeModel);
                  });
            },
          ),
        ),
        context.normalSizedBox,
        buildRowButton(context, cubitRead, cubitRead.currentSwipedCardModel),
      ],
    );
  }

  SizedBox buildRowButton(BuildContext context, FinderCubit cubitRead,
      LikeRecipeModel? likeRecipeModel) {
    return SizedBox(
      width: context.cardValueWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton.small(
            backgroundColor: ColorConstants.instance.russianViolet,
            onPressed: () {
              cubitRead.finderRecipeItems?.remove(likeRecipeModel);
              _controller.next(swipeDirection: SwipeDirection.left);
            },
            child: Icon(
              Icons.clear,
              color: ColorConstants.instance.white,
            ),
          ),
          FloatingActionButton(
            mini: true,
            backgroundColor: ColorConstants.instance.brightGraySolid2,
            onPressed: () {
              //  addToBasketBottomSheet(context,cubitRead,cardIndex);
            },
            child: ImageSvg(
              path: ImagePath.shoppingBag.path,
              color: ColorConstants.instance.russianViolet,
            ),
          ),
          FloatingActionButton(
            backgroundColor: ColorConstants.instance.oriolesOrange,
            onPressed: () {
              context.read<LikesCubit>().likeRecipeItems.add(likeRecipeModel!);
              cubitRead.finderRecipeItems?.remove(likeRecipeModel);
              _controller.next(swipeDirection: SwipeDirection.right);
            },
            child: Icon(
              Icons.favorite,
              color: ColorConstants.instance.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _textRow(BuildContext context) {
    return SizedBox(
      width: context.cardValueWidth,
      child: Row(children: [
        Flexible(
          child: LocaleText(
            maxLines: 2,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              color: ColorConstants.instance.blackbox,
            ),
            text: LocaleKeys.finderText,
          ),
        ),
        TextButton(
          onPressed: () {
            context.read<RecipeNavigationBarCubit>().changeCurrentIndex(0);
          },
          child: LocaleText(
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                color: ColorConstants.instance.russianViolet,
                decoration: TextDecoration.underline,
                decorationColor: ColorConstants.instance.russianViolet,
                decorationThickness: 2,
              ),
              text: LocaleKeys.close),
        ),
      ]),
    );
  }

  Future<void> addToBasketBottomSheet(
      BuildContext context, LikesCubit cubitRead, int cardIndex) {
    return CircularBottomSheet.instance.show(
      context,
      bottomSheetHeight: CircularBottomSheetHeight.short,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Flexible(
              flex: 1, child: LocaleBoldText(text: LocaleKeys.missingItem)),
          if (cubitRead.likeRecipeItems[cardIndex].missingItems == null)
            const Center()
          else
            BlocSelector<LikesCubit, ILikesState, List<IngredientModel>>(
              selector: (state) {
                if (state is MissingItemListLoad) {
                  return state.missingItemList;
                } else {
                  return cubitRead.likeRecipeItems[cardIndex].missingItems ??
                      [];
                }
              },
              builder: (BuildContext context, state) {
                return Flexible(
                  flex: 4,
                  child: DragTarget<IngredientModel>(onAccept: (data) {
                    cubitRead.addItemToMissingList(cardIndex, data);
                    cubitRead.removeMyFrizeItem(data);
                  }, builder: (BuildContext context,
                      List<Object?> candidateData, List<dynamic> rejectedData) {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.length,
                        itemBuilder:
                            (BuildContext context, int missingItemIndex) {
                          return Padding(
                            padding: EdgeInsets.only(right: context.lowValue),
                            child: DraggableIngredientCircleAvatar<
                                IngredientModel>(
                              data: state[missingItemIndex],
                              iconBottomWidget: BoldText(
                                text:
                                    state[missingItemIndex].quantity.toString(),
                                textColor: ColorConstants.instance.white,
                              ),
                              color: ColorConstants.instance.oriolesOrange
                                  .withOpacity(0.4),
                              model: state[missingItemIndex],
                            ),
                          );
                        });
                  }),
                );
              },
            ),
          const Flexible(
              flex: 1, child: LocaleBoldText(text: LocaleKeys.yourFrize)),
          BlocSelector<LikesCubit, ILikesState, List<IngredientModel>>(
              selector: (state) {
            if (state is MyFrizeListLoad) {
              return state.myFrizeList;
            } else {
              return cubitRead.myFrizeItems;
            }
          }, builder: (BuildContext context, state) {
            return Flexible(
              flex: 4,
              child: cubitRead.myFrizeItems == null
                  ? const Center()
                  : DragTarget<IngredientModel>(
                      onAccept: (data) {
                        cubitRead.addItemToMyFrizeList(data);
                        cubitRead.removeMissingItem(cardIndex, data);
                      },
                      builder: (BuildContext context,
                          List<Object?> candidateData,
                          List<dynamic> rejectedData) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.length,
                            itemBuilder:
                                (BuildContext context, int myFrizeItemIndex) {
                              return Padding(
                                padding:
                                    EdgeInsets.only(right: context.lowValue),
                                child: DraggableIngredientCircleAvatar<
                                    IngredientModel>(
                                  data: state[myFrizeItemIndex],
                                  iconBottomWidget: BoldText(
                                    text: state[myFrizeItemIndex]
                                        .quantity
                                        .toString(),
                                    textColor: ColorConstants.instance.white,
                                  ),
                                  color:
                                      ColorConstants.instance.brightGraySolid2,
                                  model: state[myFrizeItemIndex],
                                ),
                              );
                            });
                      },
                    ),
            );
          }),
          RecipeCircularButton(
              color: ColorConstants.instance.oriolesOrange,
              text: LocaleKeys.confirm),
        ],
      ),
    );
  }
}
