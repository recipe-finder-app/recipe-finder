import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/widget/alert_dialog/alert_dialog_error.dart';
import 'package:recipe_finder/feature/likes_page/cubit/likes_state.dart';
import 'package:recipe_finder/product/widget/button/go_to_top_fab_button.dart';
import 'package:recipe_finder/product/widget/progress/recipe_progress.dart';

import '../../../core/base/view/base_view.dart';
import '../../../product/utils/constant/navigation_constant.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../../../core/widget/text/locale_bold_text.dart';
import '../../../product/widget/card/animated_saved_recipe_card.dart';
import '../../../product/widget/list_view/category_list_view.dart';
import '../../../product/widget/modal_bottom_sheet/add_to_basket_bottom_sheet/view/add_to_basket_bottom_sheet.dart';
import '../../../product/widget/text_field/search_text_field.dart';
import '../cubit/likes_cubit.dart';

class LikesView extends StatelessWidget {
  LikesView({
    Key? key,
  }) : super(key: key);
  late ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return BaseView<LikesCubit>(
      init: (cubitRead) {
        scrollController = ScrollController();
        cubitRead.init();
      },
      visibleProgress: false,
      onPageBuilder: (BuildContext context, cubitRead, cubitWatch) => Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: GoToTopFabButton(
          scrollController: scrollController,
        ),
        body: BlocConsumer<LikesCubit, LikesState>(
          listener: (context, state) {
            if(state.error!=null){
              showDialog(context: context, builder: (context){
                return AlertDialogError(text: state.error!.message ?? '');
              });
            }
          },
          builder: (context,state){
            return RecipeProgress(
            isLoading: state.isLoading,
            child: SafeArea(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: EdgeInsets.only(
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
                      SearchTextField(
                        controller: TextEditingController(),
                        width: context.screenWidth,
                      ),
                      context.normalSizedBox,
                       CategoryListView(                    
                        categoryList: [],
                      ),
                      context.normalSizedBox,
                      buildLikesRecipeGrid(cubitRead),
                    ],
                  ),
                ),
              ),
            ),
          );
          },
        ),
      ),
    );
  }

  Widget buildLikesRecipeGrid(LikesCubit cubitRead) {
    return BlocBuilder<LikesCubit, LikesState>(
      builder: (context, state) {
        return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.likedRecipeList!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 3 / 4,
            ),
            itemBuilder: (BuildContext context, int cardIndex) {
              return AnimatedLikesRecipeCard(
                model: state.likedRecipeList![cardIndex],
                addToBasketOnPressed: () {
                  AddToBasketBottomSheet.instance
                      .show(context, state.likedRecipeList![cardIndex]);
                },
                onPressed: () {
                  NavigationService.instance.navigateToPage(
                      path: NavigationConstant.RECIPE_DETAIL,
                      data: state.likedRecipeList![cardIndex]);
                  /* recipeBottomSheet(
                                context, cubitRead, cardIndex);*/
                },
                likeIconOnPressedYes: () async {
                  await cubitRead.removeItemFromLikedRecipeList(
                      state.likedRecipeList![cardIndex].id ?? '0');
                },
              );
            });
      },
    );
  }
}
