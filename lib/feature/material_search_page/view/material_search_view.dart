import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/base/view/base_view.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/constant/navigation/navigation_constants.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/core/init/navigation/navigation_service.dart';
import 'package:recipe_finder/feature/material_search_page/cubit/material_state.dart';
import 'package:recipe_finder/feature/material_search_page/model/material_model.dart';
import 'package:recipe_finder/product/model/ingradient_model.dart';
import 'package:recipe_finder/product/widget/alert_dialog/amount_alert_dialog.dart';
import 'package:recipe_finder/product/widget_core/text/locale_text.dart';

import '../../../product/widget/circle_avatar/ingredient_circle_avatar.dart';
import '../../../product/widget/text_field/search_voice_text_formfield.dart';
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
        },
        dispose: (cubitRead) {
          cubitRead.dispose();
        },
        visibleProgress: false,
        onPageBuilder: (BuildContext context, cubitRead, cubitWatch) =>
            Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: SizedBox(
                width: context.floatinValueWidth,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    NavigationService.instance
                        .navigateToPage(path: NavigationConstants.FINDER);
                  },
                  backgroundColor:
                      ColorConstants.instance.roboticgods.withOpacity(1),
                  shape: RoundedRectangleBorder(
                      borderRadius: context.radiusAllCircularMin),
                  label: LocaleText(
                    text: LocaleKeys.findMyRecipe,
                    style: TextStyle(color: ColorConstants.instance.white),
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
                        SearchVoiceTextFormField(
                          controller: cubitRead.searchTextController,
                          onPressedClear: () {
                            cubitRead.ingredientListLoad();
                          },
                          onChanged: (String data) {
                            if (data.isEmpty) {
                              cubitRead.ingredientListLoad();
                              print('liste yüklendi');
                            } else {
                              cubitRead.searchData(data);
                              print('liste search yüklendi');
                            }
                          },
                        ),
                        context.mediumSizedBox,
                        BlocSelector<
                            MaterialSearchCubit,
                            IMaterialSearchState,
                            Map<MaterialSearchCategory,
                                List<IngredientModel>>?>(selector: (state) {
                          if (state is SearchedIngredientListLoad) {
                            return state.searchedMap;
                          } else if (state is IngredientListLoad) {
                            return state.materialSearchMap;
                          } else {
                            return cubitRead
                                .materialSearchModel.materialSearchMap;
                          }
                        }, builder: (context, state) {
                          if (state!.isEmpty) {
                            return Padding(
                              padding: context.paddingHighTop,
                              child: const LocaleText(
                                text: 'Aranan isimde ürün bulunamadı',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal),
                              ),
                            );
                          } else {
                            return Column(
                              children: [
                                BlocSelector<
                                    MaterialSearchCubit,
                                    IMaterialSearchState,
                                    List<IngredientModel>?>(
                                  selector: (state) {
                                    if (state is IngredientListLoad) {
                                      return state.materialSearchMap![
                                          MaterialSearchCategory.essentials];
                                    } else if (state
                                        is SearchedIngredientListLoad) {
                                      return state.searchedMap![
                                          MaterialSearchCategory.essentials];
                                    } else {
                                      return cubitRead.materialSearchModel
                                              .materialSearchMap[
                                          MaterialSearchCategory.essentials];
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state == null) {
                                      return const SizedBox();
                                    } else {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Align(
                                            alignment: Alignment.centerLeft,
                                            child: LocaleText(
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal),
                                              text: LocaleKeys.essentials,
                                            ),
                                          ),
                                          context.normalSizedBox,
                                          SizedBox(
                                            height: context.screenHeight / 8,
                                            child: ListView.builder(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: state?.length ?? 0,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        context.paddingRight,
                                                    child:
                                                        IngredientCircleAvatar(
                                                            model:
                                                                state![index],
                                                            onPressed: () {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AmountAlertDialog(
                                                                        model: state![
                                                                            index]);
                                                                  });
                                                            },
                                                           
                                                            ),
                                                  );
                                                }),
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                ),
                                BlocSelector<
                                    MaterialSearchCubit,
                                    IMaterialSearchState,
                                    List<IngredientModel>?>(
                                  selector: (state) {
                                    if (state is IngredientListLoad) {
                                      return state.materialSearchMap![
                                          MaterialSearchCategory.vegatables];
                                    } else if (state
                                        is SearchedIngredientListLoad) {
                                      return state.searchedMap![
                                          MaterialSearchCategory.vegatables];
                                    } else {
                                      return cubitRead.materialSearchModel
                                              .materialSearchMap[
                                          MaterialSearchCategory.vegatables];
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state == null) {
                                      return const SizedBox();
                                    } else {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Align(
                                            alignment: Alignment.centerLeft,
                                            child: LocaleText(
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal),
                                              text: LocaleKeys.vegatables,
                                            ),
                                          ),
                                          context.normalSizedBox,
                                          GridView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: state?.length ?? 0,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 4,
                                                      childAspectRatio: 0.70,
                                                      crossAxisSpacing: 30,
                                                      mainAxisSpacing: 20),
                                              itemBuilder: (context, index) {
                                                return IngredientCircleAvatar(
                                                  model: state![index],
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AmountAlertDialog(
                                                              model: state![
                                                                  index]);
                                                        });
                                                  },
                                                );
                                              }),
                                        ],
                                      );
                                    }
                                  },
                                ),
                                BlocSelector<
                                    MaterialSearchCubit,
                                    IMaterialSearchState,
                                    List<IngredientModel>?>(
                                  selector: (state) {
                                    if (state is IngredientListLoad) {
                                      return state.materialSearchMap![
                                          MaterialSearchCategory.fruits];
                                    } else if (state
                                        is SearchedIngredientListLoad) {
                                      return state.searchedMap![
                                          MaterialSearchCategory.fruits];
                                    } else {
                                      return cubitRead.materialSearchModel
                                              .materialSearchMap[
                                          MaterialSearchCategory.fruits];
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state == null) {
                                      return const SizedBox();
                                    } else {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Align(
                                            alignment: Alignment.centerLeft,
                                            child: LocaleText(
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal),
                                              text: LocaleKeys.fruits,
                                            ),
                                          ),
                                          context.normalSizedBox,
                                          GridView.builder(
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 4,
                                                      childAspectRatio: 0.70,
                                                      crossAxisSpacing: 30,
                                                      mainAxisSpacing: 20),
                                              itemCount: state?.length ?? 0,
                                              itemBuilder: (context, index) {
                                                return IngredientCircleAvatar(
                                                  model: state![index],
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AmountAlertDialog(
                                                              model: state![
                                                                  index]);
                                                        });
                                                  },
                                                );
                                              }),
                                        ],
                                      );
                                    }
                                  },
                                ),
                              ],
                            );
                          }
                        }),
                      ]),
                    )),
              ),
            ));
  }

  Widget _textRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: LocaleText(
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                color: ColorConstants.instance.blackbox,
              ),
              text: LocaleKeys.selectIngredients,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            NavigationService.instance
                .navigateToPage(path: NavigationConstants.NAV_CONTROLLER);
          },
          child: LocaleText(
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                color: ColorConstants.instance.russianViolet,
                decoration: TextDecoration.underline,
                decorationColor: ColorConstants.instance.russianViolet,
                decorationThickness: 2,
              ),
              text: LocaleKeys.later),
        ),
      ],
    );
  }
}
