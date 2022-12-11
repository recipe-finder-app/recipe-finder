import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/base/view/base_view.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/constant/navigation/navigation_constants.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/core/init/navigation/navigation_service.dart';
import 'package:recipe_finder/feature/finder_page/cubit/finder_cubit.dart';
import 'package:recipe_finder/feature/finder_page/view/card_overlay.dart';
import 'package:recipe_finder/feature/finder_page/view/tinder_card.dart';
import 'package:recipe_finder/feature/likes_page/cubit/likes_cubit.dart';
import 'package:recipe_finder/feature/likes_page/cubit/likes_state.dart';
import 'package:recipe_finder/product/component/modal_bottom_sheet/circular_modal_bottom_sheet.dart';
import 'package:recipe_finder/product/component/text/bold_text.dart';
import 'package:recipe_finder/product/component/text/locale_bold_text.dart';
import 'package:recipe_finder/product/component/text/locale_text.dart';
import 'package:recipe_finder/product/model/ingradient_model.dart';
import 'package:recipe_finder/product/widget/button/recipe_circular_button.dart';
import 'package:recipe_finder/product/widget/circle_avatar/draggable_ingredient_circle_avatar.dart';
import 'package:swipable_stack/swipable_stack.dart';

class FinderView extends StatefulWidget {
  const FinderView({super.key});

  @override
  State<FinderView> createState() => _FinderViewState();
}

class _FinderViewState extends State<FinderView> {
  late final SwipableStackController _controller;

