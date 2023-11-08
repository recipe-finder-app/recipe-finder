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
                  buildWhen: (prev,current){
                   // return false;
                  return  prev.isLoading!=current.isLoading || (prev.error!=null && (prev.error!.message.isNotEmpty || current.error!.message.isNotEmpty));
                  },
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
                    print("scaffold build oldu");
                    return RecipeProgress(
                      isLoading: state.isLoading,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
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
                                buildWhen: (prev,current){
                                if(prev.selectedCategory!=current.selectedCategory){
                                  return true;
                                } else {
                                  return false;
                                }
                                },
                                builder: (context, categoryState) {
                                   print("category build oldu");
                                  if (categoryState.recipeCategoryList == null || (categoryState.recipeCategoryList != null && categoryState.recipeCategoryList!.isEmpty )) {
                                    return const SizedBox.shrink();
                                  } else {
                                    return CategoryListView<RecipeCategory>(
                                      initialSelectedCategory:
                                          categoryState.recipeCategoryList?[0],
                                      categoryList:
                                          categoryState.recipeCategoryList ?? [],
                                      onPressed: (selectedCategory) async {
                                        
                                        if (selectedCategory.id != null) {
                                        cubitRead.changeSelectedCategory(selectedCategory);
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

  Widget buildTrendingNowGrid(DiscoverCubit cubitRead, DiscoverState state) {
    return 
     moreRecipeProgressIndicatorWidget(
          newPageLoading: state.newPageLoading == true,
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
                      likeIconOnPressed: (bool isRecipeContainsInLikedRecipeList) {
                        if(isRecipeContainsInLikedRecipeList){
                           showDialog(
                            context: context,
                            builder: (context) {
                              return QuestionAlertDialog(
                                explanation: LocaleKeys.deleteSavedRecipeQuestion,
                                onPressedYes: () {
                                  cubitRead.removeItemFromLikedRecipeList(state.recipeList![cardIndex].id ?? '0');
                                },
                              );
                            });                          
                        }
                        else {
                          cubitRead.addToLikedRecipeList(state.recipeList![cardIndex]);
                           Fluttertoast.showToast(timeInSecForIosWeb: 2, gravity: ToastGravity.CENTER, msg: LocaleKeys.favoriteRecipeMessage.locale, backgroundColor: ColorConstants.instance.oriolesOrange, textColor: Colors.white);
                        }
                       /* 
                         if (context.read<LikesCubit>().recipeList.contains(state.recipeList![cardIndex]) == false) {
                       
                       
                      } else if (context.read<LikesCubit>().recipeList.contains(state.recipeList![cardIndex]) == true) {
                       
                }*/
                });
                }));

  }

  Widget moreRecipeProgressIndicatorWidget({required Widget child,required bool newPageLoading}) {
    return newPageLoading ? Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        child,
        CircularProgressIndicator(
          strokeWidth: 4,
          color: ColorConstants.instance.oriolesOrange,
        ),
      ],
    ) : child;
  }
}
