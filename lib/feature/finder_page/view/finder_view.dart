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
import 'package:recipe_finder/product/component/card/card_overlay.dart';
import 'package:recipe_finder/product/component/card/tinder_card.dart';
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
          return InkWell(
            onTap: () {
              NavigationService.instance.navigateToPage(
                path: NavigationConstants.RECIPE_DETAIL,
              );
            },
            child: TinderCard(
              name: cubitRead.draggableItems[itemIndex].distance,
              assetPath: cubitRead.draggableItems[itemIndex].imageAsset,
            ),
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
}
