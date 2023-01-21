import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/base/view/base_view.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/feature/home_page/cubit/home_cubit.dart';
import 'package:recipe_finder/product/widget/button/recipe_circular_button.dart';
import 'package:recipe_finder/product/widget_core/image_format/image_png.dart';
import 'package:recipe_finder/product/widget_core/image_format/image_svg.dart';
import 'package:recipe_finder/product/widget_core/modal_bottom_sheet/circular_modal_bottom_sheet.dart';
import 'package:recipe_finder/product/widget_core/text/locale_text.dart';

import '../../../core/constant/enum/device_size_enum.dart';
import '../../../product/widget/circle_avatar/amount_ingredient_circle_avatar.dart';
import '../../../product/widget/circle_avatar/ingredient_circle_avatar.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeCubit>(
      init: (cubitRead) {
        cubitRead.init();
      },
      visibleProgress: false,
      onPageBuilder: (BuildContext context, cubitRead, cubitWatch) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: context.paddingNormalEdges,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(children: [
                context.mediumSizedBox,
                _textRow(context, cubitRead),
                context.mediumSizedBox,
                // Center(
                //     child: SearchVoiceTextFormField(
                //   controller: cubitRead.searchTextController,
                //   onPressedClear: () {},
                //   onChanged: (String data) {
                //     if (data.isEmpty) {
                //     } else {}
                //   },
                // )),
                // context.mediumSizedBox,
                SizedBox(
                  height: context.screenHeight < DeviceSizeEnum.inch_5.size ? context.screenHeight / 4.5 : context.screenHeight / 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: LocaleText(
                          style: TextStyle(fontSize: 25, color: ColorConstants.instance.black, fontWeight: FontWeight.w400),
                          text: LocaleKeys.category,
                        ),
                      ),
                      context.lowSizedBox,
                      _categoryListView(context, cubitRead),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: LocaleText(
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          color: ColorConstants.instance.black,
                        ),
                        text: LocaleKeys.searchbymeal,
                      ),
                    ),
                    context.lowSizedBox,
                    _searchByGridView(context, cubitRead)
                  ],
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _categoryListView(BuildContext context, HomeCubit cubitRead) {
    return SizedBox(
      height: context.screenHeight / 7,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: cubitRead.category.length,
          itemBuilder: (context, categoryIndex) {
            return Padding(
              padding: EdgeInsets.only(right: context.normalValue),
              child: IngredientCircleAvatar(
                model: context.read<HomeCubit>().category[categoryIndex],
              ),
            );
          }),
    );
  }

  Widget _textRow(BuildContext context, HomeCubit cubitRead) {
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
              text: LocaleKeys.findBestRecipesForCooking,
            ),
          ),
        ),
        Stack(alignment: AlignmentDirectional.topEnd, children: [
          SizedBox(
            height: context.highValue,
            child: InkWell(
              onTap: () {
                fridgeBottomSheet(context, cubitRead);
              },
              child: ImageSvg(
                path: ImagePath.fridge.path,
              ),
            ),
          ),
          Padding(
            padding: context.isLessThan5Inch ? EdgeInsets.only(right: 5) : EdgeInsets.only(top: 8, right: 8),
            child: CircleAvatar(
              radius: 5,
              backgroundColor: ColorConstants.instance.oriolesOrange,
            ),
          )
        ]),
      ],
    );
  }

  Widget _searchByGridView(BuildContext context, HomeCubit cubitRead) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: cubitRead.searchByMeal.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2.40, crossAxisSpacing: 25, mainAxisSpacing: 15),
        itemBuilder: (BuildContext context, index) {
          return _searchByMealCard(context, cubitRead, index);
        });
  }

  Container _searchByMealCard(BuildContext context, HomeCubit cubitRead, int index) {
    return Container(
      height: context.veryyHighValue,
      decoration: BoxDecoration(
        borderRadius: context.radiusAllCircularMin,
        color: cubitRead.searchByMeal[index].color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 8,
            child: Padding(
              padding: context.paddingLowLeft,
              child: LocaleText(
                fontSize: 12,
                text: cubitRead.searchByMeal[index].title ?? '',
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: ImagePng(
              path: cubitRead.searchByMeal[index].imagePath ?? '',
            ),
          )
        ],
      ),
    );
  }

  Future<void> fridgeBottomSheet(
    BuildContext context,
    HomeCubit cubitRead,
  ) {
    return CircularBottomSheet.instance.show(
      context,
      scrollable: false,
      bottomSheetHeight: CircularBottomSheetHeight.medium,
      child: Stack(children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.normalSizedBox,
              const LocaleText(
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal),
                text: LocaleKeys.essentials,
              ),
              context.normalSizedBox,
              SizedBox(
                height: context.screenHeight / 7,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: cubitRead.essentialsItem.length,
                    itemBuilder: (context, essentialsIndex) {
                      return Padding(
                        padding: context.paddingLowRight,
                        child: IngredientCircleAvatar(
                          model: context.read<HomeCubit>().essentialsItem[essentialsIndex],
                        ),
                      );
                    }),
              ),
              const LocaleText(
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal),
                text: LocaleKeys.vegatables,
              ),
              context.normalSizedBox,
              GridView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount: cubitRead.vegateblesItem.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 0.70, crossAxisSpacing: 20, mainAxisSpacing: 10),
                  itemBuilder: (BuildContext context, vegateblesIndex) {
                    return AmountIngredientCircleAvatar(
                      model: context.read<HomeCubit>().vegateblesItem[vegateblesIndex],
                    );
                  }),
              context.veryHighSizedBox,
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          child: RecipeCircularButton(color: ColorConstants.instance.russianViolet, text: LocaleKeys.addIngredients),
        ),
      ]),
    );
  }
}
