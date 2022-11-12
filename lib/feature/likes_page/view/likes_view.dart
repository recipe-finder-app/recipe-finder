import 'package:flutter/material.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/feature/likes_page/model/saved_recipe_model.dart';
import 'package:recipe_finder/product/component/card/saved_recipe_card.dart';

import '../../../core/base/view/base_view.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../../product/component/text/locale_bold_text.dart';
import '../../../product/widget/progress/recipe_progress.dart';
import '../cubit/likes_cubit.dart';

class LikesView extends StatelessWidget {
  const LikesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<SavedRecipeModel> savedRecipeItems = SavedRecipeItems().items;
    return BaseView<LikesCubit>(
      init: (cubitRead) {
        cubitRead.init();
      },
      onPageBuilder: (BuildContext context, cubitRead, cubitWatch) => Scaffold(
        body: false == true
            ? RecipeProgress()
            : SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: context.normalValue),
                        child: Padding(
                          padding: EdgeInsets.only(top: context.mediumValue),
                          child: const LocaleBoldText(
                            text: LocaleKeys.mySavedRecipes,
                            fontSize: 29,
                          ),
                        ),
                      ),
                      context.normalSizedBox,
                      GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: savedRecipeItems.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 3,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: index % 2 != 0 ? context.lowValue : 0,
                                right: index % 2 != 0 ? context.normalValue : 0,
                              ),
                              child: Padding(
                                  padding: EdgeInsets.only(
                                    left: index % 2 == 0
                                        ? context.normalValue
                                        : 0,
                                    right:
                                        index % 2 == 0 ? context.lowValue : 0,
                                    bottom: context.normalValue,
                                  ),
                                  child: SavedRecipeCard(
                                    model: savedRecipeItems[index],
                                  )),
                            );
                          }),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
