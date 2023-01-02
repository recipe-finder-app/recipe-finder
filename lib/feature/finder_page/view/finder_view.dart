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
import 'package:recipe_finder/feature/likes_page/cubit/likes_cubit.dart';
import 'package:recipe_finder/product/widget/modal_bottom_sheet/add_to_basket_bottom_sheet/view/add_to_basket_bottom_sheet.dart';
import 'package:recipe_finder/product/widget_core/text/locale_text.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../../product/widget/card/card_overlay.dart';
import '../../../product/widget/card/tinder_card.dart';
import '../../../product/widget_core/image_format/image_svg.dart';

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
                    borderRadius: context.radiusTopCircularHigh,
                  ),
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
                            cubitRead.recipeListItemCount == 0
                                ? const Align(
                                    alignment: Alignment.center,
                                    child: Text('Şimdilik bu kadar...'))
                                : buildTinderCard(context, cubitRead),
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
    BuildContext context,
    FinderCubit cubitRead,
  ) {
    return Column(
      children: [
        SizedBox(
          height: context.cardhighValue,
          width: context.cardValueWidth,
          child: SwipableStack(
            controller: _controller,
            itemCount: cubitRead.recipeList!.length,
            stackClipBehaviour: Clip.none,
            swipeAnchor: SwipeAnchor.bottom,
            onWillMoveNext: (
              index,
              swipeDirection,
            ) {
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
              cubitRead.changeRecipeListItemCount();
              if (direction == SwipeDirection.right) {
                context
                    .read<LikesCubit>()
                    .recipeList
                    .add(cubitRead.recipeList![index]);
              } else if (direction == SwipeDirection.up) {
                AddToBasketBottomSheet.instance
                    .show(context, cubitRead.recipeList![index].ingredients);
              } else if (direction == SwipeDirection.left) {}
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
                  model: cubitRead.recipeList![properties.index],
                  recipeOnPressed: () {
                    NavigationService.instance.navigateToPage(
                        path: NavigationConstants.RECIPE_DETAIL,
                        data: cubitRead.recipeList![properties.index]);
                  });
            },
          ),
        ),
        context.normalSizedBox,
        buildRowButton(
          context,
          cubitRead,
          1,
        ),
      ],
    );
  }

  SizedBox buildRowButton(
    BuildContext context,
    FinderCubit cubitRead,
    int index,
  ) {
    return SizedBox(
      width: context.cardValueWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            backgroundColor: ColorConstants.instance.russianViolet,
            onPressed: () {
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
              AddToBasketBottomSheet.instance
                  .show(context, cubitRead.recipeList![1].ingredients);
            },
            child: ImageSvg(
              path: ImagePath.shoppingBag.path,
              color: ColorConstants.instance.russianViolet,
            ),
          ),
          FloatingActionButton(
            backgroundColor: ColorConstants.instance.oriolesOrange,
            onPressed: () {
              context
                  .read<LikesCubit>()
                  .recipeList
                  .add(cubitRead.recipeList!.first);
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
        /* TextButton(
          onPressed: () {
            NavigationService.instance
                .navigateToPage(path: NavigationConstants.NAV_CONTROLLER);

            //  context.read<RecipeNavigationBarCubit>().changeCurrentIndex(0);
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
        ),*/
      ]),
    );
  }
}
