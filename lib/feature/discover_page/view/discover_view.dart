import 'package:flutter/material.dart';
import 'package:recipe_finder/core/base/view/base_view.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/feature/discover_page/cubit/discover_cubit.dart';
import 'package:recipe_finder/feature/discover_page/model/discover_model.dart';
import 'package:recipe_finder/product/component/text/locale_bold_text.dart';
import 'package:recipe_finder/product/component/text/locale_text.dart';
import 'package:recipe_finder/product/widget/text_field/search_voice_text_formfield.dart';

import '../../../core/constant/navigation/navigation_constants.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../../../product/component/card/discover_card.dart';

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
                          width: context.screenWidth,
                        ),
                        context.normalSizedBox,
                        SizedBox(
                          height: 40,
                          width: context.screenWidth,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount:
                                  DiscoverCategoryItems().categories.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding:
                                      EdgeInsets.only(right: context.lowValue),
                                  child: InkWell(
                                    onTap: () {
                                      cubitRead
                                          .changeSelectedCategoryIndex(index);
                                    },
                                    child: Container(
                                      constraints: const BoxConstraints(
                                          maxWidth: double.infinity,
                                          minWidth: 50),
                                      decoration: BoxDecoration(
                                        border:
                                            cubitRead.selectedCategoryIndex ==
                                                    index
                                                ? null
                                                : Border.all(
                                                    color: Colors.black,
                                                    width: 0.5),
                                        color:
                                            cubitRead.categoryItemColor(index),
                                        borderRadius:
                                            context.radiusAllCircularMedium,
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: context.paddingLowEdges,
                                          child: LocaleText(
                                            text: DiscoverCategoryItems()
                                                .categories[index],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: cubitRead
                                                    .categoryTextColor(index)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        context.normalSizedBox,
                        const LocaleBoldText(
                          text: LocaleKeys.trendingNow,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        context.lowSizedBox,
                        GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: cubitRead.discoverRecipeList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
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
                                      data: cubitRead
                                          .discoverRecipeList[cardIndex]);
                                  /* recipeBottomSheet(
                                context, cubitRead, cardIndex);*/
                                },
                                likeIconOnPressed: () {},
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
