import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipe_finder/core/base/view/base_view.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/feature/discover_page/cubit/discover_cubit.dart';
import 'package:recipe_finder/feature/discover_page/cubit/discover_state.dart';
import 'package:recipe_finder/product/widget/progress/recipe_progress.dart';
import 'package:recipe_finder/product/widget/text_field/search_text_field.dart';

import '../../../core/constant/design/color_constant.dart';
import '../../../product/utils/constant/navigation_constant.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../../../core/widget/text/locale_bold_text.dart';
import '../../../product/widget/alert_dialog/question_alert_dialog.dart';
import '../../../product/widget/card/discover_card.dart';
import '../../../product/widget/list_view/category_list_view.dart';
import '../../likes_page/cubit/likes_cubit.dart';

class DiscoverView extends StatelessWidget {
  const DiscoverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<DiscoverCubit>(
        init: (cubitRead) {
          cubitRead.setContext(context);
          cubitRead.init();
        },
        dispose: (cubitRead) {
          cubitRead.dispose();
        },
        visibleProgress: false,
        onPageBuilder: (BuildContext context, cubitRead, cubitWatch) => Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: BlocBuilder<DiscoverCubit, DiscoverState>(
                  builder: (context, state) {
                    return RecipeProgress(
                      isLoading: state.isLoading,
                      child: SingleChildScrollView(
                        controller: cubitRead.scrollController,
                        child: Padding(
                          padding: EdgeInsets.only(top: context.mediumValue, left: context.normalValue, right: context.normalValue),
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
                              SearchTextField(
                                controller: TextEditingController(),
                                width: context.screenWidth,
                              ),
                              context.normalSizedBox,
                              BlocBuilder<DiscoverCubit, DiscoverState>(
                                builder: (context, state) {
                                  if (state.categoryList == null || state.selectedCategoryId == null) {
                                    return const SizedBox.shrink();
                                  } else {
                                    return CategoryListView(
                                      initialSelectedCategory: "Tümü",
                                      categoryList: (state.categoryList?.map((e) => e.categoryName!).toList())!,
                                      categoryIdList: (state.categoryList?.map((e) => e.id!).toList())!,
                                      onPressed: (selectedCategory, selectedCategoryId) async {
                                        cubitRead.changeSelectedCategory(selectedCategoryId);
                                        cubitRead.recipeListByCategory(selectedCategoryId);
                                      },
                                    );
                                  }
                                },
                              ),
                              context.normalSizedBox,
                              const LocaleBoldText(
                                text: LocaleKeys.trendingNow,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              context.lowSizedBox,
                              BlocBuilder<DiscoverCubit, DiscoverState>(
                                builder: (context, state) {
                                  if (state.selectedCategoryId == null || state.categoryList == null) {
                                    return const SizedBox.shrink();
                                  } else {
                                    return buildTrendingNowGrid(cubitRead, state, state.selectedCategoryId);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ));
  }
/*
  Widget buildTrendingNowGrid(DiscoverCubit cubitRead, DiscoverState state, categoryId) {
    return state.isLoading == true
        ? const Center()
        : RefreshIndicator(
            onRefresh: () => Future.sync(
              () => cubitRead.pagingController.refresh(),
            ),
            child: PagedGridView<int, RecipeModel>(
              pagingController: cubitRead.pagingController,
              builderDelegate: PagedChildBuilderDelegate<RecipeModel>(itemBuilder: (context, item, cardIndex) {
                return DiscoverCard(
                  model: item,
                  onPressed: () {
                    NavigationService.instance.navigateToPage(path: NavigationConstants.RECIPE_DETAIL, data: cubitRead.discoverRecipeList[cardIndex]);
                  },
                  likeIconOnPressed: () {
                    if (context.read<LikesCubit>().recipeList.contains(cubitRead.discoverRecipeList[cardIndex]) == false) {
                      context.read<LikesCubit>().addItemFromLikedRecipeList(cubitRead.discoverRecipeList[cardIndex]);
                      Fluttertoast.showToast(timeInSecForIosWeb: 2, gravity: ToastGravity.CENTER, msg: LocaleKeys.favoriteRecipeMessage.locale, backgroundColor: ColorConstants.instance.oriolesOrange, textColor: Colors.white);
                    } else if (context.read<LikesCubit>().recipeList.contains(cubitRead.discoverRecipeList[cardIndex]) == true) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return QuestionAlertDialog(
                              explanation: LocaleKeys.deleteSavedRecipeQuestion,
                              onPressedYes: () {
                                context.read<LikesCubit>().deleteItemFromLikedRecipeList(cubitRead.discoverRecipeList[cardIndex]);
                              },
                            );
                          });
                    }
                  },
                );
              }),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 1 / 1,
              ),
            ),
          );
  }
  */

  Widget buildTrendingNowGrid(DiscoverCubit cubitRead, DiscoverState state, categoryId) {
    return state.newPageLoading == true
        ? moreRecipeProgressIndicatorWidget(
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: (cubitRead.recipeListByCategory(categoryId)?.length ?? 0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 1 / 1,
                ),
                itemBuilder: (BuildContext context, int cardIndex) {
                  return DiscoverCard(
                    model: cubitRead.recipeListByCategory(categoryId)![cardIndex],
                    onPressed: () {
                      NavigationService.instance.navigateToPage(path: NavigationConstant.RECIPE_DETAIL, data: cubitRead.discoverRecipeList[cardIndex]);
                    },
                    likeIconOnPressed: () {
                      if (context.read<LikesCubit>().recipeList.contains(cubitRead.discoverRecipeList[cardIndex]) == false) {
                        context.read<LikesCubit>().addItemFromLikedRecipeList(cubitRead.discoverRecipeList[cardIndex]);
                        Fluttertoast.showToast(timeInSecForIosWeb: 2, gravity: ToastGravity.CENTER, msg: LocaleKeys.favoriteRecipeMessage.locale, backgroundColor: ColorConstants.instance.oriolesOrange, textColor: Colors.white);
                      } else if (context.read<LikesCubit>().recipeList.contains(cubitRead.discoverRecipeList[cardIndex]) == true) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return QuestionAlertDialog(
                                explanation: LocaleKeys.deleteSavedRecipeQuestion,
                                onPressedYes: () {
                                  context.read<LikesCubit>().deleteItemFromLikedRecipeList(cubitRead.discoverRecipeList[cardIndex]);
                                },
                              );
                            });
                      }
                    },
                  );
                }))
        : GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: (cubitRead.recipeListByCategory(categoryId)?.length ?? 0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 1 / 1,
            ),
            itemBuilder: (BuildContext context, int cardIndex) {
              return DiscoverCard(
                model: cubitRead.recipeListByCategory(categoryId)![cardIndex],
                onPressed: () {
                  NavigationService.instance.navigateToPage(path: NavigationConstant.RECIPE_DETAIL, data: cubitRead.discoverRecipeList[cardIndex]);
                },
                likeIconOnPressed: () {
                  if (context.read<LikesCubit>().recipeList.contains(cubitRead.discoverRecipeList[cardIndex]) == false) {
                    context.read<LikesCubit>().addItemFromLikedRecipeList(cubitRead.discoverRecipeList[cardIndex]);
                    Fluttertoast.showToast(timeInSecForIosWeb: 2, gravity: ToastGravity.CENTER, msg: LocaleKeys.favoriteRecipeMessage.locale, backgroundColor: ColorConstants.instance.oriolesOrange, textColor: Colors.white);
                  } else if (context.read<LikesCubit>().recipeList.contains(cubitRead.discoverRecipeList[cardIndex]) == true) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return QuestionAlertDialog(
                            explanation: LocaleKeys.deleteSavedRecipeQuestion,
                            onPressedYes: () {
                              context.read<LikesCubit>().deleteItemFromLikedRecipeList(cubitRead.discoverRecipeList[cardIndex]);
                            },
                          );
                        });
                  }
                },
              );
            });
  }

  Widget moreRecipeProgressIndicatorWidget({required Widget child}) {
    print("moreRecipeProgressIndicatorWidget");
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        child,
        CircularProgressIndicator(
          strokeWidth: 4,
          color: ColorConstants.instance.oriolesOrange,
        ),
      ],
    );
  }
}
