import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipe_finder/core/base/view/base_view.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/core/init/language/language_manager.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/core/widget/alert_dialog/alert_dialog_error.dart';
import 'package:recipe_finder/feature/discover_page/cubit/discover_cubit.dart';
import 'package:recipe_finder/feature/discover_page/cubit/discover_state.dart';
import 'package:recipe_finder/product/model/recipe/recipe.dart';
import 'package:recipe_finder/product/model/recipe_category/recipe_category.dart';
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
  DiscoverView({Key? key}) : super(key: key);
  late ScrollController scrollController;
  late TextEditingController controller;
  //late PagingController<int, Recipe> pagingController;
  @override
  Widget build(BuildContext context) {
    return BaseView<DiscoverCubit>(
        init: (cubitRead) {
          // pagingController = PagingController(firstPageKey: 1);
          scrollController = ScrollController();
          controller = TextEditingController();
          cubitRead.setContext(context);
          cubitRead.init();
          scrollController.addListener(() async {
            if (scrollController.offset ==
                    scrollController.position.maxScrollExtent &&
                cubitRead.state.newPageLoading == false) {
              //await fetchMoreRecipe();
            }
          });
        },
        dispose: (cubitRead) {
          // pagingController.dispose();
          scrollController.dispose();
          cubitRead.dispose();
        },
        visibleProgress: false,
        onPageBuilder: (BuildContext context, cubitRead, cubitWatch) =>
            Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: BlocConsumer<DiscoverCubit, DiscoverState>(
                  listener: (context, state) {
                    if (state.error != null &&
                        state.error!.message.isNotEmpty) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialogError(text: state.error!.message);
                          });
                    }
                  },
                  builder: (context, state) {
                    return RecipeProgress(
                      isLoading: state.isLoading,
                      child: SingleChildScrollView(
                        controller: scrollController,
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
                              SearchTextField(
                                controller: controller,
                                width: context.screenWidth,
                              ),
                              context.normalSizedBox,
                              BlocBuilder<DiscoverCubit, DiscoverState>(
                                builder: (context, state) {
                                  if (state.recipeCategoryList == null || (state.recipeCategoryList != null && state.recipeCategoryList!.isEmpty )) {
                                    return const SizedBox.shrink();
                                  } else {
                                    return CategoryListView<RecipeCategory>(
                                      initialSelectedCategory:
                                          state.recipeCategoryList?[0],
                                      categoryList:
                                          state.recipeCategoryList ?? [],
                                      onPressed: (selectedCategory) async {
                                        if (selectedCategory.id != null) {
                                          await cubitRead
                                              .fetchRecipeListByCategoryId(
                                                  selectedCategory.id!);
                                        }
                                      },
                                    );
                                  }
                                },
                              ),
                              context.normalSizedBox,
                               BlocBuilder<DiscoverCubit, DiscoverState>(
                                builder: (context, state) {
                                   String categoryName = (context.locale == LanguageManager.instance.trLocale ? state.selectedCategory?.nameTR ?? '' : state.selectedCategory?.nameEN ?? '');
                                  return LocaleBoldText(
                                    text: categoryName,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  );
                                },
                              ),
                              context.lowSizedBox,
                              BlocBuilder<DiscoverCubit, DiscoverState>(
                                builder: (context, state) {
                                  if (state.recipeCategoryList == null) {
                                    return const SizedBox.shrink();
                                  } else {
                                    return buildTrendingNowGrid(
                                        cubitRead, state);
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

  Widget buildTrendingNowGrid(DiscoverCubit cubitRead, DiscoverState state) {
    return state.newPageLoading == true
        ? moreRecipeProgressIndicatorWidget(
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.recipeList?.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 1 / 1,
                ),
                itemBuilder: (BuildContext context, int cardIndex) {
                  final recipe = state.recipeList![cardIndex];
                  return DiscoverCard(
                      model: recipe,
                      //model: cubitRead.recipeListByCategory(categoryId)![cardIndex],
                      onPressed: () {
                        NavigationService.instance.navigateToPage(
                            path: NavigationConstant.RECIPE_DETAIL,
                            data: recipe);
                      },
                      likeIconOnPressed: () {
                        /* if (context.read<LikesCubit>().recipeList.contains(cubitRead.discoverRecipeList[cardIndex]) == false) {
                        context.read<LikesCubit>().addItemFromLikedRecipeList(cubitRead.discoverRecipeList[cardIndex]);
                        Fluttertoast.showToast(timeInSecForIosWeb: 2, gravity: ToastGravity.CENTER, msg: LocaleKeys.favoriteRecipeMessage.locale, backgroundColor: ColorConstants.instance.oriolesOrange, textColor: Colors.white);
                      } else if (context.read<LikesCubit>().recipeList.contains(cubitRead.discoverRecipeList[cardIndex]) == true) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return QuestionAlertDialog(
                                explanation: LocaleKeys.deleteSavedRecipeQuestion,
                                onPressedYes: () {
                                 // context.read<LikesCubit>().deleteItemFromLikedRecipeList(cubitRead.discoverRecipeList[cardIndex]);
                                },
                              );
                            });*/
                      });
                }))
        : GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.recipeList?.length,
            //temCount: (cubitRead.recipeListByCategory(categoryId)?.length ?? 0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 1 / 1,
            ),
            itemBuilder: (BuildContext context, int cardIndex) {
              final recipe = state.recipeList![cardIndex];
              return DiscoverCard(
                  model: recipe,
                  // model: cubitRead.recipeListByCategory(categoryId)![cardIndex],
                  onPressed: () {
                    NavigationService.instance.navigateToPage(
                        path: NavigationConstant.RECIPE_DETAIL, data: recipe);
                  },
                  likeIconOnPressed: () {
                    /* if (context.read<LikesCubit>().recipeList.contains(cubitRead.discoverRecipeList[cardIndex]) == false) {
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
                        });*/
                  });
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
