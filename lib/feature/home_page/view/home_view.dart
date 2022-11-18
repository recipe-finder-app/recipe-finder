import 'package:flutter/material.dart';
import 'package:recipe_finder/core/base/view/base_view.dart';

import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/constant/navigation/navigation_constants.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/feature/home_page/cubit/home_cubit.dart';
import 'package:recipe_finder/product/component/image_format/image_svg.dart';
import 'package:recipe_finder/product/widget/app_bar/text_app_bar.dart';
import 'package:recipe_finder/product/widget/button/login_button.dart';
import 'package:recipe_finder/product/component/modal_bottom_sheet/circular_modal_bottom_sheet.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/feature/home_page/model/category_model.dart';
import 'package:recipe_finder/feature/home_page/model/essentials_model.dart';
import 'package:recipe_finder/feature/home_page/model/search_model.dart';
import 'package:recipe_finder/feature/home_page/model/vegatables_model.dart';
import 'package:recipe_finder/product/component/text/locale_text.dart';
import 'package:recipe_finder/product/widget/search/search_widget.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../../../product/component/card/search_by_meal_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final List<SearchModel> searchItem = SearchItems().items;
    late final List<CategoryModel> catItem = CategoryItems().items;
    return BaseView<HomeCubit>(
      init: (cubitRead) {
        cubitRead.init();
      },
      onPageBuilder: (BuildContext context, cubitRead, cubitWatch) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: context.paddingNormalEdges,
            child: SingleChildScrollView(
              child: Column(children: [
                TextAppBar(
                    title: LocaleKeys.homeTitle,
                    onPressed: () {
                      NavigationService.instance.navigateToPage(
                          path: NavigationConstants.NAV_CONTROLLER);
                      refrigeratorBottomSheet(context);
                    },
                    widget: ImageSvg(
                      path: ImagePath.fridge.path,
                    ),
                    color: ColorConstants.instance.red),
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
                      _categoryListView(context, catItem),
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
                      _searchByGridView(context, searchItem)
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

  Widget _searchByGridView(BuildContext context, List<SearchModel> searchItem) {
    return SizedBox(
      height: context.screenHeight / 3,
      child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: searchItem.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2,
              crossAxisSpacing: 25,
              mainAxisSpacing: 15),
          itemBuilder: (BuildContext context, index) {
            return SearchByMealCard(
              model: searchItem[index],
            );
          }),
    );
  }

  Widget _categoryListView(BuildContext context, List<CategoryModel> catItem) {
    return SizedBox(
      height: context.screenHeight / 8.2,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: catItem.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: context.paddingLowRight,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: catItem[index].color,
                    child: catItem[index].imagePath,
                  ),
                  context.lowSizedBox,
                  LocaleText(
                    text: catItem[index].title,
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

  Future<void> refrigeratorBottomSheet(
    BuildContext context,
  ) {
    late final List<EssentialModel> essentialItem = EssentialItems().items;
    late final List<VegatablesModel> vegatableItem = VegatablesItems().items;

    return CircularBottomSheet.instance.show(
      context,
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
          Flexible(
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: essentialItem.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: context.paddingLowRight,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundColor: essentialItem[index].color,
                          child: essentialItem[index].imagePath,
                        ),
                        context.lowSizedBox,
                        LocaleText(
                          text: essentialItem[index].title,
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
          Flexible(
            flex: 2,
            child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: vegatableItem.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.70,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 10),
                itemBuilder: (BuildContext context, index) {
                  return Column(
                    //  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: vegatableItem[index].color,
                        child: vegatableItem[index].imagePath,
                      ),
                      context.lowSizedBox,
                      Align(
                        alignment: Alignment.center,
                        child: LocaleText(
                          text: vegatableItem[index].title,
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              color: ColorConstants.instance.roboticgods),
                        ),
                      ),
                    ],
                  );
                }),
          ),
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
