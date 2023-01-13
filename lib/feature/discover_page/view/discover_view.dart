import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipe_finder/core/base/view/base_view.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/feature/discover_page/cubit/discover_cubit.dart';
import 'package:recipe_finder/product/widget/text_field/search_voice_text_formfield.dart';
import 'package:recipe_finder/product/widget_core/text/locale_bold_text.dart';

import '../../../core/constant/design/color_constant.dart';
import '../../../core/constant/navigation/navigation_constants.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../../../product/widget/alert_dialog/question_alert_dialog.dart';
import '../../../product/widget/card/discover_card.dart';
import '../../../product/widget/list_view/category_list_view.dart';
import '../../likes_page/cubit/likes_cubit.dart';

class DiscoverView extends StatelessWidget {
  const DiscoverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<DiscoverCubit>(
        init: (cubitRead) {},
        visibleProgress: false,
        onPageBuilder: (BuildContext context, cubitRead, cubitWatch) => Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: SingleChildScrollView(
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
        });
  }
}
