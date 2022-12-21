import 'package:flutter/material.dart';
import 'package:recipe_finder/core/base/view/base_view.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/feature/discover_page/cubit/discover_cubit.dart';
import 'package:recipe_finder/product/component/text/locale_bold_text.dart';
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
        onPageBuilder: (BuildContext context, cubitRead, cubitWatch) =>
            Scaffold(
              body: Container(
                color: Colors.white,
                child: SafeArea(
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
                                itemCount: 5,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        right: context.lowValue),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 0.5),
                                        color: Colors.white,
                                        borderRadius:
                                            context.radiusAllCircularMedium,
                                      ),
                                      width: 70,
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Text("All")),
                                    ),
                                  );
                                }),
                          ),
                          context.normalSizedBox,
                          const LocaleBoldText(
                            text: LocaleKeys.trendingNow,
                            fontSize: 16,
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
                              itemBuilder:
                                  (BuildContext context, int cardIndex) {
                                return DiscoverCard(
                                  model:
                                      cubitRead.discoverRecipeList[cardIndex],
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
              ),
            ));
  }
}