  void _listenController() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller = SwipableStackController()..addListener(_listenController);
  }

  @override
  void dispose() {
    super.dispose();
    _controller
      ..removeListener(_listenController)
      ..dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<FinderCubit>(
        init: (cubitRead) {
          cubitRead.init();
        },
        visibleProgress: false,
        onPageBuilder: (BuildContext context, cubitRead, cubitWatch) =>
            Scaffold(
              backgroundColor: const Color(0xffCCD4DE),
              body: Padding(
                padding: context.paddingHighOnlyTop,
                child: Container(
                  height: context.screenHeight,
                  width: context.screenWidth,
                  decoration: BoxDecoration(
                      color: ColorConstants.instance.white,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35))),
                  child: Padding(
                    padding: context.paddingNormalTopLeftRight,
                    child: Column(
                      children: [
                        _textRow(context),
                        context.highSizedBox,
                        buildTinderCard(context, cubitRead),
                        context.mediumSizedBox,
                        buildRowButon(context),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  SizedBox buildRowButon(BuildContext context) {
    return SizedBox(
      width: context.cardValueWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            backgroundColor: ColorConstants.instance.russianViolet,
            onPressed: () {},
            child: Icon(
              Icons.clear,
              color: ColorConstants.instance.white,
            ),
          ),
          FloatingActionButton(
            mini: true,
            backgroundColor: const Color(0xffE6EBF2),
            onPressed: () {
              // addToBasketBottomSheet(context,cubitRead,cardIndex);
            },
            child: Image.asset('asset/png/icon_shop.png'),
          ),
          FloatingActionButton(
            backgroundColor: ColorConstants.instance.oriolesOrange,
            onPressed: () {},
            child: Icon(
              Icons.favorite,
              color: ColorConstants.instance.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTinderCard(BuildContext context, FinderCubit cubitRead) {
    return SizedBox(
      height: context.cardhighValue,
      width: context.cardValueWidth,
      child: SwipableStack(
        controller: _controller,
        stackClipBehaviour: Clip.none,
        swipeAnchor: SwipeAnchor.bottom,
        onWillMoveNext: (index, swipeDirection) {
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
          if (kDebugMode) {
            print('$index, $direction');
          }
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
        builder: (context, properties) {
          final itemIndex = properties.index % cubitRead.draggableItems.length;
          return TinderCard(
            name: cubitRead.draggableItems[itemIndex].distance,
            assetPath: cubitRead.draggableItems[itemIndex].imageAsset,
          );
        },
      ),
    );
  }

  Widget _textRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 3,
          child: Align(
            alignment: Alignment.centerLeft,
            child: LocaleText(
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                color: ColorConstants.instance.blackbox,
              ),
              text: LocaleKeys.finderText,
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: TextButton(
            onPressed: () {
              NavigationService.instance
                  .navigateToPage(path: NavigationConstants.HOME);
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
        ),
      ],
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
                  child: BlocBuilder<LikesCubit, ILikesState>(
                      builder: (BuildContext context, dragState) {
                    if (cubitRead.missingItemListTargetState == true) {
                      return DragTarget<int>(
                          onWillAccept: (data) {
                            return true;
                          },
                          onAccept: (data) {},
                          builder: (BuildContext context,
                              List<Object?> candidateData,
                              List<dynamic> rejectedData) {
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.length,
                                itemBuilder: (BuildContext context,
                                    int missingItemIndex) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        right: context.lowValue),
                                    child: DraggableIngredientCircleAvatar<int>(
                                      data: missingItemIndex,
                                      onDragStarted: () {
                                        cubitRead
                                            .changeMissingItemListTargetState(
                                                false);
                                        cubitRead
                                            .changeMyFrizeListTargetState(true);
                                      },
                                      onDragEnd:
                                          (DraggableDetails draggableDetails) {
                                        if (draggableDetails.wasAccepted ==
                                            true) {
                                          cubitRead.addItemToMyFrizeList(
                                              state[missingItemIndex]);
                                          cubitRead.removeMissingItem(
                                              cardIndex, missingItemIndex);
                                        }
                                      },
                                      iconBottomWidget: BoldText(
                                        text: state[missingItemIndex]
                                            .quantity
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      color: ColorConstants
                                          .instance.oriolesOrange
                                          .withOpacity(0.4),
                                      model: state[missingItemIndex],
                                    ),
                                  );
                                });
                          });
                    } else {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.length,
                          itemBuilder:
                              (BuildContext context, int missingItemIndex) {
                            return Padding(
                              padding: EdgeInsets.only(right: context.lowValue),
                              child: DraggableIngredientCircleAvatar<int>(
                                data: missingItemIndex,
                                onDragUpdate: (d) {},
                                onDragStarted: () {
                                  cubitRead
                                      .changeMissingItemListTargetState(false);
                                  cubitRead.changeMyFrizeListTargetState(true);
                                },
                                onDragEnd: (DraggableDetails draggableDetails) {
                                  if (draggableDetails.wasAccepted == true) {
                                    cubitRead.addItemToMyFrizeList(
                                        state[missingItemIndex]);
                                    cubitRead.removeMissingItem(
                                        cardIndex, missingItemIndex);
                                  }
                                },
                                iconBottomWidget: BoldText(
                                  text: state[missingItemIndex]
                                      .quantity
                                      .toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                color: ColorConstants.instance.oriolesOrange
                                    .withOpacity(0.4),
                                model: state[missingItemIndex],
                              ),
                            );
                          });
                    }
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
              return cubitRead.myFrizeItems ?? [];
            }
          }, builder: (BuildContext context, state) {
            return Flexible(
              flex: 4,
              child: cubitRead.myFrizeItems == null
                  ? const Center()
                  : BlocBuilder<LikesCubit, ILikesState>(
                      builder: (BuildContext context, dragState) {
                      if (cubitRead.myFrizeListTargetState == true) {
                        return DragTarget<int>(
                          onWillAccept: (data) {
                            return true;
                          },
                          onAccept: (data) {},
                          builder: (BuildContext context,
                              List<Object?> candidateData,
                              List<dynamic> rejectedData) {
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.length,
                                itemBuilder: (BuildContext context,
                                    int myFrizeItemIndex) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        right: context.lowValue),
                                    child: DraggableIngredientCircleAvatar<int>(
                                      data: myFrizeItemIndex,
                                      onDragStarted: () {
                                        cubitRead.changeMyFrizeListTargetState(
                                            false);
                                        cubitRead
                                            .changeMissingItemListTargetState(
                                                true);
                                      },
                                      onDragEnd:
                                          (DraggableDetails draggableDetails) {
                                        if (draggableDetails.wasAccepted ==
                                            true) {
                                          cubitRead.addItemToMissingList(
                                              cardIndex,
                                              state[myFrizeItemIndex]);
                                          cubitRead.removeMyFrizeItem(
                                              myFrizeItemIndex);
                                        }
                                      },
                                      iconBottomWidget: BoldText(
                                        text: state[myFrizeItemIndex]
                                            .quantity
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      color: ColorConstants
                                          .instance.brightGraySolid2,
                                      model: state[myFrizeItemIndex],
                                    ),
                                  );
                                });
                          },
                        );
                      } else {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.length,
                            itemBuilder:
                                (BuildContext context, int myFrizeItemIndex) {
                              return Padding(
                                padding:
                                    EdgeInsets.only(right: context.lowValue),
                                child: DraggableIngredientCircleAvatar<int>(
                                  data: myFrizeItemIndex,
                                  onDragStarted: () {
                                    cubitRead
                                        .changeMyFrizeListTargetState(false);
                                    cubitRead
                                        .changeMissingItemListTargetState(true);
                                  },
                                  onDragEnd:
                                      (DraggableDetails draggableDetails) {
                                    if (draggableDetails.wasAccepted == true) {
                                      cubitRead.addItemToMissingList(
                                          cardIndex, state[myFrizeItemIndex]);
                                      cubitRead
                                          .removeMyFrizeItem(myFrizeItemIndex);
                                    }
                                  },
                                  iconBottomWidget: BoldText(
                                    text: state[myFrizeItemIndex]
                                        .quantity
                                        .toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  color:
                                      ColorConstants.instance.brightGraySolid2,
                                  model: state[myFrizeItemIndex],
                                ),
                              );
                            });
                      }
                    }),
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
