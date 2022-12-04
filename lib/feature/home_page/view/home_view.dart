import 'package:flutter/material.dart';
import 'package:recipe_finder/core/base/view/base_view.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/constant/navigation/navigation_constants.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/feature/home_page/cubit/home_cubit.dart';
import 'package:recipe_finder/product/component/image_format/image_png.dart';
import 'package:recipe_finder/product/component/image_format/image_svg.dart';
import 'package:recipe_finder/product/component/modal_bottom_sheet/circular_modal_bottom_sheet.dart';
import 'package:recipe_finder/product/component/text/locale_text.dart';
import 'package:recipe_finder/product/widget/button/login_button.dart';
import 'package:recipe_finder/product/widget/search/search_widget.dart';
import '../../../core/init/navigation/navigation_service.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeCubit>(
      init: (cubitRead) {
        cubitRead.init();
        cubitRead.searchByMealList();
        cubitRead.categoryList();
        cubitRead.essentialHomeList();
        cubitRead.vegatableHomeList();
      },
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
                Center(
                    child: SearchWidget(
                  width: context.veryValueWidth,
                  onChanged: () {},
                )),
                context.mediumSizedBox,
                SizedBox(
                  height: context.screenHeight / 4.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: LocaleText(
                          style: TextStyle(
                              fontSize: 25,
                              color: ColorConstants.instance.black,
                              fontWeight: FontWeight.w400),
                          text: LocaleKeys.category,
                        ),
                      ),
                      context.lowSizedBox,
                      _categoryListView(context, cubitRead),
                    ],
                  ),
                ),
                SizedBox(
                  height: context.screenHeight / 2.5,
                  child: Column(
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
          itemBuilder: (context, index) {
            return Padding(
              padding: context.paddingLowRight,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: cubitRead.category[index].color,
                    child:
                        ImageSvg(path: cubitRead.category[index].image ?? ''),
                  ),
                  context.lowSizedBox,
                  LocaleText(
                    text: cubitRead.category[index].title ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ColorConstants.instance.roboticgods,
                    ),
                  ),
                ],
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
              text: LocaleKeys.homeTitle,
            ),
          ),
        ),
        Stack(children: [
          Padding(
            padding: context.paddingLeftEdges,
            child: SizedBox(
              height: context.highValue,
              child: InkWell(
                onTap: () {
                  NavigationService.instance
                      .navigateToPage(path: NavigationConstants.NAV_CONTROLLER);
                  fridgeBottomSheet(context, cubitRead);
                },
                child: ImageSvg(
                  path: ImagePath.fridge.path,
                ),
              ),
            ),
          ),
          Padding(
            padding: context.paddingMaxEdges,
            child: CircleAvatar(
              radius: 5,
              backgroundColor: ColorConstants.instance.red,
            ),
          )
        ]),
      ],
    );
  }

  Widget _searchByGridView(BuildContext context, HomeCubit cubitRead) {
    return SizedBox(
      height: context.screenHeight / 3,
      child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: cubitRead.searchByMeal.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.40,
              crossAxisSpacing: 25,
              mainAxisSpacing: 15),
          itemBuilder: (BuildContext context, index) {
            return _searchByMealCard(context, cubitRead, index);
          }),
    );
  }

  Container _searchByMealCard(
      BuildContext context, HomeCubit cubitRead, int index) {
    return Container(
      height: context.veryyHighValue,
      decoration: BoxDecoration(
        borderRadius: context.radiusAllCircularMin,
        color: cubitRead.searchByMeal[index].color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: context.paddingLowLeft,
            child: LocaleText(
              text: cubitRead.searchByMeal[index].title ?? '',
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(
              child: ImagePng(
            path: cubitRead.searchByMeal[index].image ?? '',
          ))
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
      scrollable: true,
      bottomSheetHeight: CircularBottomSheetHeight.medium,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LocaleText(
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal),
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
                itemBuilder: (context, index) {
                  return Padding(
                    padding: context.paddingLowRight,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundColor:
                              cubitRead.essentialsItem[index].color,
                          child: ImageSvg(
                              path:
                                  cubitRead.essentialsItem[index].image ?? ''),
                        ),
                        context.lowSizedBox,
                        LocaleText(
                          text: cubitRead.essentialsItem[index].title ?? '',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              color: ColorConstants.instance.roboticgods),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          context.normalSizedBox,
          const LocaleText(
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal),
            text: LocaleKeys.vegatables,
          ),
          context.normalSizedBox,
          GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemCount: cubitRead.vegateblesItem.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.70,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 10),
              itemBuilder: (BuildContext context, index) {
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: cubitRead.vegateblesItem[index].color,
                      child: ImageSvg(
                          path: cubitRead.vegateblesItem[index].image ?? ''),
                    ),
                    context.lowSizedBox,
                    Align(
                      alignment: Alignment.center,
                      child: LocaleText(
                        text: cubitRead.vegateblesItem[index].title ?? '',
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            color: ColorConstants.instance.roboticgods),
                      ),
                    ),
                  ],
                );
              }),
          context.normalSizedBox,
          LoginButton(
            text: LocaleKeys.addIngredients,
            color: ColorConstants.instance.russianViolet,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
