import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/feature/home_page/model/category_model.dart';
import 'package:recipe_finder/feature/home_page/model/essentials_model.dart';
import 'package:recipe_finder/feature/home_page/model/search_model.dart';
import 'package:recipe_finder/feature/home_page/model/vegatables_model.dart';
import 'package:recipe_finder/product/component/modal_bottom_sheet/circular_modal_bottom_sheet.dart';
import 'package:recipe_finder/product/component/text/locale_text.dart';
import 'package:recipe_finder/product/widget/button/login_button.dart';
import 'package:recipe_finder/product/widget/search/search_widget.dart';

import '../../../product/component/card/search_by_meal_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final List<SearchModel> searchItem = SearchItems().items;
    late final List<CategoryModel> catItem = CategoryItems().items;
    return Scaffold(
      /**
      *  bottomNavigationBar: const BottomNavbar(
        pageid: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const MyFAB(),
      */
      body: SafeArea(
        child: Padding(
          padding: context.paddingNormalEdges,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _appBarRow(context),
            SizedBox(
              height: context.mediumValue,
            ),
            const SearchWidget(),
            SizedBox(
              height: context.mediumValue,
            ),
            const LocaleText(
              style: TextStyle(fontSize: 25),
              text: LocaleKeys.category,
            ),
            SizedBox(
              height: context.mediumValue,
            ),
            _categoryListView(catItem),
            const LocaleText(
              style: TextStyle(fontSize: 25),
              text: LocaleKeys.searchbymeal,
            ),
            SizedBox(
              height: context.mediumValue,
            ),
            _searchByGridView(searchItem)
          ]),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeView()),
                    );
                    refrigeratorBottomSheet(context);
                  },
                  child: Image.asset('asset/png/refrigerator.png'))),
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

  Expanded _searchByGridView(List<SearchModel> searchItem) {
    return Expanded(
      flex: 2,
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

  Flexible _categoryListView(List<CategoryModel> catItem) {
    return Flexible(
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
      bottomSheetHeight: CircularBottomSheetHeight.middle,
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
