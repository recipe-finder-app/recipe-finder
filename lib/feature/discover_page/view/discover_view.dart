import 'package:flutter/material.dart';
import 'package:recipe_finder/core/base/view/base_view.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/feature/discover_page/cubit/discover_cubit.dart';
import 'package:recipe_finder/product/widget/alert_dialog/question_alert_dialog.dart';
import 'package:recipe_finder/product/widget/listview/category_list_view.dart';
import 'package:recipe_finder/product/widget/text_field/search_voice_text_formfield.dart';
import 'package:recipe_finder/product/widget_core/text/locale_bold_text.dart';

import '../../../core/constant/navigation/navigation_constants.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../../../product/widget/card/discover_card.dart';

class DiscoverView extends StatelessWidget {
  const DiscoverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<DiscoverCubit>(
        init: (cubitRead) {},
        visibleProgress: false,
        onPageBuilder: (BuildContext context, cubitRead, cubitWatch) =>
            Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: context.mediumValue,
                        left: context.normalValue,
                        right: context.normalValue),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const LocaleBoldText(
                          text: LocaleKeys.findBestRecipesForCooking,
                          maxLines: 2,
                          fontSize: 24,
                        ),
                        context.normalSizedBox,
                        SearchVoiceTextFormField(
                          controller: TextEditingController(),
                          width: context.screenWidth,
                        ),
                        context.normalSizedBox,
                        CategoryListView(),
                        context.normalSizedBox,
                        const LocaleBoldText(
                          text: LocaleKeys.trendingNow,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        context.lowSizedBox,
                        buildTrendingNowGrid(cubitRead),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  GridView buildTrendingNowGrid(DiscoverCubit cubitRead) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: cubitRead.discoverRecipeList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 1 / 1,
        ),
        itemBuilder: (BuildContext context, int cardIndex) {
          return DiscoverCard(
            model: cubitRead.discoverRecipeList[cardIndex],
            addToBasketOnPressed: () {},
            recipeOnPressed: () {
              NavigationService.instance.navigateToPage(
                  path: NavigationConstants.RECIPE_DETAIL,
                  data: cubitRead.discoverRecipeList[cardIndex]);
              /* recipeBottomSheet(
                              context, cubitRead, cardIndex);*/
            },
            likeIconOnPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return QuestionAlertDialog(
                      explanation: LocaleKeys.deleteSavedRecipeQuestion,
                      onPressedYes: () {
                        cubitRead.deleteItemFromDiscoverRecipeList(
                            cubitRead.discoverRecipeList[cardIndex]);
                      },
                    );
                  });
            },
          );
        });
  }
}
