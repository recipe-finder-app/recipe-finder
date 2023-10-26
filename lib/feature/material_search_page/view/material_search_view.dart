import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/base/view/base_view.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/init/language/language_manager.dart';
import 'package:recipe_finder/core/widget/alert_dialog/alert_dialog_error.dart';
import 'package:recipe_finder/product/utils/constant/navigation_constant.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/core/init/navigation/navigation_service.dart';
import 'package:recipe_finder/feature/material_search_page/cubit/material_state.dart';
import 'package:recipe_finder/product/widget/progress/recipe_progress.dart';

import '../../../core/widget/text/bold_text.dart';
import '../../../core/widget/text/locale_text.dart';
import '../../../product/model/ingredient_category/ingredient_category.dart';
import '../../../product/model/ingredient_quantity/ingredient_quantity.dart';
import '../../../product/widget/circle_avatar/amount_ingredient_circle_avatar.dart';
import '../../../product/widget/text_field/search_text_field.dart';
import '../cubit/material_cubit.dart';

class MaterialSearchView extends StatefulWidget {
  const MaterialSearchView({
    Key? key,
  }) : super(key: key);

  @override
  State<MaterialSearchView> createState() => _MaterialSearchViewState();
}

class _MaterialSearchViewState extends State<MaterialSearchView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<MaterialSearchCubit>(
        init: (cubitRead) async {
          cubitRead.setContext(context);
          await cubitRead.init();
        },
        dispose: (cubitRead) {
          cubitRead.dispose();
        },
        onPageBuilder: (BuildContext context, cubitRead, cubitWatch) => Scaffold(
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              floatingActionButton: SizedBox(
                width: context.floatinValueWidth,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    NavigationService.instance.navigateToPage(path: NavigationConstant.FINDER);
                  },
                  backgroundColor: ColorConstants.instance.roboticgods.withOpacity(1),
                  shape: RoundedRectangleBorder(borderRadius: context.radiusAllCircularMin),
                  label: LocaleText(
                    text: LocaleKeys.findMyRecipe,
                    style: TextStyle(color: ColorConstants.instance.white, fontSize: 16, fontFamily: 'Poppins'),
                  ),
                ),
              ),
             
              body: SafeArea(
                child: BlocConsumer<MaterialSearchCubit, MaterialSearchState>(
                  buildWhen: (prev,current){
                   return (prev.error!=current.error) || (prev.isLoading!=current.isLoading);
                  },
                  listener: (context,state){
                    if(state.error?.message!=null &&state.error!.message!.isNotEmpty){
                      showDialog(context: context, builder: (context){
                        return AlertDialogError(text: state.error!.message!);
                      });
                    }
                  },

                  builder: (context, state) {
                    return RecipeProgress(
                      isLoading: state.isLoading,
                      child: Padding(
                          padding: context.paddingNormalEdges,
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(children: [
                              context.mediumSizedBox,
                              _textRow(context),
                              context.mediumSizedBox,
                              SearchTextField(
                                controller: cubitRead.searchTextController,
                                width: context.screenWidth,
                                onPressedClear: () {
                                  cubitRead.changeIsSearchingState(false);
                                },
                                onChanged: (String data) {
                                  if (data.isEmpty) {
                                    cubitRead.changeIsSearchingState(false);
                                  } else {
                                    Future.delayed(const Duration(milliseconds: 300)).then((value){
                                     cubitRead.searchData(data);
                                    });
                                    
                                    //cubitRead.searchDataMultiThread(data);
                                  }
                                },
                              ),
                              context.mediumSizedBox,
                              buildIngredientCategoryList(cubitRead),
                            ]),
                          )),
                    );
                  },
                ),
              ),
            ));
  }

  Widget buildIngredientCategoryList(MaterialSearchCubit cubitRead) {
    return BlocSelector<MaterialSearchCubit, MaterialSearchState,Map<IngredientCategory, List<IngredientQuantity>>?>(
      
      selector: (state) {
      if (state.isSearching==true) {
        return state.materialSearchSearchedMap;
      } else{
        return state.materialSearchMap;
      }
    }, builder: (context, state) {
      
      if (state!.isEmpty) {
        return Padding(
          padding: context.paddingHighTop,
          child: const LocaleText(
            text: LocaleKeys.notFoundIngredient,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal),
          ),
        );
      } else {
        return buildIngredientList(state);
      }
    });
  }

  Widget buildIngredientList(Map<IngredientCategory, List<IngredientQuantity>> state) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: state.keys.length,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          String categoryName = (context.locale == LanguageManager.instance.trLocale ? state.keys.toList()[index].nameTR : state.keys.toList()[index].nameEN)!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: BoldText(
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal),
                  text: (categoryName),
                ),
              ),
              context.normalSizedBox,
              SizedBox(
                height: context.screenHeightIsLargerThan7Inch ? context.screenHeight / 8 : context.screenHeight / 7,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.values.toList()[index].length,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, indexIngredients) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: AmountIngredientCircleAvatar(
                          model: state.values.toList()[index][indexIngredients],
                        ),
                      );
                    }),
              ),
            ],
          );
        });
  }

  Widget _textRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios_new)),
        Expanded(
          child: LocaleText(
            maxLines: 2,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              color: ColorConstants.instance.blackbox,
            ),
            text: LocaleKeys.selectIngredients,
          ),
        ),
        TextButton(
          onPressed: () {
            NavigationService.instance.navigateToPage(path: NavigationConstant.NAV_CONTROLLER);
          },
          child: LocaleText(
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                color: ColorConstants.instance.russianViolet,
                // decoration: TextDecoration.underline,
                // decorationColor: ColorConstants.instance.russianViolet,
                // decorationThickness: 2,
              ),
              text: LocaleKeys.later),
        ),
      ],
    );
  }
}
