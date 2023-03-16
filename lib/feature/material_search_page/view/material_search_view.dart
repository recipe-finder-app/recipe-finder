import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/base/view/base_cubit.dart';
import 'package:recipe_finder/core/base/view/base_view.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/constant/navigation/navigation_constants.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/core/init/navigation/navigation_service.dart';
import 'package:recipe_finder/feature/material_search_page/cubit/material_state.dart';
import 'package:recipe_finder/product/model/ingredient/ingredient_model.dart';
import 'package:recipe_finder/product/widget_core/text/bold_text.dart';
import 'package:recipe_finder/product/widget_core/text/locale_text.dart';

import '../../../product/model/ingredient_category/category_of_ingredient_model.dart';
import '../../../product/widget/circle_avatar/amount_ingredient_circle_avatar.dart';
import '../../../product/widget/text_field/speech_to_text_formfield.dart';
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
        init: (cubitRead) {
          cubitRead.init();
          cubitRead.setContext(context);
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
                    NavigationService.instance.navigateToPage(path: NavigationConstants.FINDER);
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
                child: Padding(
                    padding: context.paddingNormalEdges,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(children: [
                        context.mediumSizedBox,
                        _textRow(context),
                        context.mediumSizedBox,
                        SpeechToTextFormField(
                          controller: cubitRead.searchTextController,
                          onPressedClear: () {
                            cubitRead.ingredientListLoad();
                          },
                          onChanged: (String data) {
                            if (data.isEmpty) {
                              cubitRead.ingredientListLoad();
                            } else {
                              cubitRead.searchData(data);
                            }
                          },
                        ),
                        context.mediumSizedBox,
                        buildCategoryOfIngredientList(cubitRead),
                      ]),
                    )),
              ),
            ));
  }

  Widget buildCategoryOfIngredientList(MaterialSearchCubit cubitRead) {
    if (context.read<BaseCubit>().isLoading == true) {
      return const Center();
    } else {
      return BlocSelector<MaterialSearchCubit, IMaterialSearchState, Map<CategoryOfIngredientModel, List<IngredientModel>>?>(selector: (state) {
        if (state is SearchedIngredientListLoad) {
          return state.searchedMap;
        } else if (state is IngredientListLoad) {
          return state.materialSearchMap;
        } else {
          return cubitRead.materialSearchInitMap;
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
  }

  Widget buildIngredientList(Map<CategoryOfIngredientModel, List<IngredientModel>> state) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: state.keys.length,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: BoldText(
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal),
                  text: (state.keys.toList()[index].categoryName)!,
                ),
              ),
              context.normalSizedBox,
              SizedBox(
                height: context.screenHeightIsLargerThan7Inch ? context.screenHeight / 3.5 : context.screenHeight / 2.5,
                child: Scrollbar(
                  thumbVisibility: true,
                  child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: state.values.toList()[index].length,
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: 3 / 4,
                      ),
                      itemBuilder: (context, indexIngredients) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 25),
                          child: AmountIngredientCircleAvatar(
                            model: state.values.toList()[index][indexIngredients],
                          ),
                        );
                      }),
                ),
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
            NavigationService.instance.navigateToPage(path: NavigationConstants.NAV_CONTROLLER);
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
