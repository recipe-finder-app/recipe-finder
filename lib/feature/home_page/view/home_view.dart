import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/core/constant/navigation/navigation_constants.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/feature/home_page/model/category_model.dart';
import 'package:recipe_finder/feature/home_page/model/essentials_model.dart';
import 'package:recipe_finder/feature/home_page/model/search_model.dart';
import 'package:recipe_finder/feature/home_page/model/vegatables_model.dart';
import 'package:recipe_finder/product/component/image_format/image_png.dart';
import 'package:recipe_finder/product/component/modal_bottom_sheet/circular_modal_bottom_sheet.dart';
import 'package:recipe_finder/product/component/text/locale_text.dart';
import 'package:recipe_finder/product/widget/button/login_button.dart';
import 'package:recipe_finder/product/widget/search/search_widget.dart';

import '../../../core/init/navigation/navigation_service.dart';
import '../../../product/component/card/search_by_meal_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final List<SearchModel> searchItem = SearchItems().items;
    late final List<CategoryModel> catItem = CategoryItems().items;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: context.paddingNormalEdges,
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _appBarRow(context),
              SizedBox(
                height: context.mediumValue,
              ),
              const Center(child: SearchWidget()),
              SizedBox(
                height: context.mediumValue,
              ),
              SizedBox(
                height: context.screenHeight / 4.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LocaleText(
                      style: TextStyle(fontSize: 25),
                      text: LocaleKeys.category,
                    ),
                    SizedBox(
                      height: context.lowValue,
                    ),
                    _categoryListView(context, catItem),
                  ],
                ),
              ),
              SizedBox(
                height: context.screenHeight / 2.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LocaleText(
                      style: TextStyle(fontSize: 25),
                      text: LocaleKeys.searchbymeal,
                    ),
                    SizedBox(
                      height: context.lowValue,
                    ),
                    _searchByGridView(context, searchItem)
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Row _appBarRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LocaleText(
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.headline5?.copyWith(
                fontWeight: FontWeight.bold,
              ),
          text: LocaleKeys.homeTitle,
        ),
        Stack(children: [
          SizedBox(
              height: context.highValue,
              child: InkWell(
                  onTap: () {
                    NavigationService.instance.navigateToPage(
                        path: NavigationConstants.NAV_CONTROLLER);
                    refrigeratorBottomSheet(context);
                  },
                  child: ImagePng(
                    path: ImagePath.refrigerator.path,
                  ))),
          Padding(
            padding: context.paddingHighEdges,
            child: const CircleAvatar(
              radius: 6,
              backgroundColor: Colors.red,
            ),
          )
        ]),
      ],
    );
  }

  Widget _searchByGridView(BuildContext context, List<SearchModel> searchItem) {
    return SizedBox(
      height: context.screenHeight / 3,
      child: GridView.builder(
          itemCount: searchItem.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.95,
          ),
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: context.paddingLowAll,
              child: SearchByMealCard(
                model: searchItem[index],
              ),
            );
          }),
    );
  }

  Widget _categoryListView(BuildContext context, List<CategoryModel> catItem) {
    return SizedBox(
      height: context.screenHeight / 8.2,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: catItem.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: context.paddingLowEdges,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: catItem[index].color,
                    child: catItem[index].imagePath,
                  ),
                  SizedBox(
                    height: context.lowValue,
                  ),
                  LocaleText(
                    text: catItem[index].title,
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const LocaleText(
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                text: LocaleKeys.essentials,
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.chevron_right,
                    size: 30,
                  )),
            ],
          ),
          SizedBox(
            height: context.lowValue,
          ),
          Flexible(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: essentialItem.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: context.paddingLowEdges,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundColor: essentialItem[index].color,
                          child: essentialItem[index].imagePath,
                        ),
                        SizedBox(
                          height: context.lowValue,
                        ),
                        LocaleText(
                          text: essentialItem[index].title,
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const LocaleText(
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                text: LocaleKeys.vegatables,
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.chevron_right,
                    size: 30,
                  )),
            ],
          ),
          SizedBox(
            height: context.lowValue,
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: vegatableItem.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.70,
                ),
                itemBuilder: (BuildContext context, index) {
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: vegatableItem[index].color,
                        child: vegatableItem[index].imagePath,
                      ),
                      SizedBox(
                        height: context.lowValue,
                      ),
                      LocaleText(
                        text: vegatableItem[index].title,
                      ),
                    ],
                  );
                }),
          ),
          SizedBox(
            height: context.lowValue,
          ),
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
