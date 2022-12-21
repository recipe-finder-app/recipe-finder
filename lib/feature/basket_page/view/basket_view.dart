import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/feature/basket_page/view/basket_card.dart';
import 'package:recipe_finder/product/component/image_format/image_svg.dart';
import 'package:recipe_finder/product/component/text/locale_text.dart';
import 'package:recipe_finder/product/model/recipe_model.dart';
import 'package:recipe_finder/product/widget/alert_dialog/question_alert_dialog.dart';
import 'package:recipe_finder/product/widget/circle_avatar/ingredient_circle_avatar.dart';

import '../../../core/base/view/base_view.dart';
import '../../home_page/cubit/home_cubit.dart';
import '../cubit/basket_cubit.dart';

class BasketView extends StatelessWidget {
  BasketView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<BasketCubit>(
        init: (cubitRead) {
          cubitRead.init();
        },
        visibleProgress: false,
        onPageBuilder: (BuildContext context, cubitRead, cubitWatch) =>
            Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: context.paddingNormalTopLeftRight,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LocaleText(
                          style: TextStyle(
                            fontSize: 24,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.instance.russianViolet,
                          ),
                          text: LocaleKeys.myBasketList,
                        ),
                        context.lowSizedBox,
                        SizedBox(
                          height: context.normalhighValue,
                          width: context.screenWidth,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: cubitRead.basketRecipeItems.length,
                            itemBuilder: (context, int cardIndex) {
                              return BasketRecipeCard(
                                model: cubitRead.basketRecipeItems[cardIndex],
                                removeIconOnPressed: (() {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return QuestionAlertDialog(
                                          explanation: LocaleKeys.removeCard,
                                          onPressedYes: () {
                                            cubitRead
                                                .deleteItemFromBasketRecipeList(
                                                    cubitRead.basketRecipeItems[
                                                        cardIndex]);
                                          },
                                        );
                                      });
                                }),
                              );
                            },
                          ),
                        ),
                        context.lowSizedBox,
                        LocaleText(
                          text: LocaleKeys.toBuyList,
                          style: TextStyle(
                            fontSize: 24,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.instance.russianViolet,
                          ),
                        ),
                        context.lowSizedBox,
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: cubitRead.basketRecipeItems.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: context.paddingHighOnlyTop,
                              child: Row(
                                children: [
                                  // Stack(
                                  //   alignment:
                                  //       AlignmentDirectional.bottomCenter,
                                  //   children: [
                                  //     CircleAvatar(
                                  //         radius: 32,
                                  //         backgroundColor: Colors.amber,
                                  //         child: SvgPicture.asset(recipeModel
                                  //                 .ingredients[index]
                                  //                 .imagePath ??
                                  //             '')),
                                  //     Text(recipeModel
                                  //         .ingredients[index].quantity
                                  //         .toString()),
                                  //   ],
                                  // ),
                                  context.normalSizedBoxWidth,
                                  Text('ggg'),
                                  context.verySizedBoxWidth,
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.grey,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.done,
                                        color: ColorConstants.instance.white,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                  context.lowSizedBoxWidth,
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.red,
                                    child: IconButton(
                                      icon: const Icon(Icons.shopping_cart,
                                          color: Colors.white),
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        context.lowSizedBox,
                        LocaleText(
                          text: LocaleKeys.myPantry,
                          style: TextStyle(
                            fontSize: 24,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.instance.russianViolet,
                          ),
                        ),
                        context.lowSizedBox,
                        buildGridViewMyPantry(context),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  GridView buildGridViewMyPantry(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: context.read<HomeCubit>().myFrizeItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.75,
            crossAxisSpacing: 30,
            mainAxisSpacing: 20),
        itemBuilder: (context, index) {
          return IngredientCircleAvatar(
            color: ColorConstants.instance.russianViolet.withOpacity(0.1),
            model: context.read<HomeCubit>().myFrizeItems[index],
            iconBottomWidget: Text(
              context.read<HomeCubit>().myFrizeItems[index].quantity.toString(),
              style: TextStyle(color: ColorConstants.instance.white),
            ),
          );
        });
  }
}

/**
 *  Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            "Card ${i + 1}",
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                      ),





                       SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  //controller: PageController(viewportFraction: 0.7),
                  // onPageChanged: (int index) =>
                  //     setState(() => _index = index),
                  itemBuilder: (_, i) {
                    return Transform.scale(
                        scale: i == _index ? 1 : 0.9,
                        child: LikesRecipeCard(model: null,),);
                  },
                ),
              ),
 */
