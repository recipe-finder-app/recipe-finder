import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/base/view/base_view.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/constant/navigation/navigation_constants.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/core/init/navigation/navigation_service.dart';
import 'package:recipe_finder/feature/material_search_page/cubit/material2_state.dart';
import 'package:recipe_finder/feature/material_search_page/model/material2_model.dart';
import 'package:recipe_finder/product/component/text/locale_text.dart';
import 'package:recipe_finder/product/model/ingradient_model.dart';

import '../../../product/widget/circle_avatar/ingredient_circle_avatar.dart';
import '../../../product/widget/text_field/search_voice_text_formfield.dart';
import '../cubit/material2_cubit.dart';

class MaterialSearch2View extends StatefulWidget {
  const MaterialSearch2View({
    Key? key,
  }) : super(key: key);

  @override
  State<MaterialSearch2View> createState() => _MaterialSearch2ViewState();
}

class _MaterialSearch2ViewState extends State<MaterialSearch2View> {
  bool _click = true;
  @override
  Widget build(BuildContext context) {
    return BaseView<MaterialSearch2Cubit>(
        init: (cubitRead) {
          cubitRead.init();
        },
        onPageBuilder: (BuildContext context, cubitRead, cubitWatch) =>
            Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: SizedBox(
                width: context.floatinValueWidth,
                child: FloatingActionButton.extended(
                  onPressed: () {},
                  backgroundColor: _click
                      ? ColorConstants.instance.roboticgods.withOpacity(1)
                      : ColorConstants.instance.oriolesOrange,
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
                        _textRow(context),
                        context.mediumSizedBox,
                        Wrap(
                            direction: Axis.vertical,
                            runSpacing: context.normalValue,
                            spacing: context.normalValue,
                            children: [
                              SearchVoiceTextFormField(
                                controller: cubitRead.searchTextController,
                                width: context.screenWidth / 1.2,
                                onChanged: (String data) {
                                  if (data.isEmpty) {
                                    cubitRead.ingredientListLoad();
                                  } else {
                                    cubitRead.searchData(data);
                                  }
                                },
                              ),
                              BlocSelector<
                                  MaterialSearch2Cubit,
                                  IMaterialSearch2State,
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
                                    return SizedBox(
                                      height: context.screenHeight / 6,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Flexible(
                                            flex: 1,
                                            child: LocaleText(
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal),
                                              text: LocaleKeys.essentials,
                                            ),
                                          ),
                                          Flexible(
                                            flex: 3,
                                            child: ListView.builder(
                                                padding: EdgeInsets.zero,
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
                                                    child: Column(
                                                      children: [
                                                        IngredientCircleAvatar(
                                                          color: Colors.blue,
                                                          model: state![index],
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                              BlocSelector<
                                  MaterialSearch2Cubit,
                                  IMaterialSearch2State,
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
                                    return SizedBox(
                                      height: context.screenHeight / 6,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Flexible(
                                            flex: 1,
                                            child: LocaleText(
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal),
                                              text: LocaleKeys.vegatables,
                                            ),
                                          ),
                                          Flexible(
                                            flex: 3,
                                            child: ListView.builder(
                                                padding: EdgeInsets.zero,
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
                                                    child: Column(
                                                      children: [
                                                        IngredientCircleAvatar(
                                                          color: Colors.blue,
                                                          model: state![index],
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                              BlocSelector<
                                  MaterialSearch2Cubit,
                                  IMaterialSearch2State,
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
                                    return SizedBox(
                                      height: state == null
                                          ? 0
                                          : context.screenHeight / 6,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Flexible(
                                            flex: 1,
                                            child: LocaleText(
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal),
                                              text: LocaleKeys.fruits,
                                            ),
                                          ),
                                          Flexible(
                                            flex: 3,
                                            child: ListView.builder(
                                                padding: EdgeInsets.zero,
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
                                                    child: Column(
                                                      children: [
                                                        IngredientCircleAvatar(
                                                          color: Colors.blue,
                                                          model: state![index],
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                              //
                            ]),
                      ]),
                    )),
              ),
            ));
  }

  FittedBox _textRow(BuildContext context) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: context.textHighValue,
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
          Padding(
            padding: context.paddingLeftEdges,
            child: TextButton(
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
          ),
        ],
      ),
    );
  }
}
