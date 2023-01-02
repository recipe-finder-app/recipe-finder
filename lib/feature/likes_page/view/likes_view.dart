import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/product/widget/alert_dialog/question_alert_dialog.dart';
import 'package:recipe_finder/product/widget/button/go_to_top_fab_button.dart';

import '../../../core/base/view/base_view.dart';
import '../../../core/constant/navigation/navigation_constants.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../../../product/widget/card/saved_recipe_card.dart';
import '../../../product/widget/listview/category_list_view.dart';
import '../../../product/widget/modal_bottom_sheet/add_to_basket_bottom_sheet/view/add_to_basket_bottom_sheet.dart';
import '../../../product/widget/text_field/search_voice_text_formfield.dart';
import '../../../product/widget_core/text/locale_bold_text.dart';
import '../cubit/likes_cubit.dart';

class LikesView extends StatelessWidget {
  const LikesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<LikesCubit>(
      init: (cubitRead) {
        cubitRead.init();
      },
      visibleProgress: false,
      onPageBuilder: (BuildContext context, cubitRead, cubitWatch) => Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: GoToTopFabButton(
          scrollController: cubitRead.scrollController,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            controller: cubitRead.scrollController,
            child: Padding(
              padding: EdgeInsets.only(
                top: context.mediumValue,
                left: context.normalValue,
                right: context.normalValue,
                bottom: context.highValue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LocaleBoldText(
                    text: LocaleKeys.mySavedRecipes,
                    fontSize: 29,
                  ),
                  context.normalSizedBox,
                  SearchVoiceTextFormField(
                    controller: TextEditingController(),
                    width: context.screenWidth,
                  ),
                  context.normalSizedBox,
                  CategoryListView(),
                  context.normalSizedBox,
                  GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cubitRead.recipeList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 3 / 4,
                      ),
                      itemBuilder: (BuildContext context, int cardIndex) {
                        return LikesRecipeCard(
                          model: cubitRead.recipeList[cardIndex],
                          addToBasketOnPressed: () {
                            AddToBasketBottomSheet.instance.show(context,
                                cubitRead.recipeList![cardIndex].ingredients);
                          },
                          recipeOnPressed: () {
                            NavigationService.instance.navigateToPage(
                                path: NavigationConstants.RECIPE_DETAIL,
                                data: cubitRead.recipeList[cardIndex]);
                            /* recipeBottomSheet(
                                context, cubitRead, cardIndex);*/
                          },
                          likeIconOnPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return QuestionAlertDialog(
                                    explanation:
                                        LocaleKeys.deleteSavedRecipeQuestion,
                                    onPressedYes: () {
                                      cubitRead.deleteItemFromLikedRecipeList(
                                          cubitRead.recipeList[cardIndex]);
                                    },
                                  );
                                });
                          },
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
