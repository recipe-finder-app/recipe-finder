import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_finder/core/base/view/base_view.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/product/utils/constant/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/extension/int_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/feature/home_page/cubit/home_cubit.dart';
import 'package:recipe_finder/feature/home_page/cubit/home_state.dart';
import 'package:recipe_finder/product/model/user_model.dart';
import 'package:recipe_finder/product/widget/button/recipe_circular_button.dart';
import 'package:recipe_finder/product/widget/container/circular_bacground.dart';
import 'package:recipe_finder/product/widget/progress/recipe_progress.dart';

import '../../../product/utils/enum/hive_enum.dart';
import '../../../product/utils/constant/navigation_constant.dart';
import '../../../core/init/cache/hive_manager.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../../../core/widget/image_format/image_png.dart';
import '../../../core/widget/image_format/image_svg.dart';
import '../../../core/widget/modal_bottom_sheet/circular_modal_bottom_sheet.dart';
import '../../../core/widget/pop_up_menu_button/language_popup_menu_button.dart';
import '../../../core/widget/text/bold_text.dart';
import '../../../core/widget/text/locale_text.dart';
import '../../../product/widget/circle_avatar/amount_ingredient_circle_avatar.dart';
import '../../../product/widget/circle_avatar/category_circle_avatar.dart';
import '../../../product/widget/circle_avatar/ingredient_circle_avatar.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeCubit>(
      init: (cubitRead) async {
        cubitRead.setContext(context);
        await cubitRead.init();
        print("home çalıştı");
      },
      visibleProgress: false,
      onPageBuilder: (BuildContext context, cubitRead, cubitWatch) => Scaffold(
        key: cubitRead.scaffoldKey,
        drawer: buildDrawer(context),
        body: SafeArea(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return RecipeProgress(
                isLoading: state.isLoading,
                child: Padding(
                  padding: context.paddingNormalEdges,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(children: [
                      context.mediumSizedBox,
                      _textRow(context, cubitRead),
                      context.mediumSizedBox,
                      SizedBox(
                        height: context.screenHeightIsLessThan5Inch ? context.screenHeight / 4.5 : context.screenHeight / 5,
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
              );
            },
          ),
        ),
      ),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.transparent, border: Border.all(color: Colors.transparent)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SvgPicture.asset(
                      ImagePathConstant.appIcon.path,
                      height: 100,
                      width: 100,
                    ),
                  ),
                  BoldText(
                    text: 'Tarifi',
                    fontSize: 20,
                  ),
                  Text(
                    'Bul',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              horizontalTitleGap: 0,
              leading: ImageSvg(
                path: ImagePathConstant.user.path,
              ),
              title: LocaleText(text: LocaleKeys.myAccount),
              onTap: () {
                NavigationService.instance.navigateToPage(path: NavigationConstant.MYACCOUNT);
              },
            ),
            buildDrawerDivider(context),
            ListTile(
              horizontalTitleGap: 0,
              leading: ImageSvg(
                path: ImagePathConstant.discover.path,
                color: Colors.black,
              ),
              title: LanguagePopupMenuButton(
                child: LocaleText(text: LocaleKeys.language),
              ),
              onTap: () {},
            ),
            buildDrawerDivider(context),
            ListTile(
              horizontalTitleGap: 0,
              leading: Icon(
                Icons.star_border,
                color: Colors.black,
              ),
              title: LocaleText(text: LocaleKeys.rateUs),
              onTap: () {},
            ),
            buildDrawerDivider(context),
            ListTile(
              horizontalTitleGap: 0,
              leading: ImageSvg(
                path: ImagePathConstant.email.path,
                color: Colors.black,
              ),
              title: LocaleText(text: LocaleKeys.contact),
              onTap: () {},
            ),
            buildDrawerDivider(context),
            ListTile(
              horizontalTitleGap: 0,
              leading: ImageSvg(
                path: ImagePathConstant.persons.path,
                color: Colors.black,
              ),
              title: LocaleText(text: LocaleKeys.aboutUs),
              onTap: () {
                NavigationService.instance.navigateToPage(path: NavigationConstant.ABOUTUS);
              },
            ),
            buildDrawerDivider(context),
            ListTile(
              horizontalTitleGap: 0,
              leading: ImageSvg(
                path: ImagePathConstant.returnBack.path,
                color: Colors.black,
              ),
              title: LocaleText(text: LocaleKeys.logout),
              onTap: () async {
                final IHiveManager<User> hiveManager = HiveManager<User>(HiveBoxEnum.userModel);
                await hiveManager.clear();
                NavigationService.instance.navigateToPageClear(path: NavigationConstant.LOGIN);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDrawerDivider(BuildContext context) {
    return Container(
      width: context.screenWidth / 1.7,
      color: ColorConstants.instance.brightGraySolid,
      height: 1,
    );
  }

  Widget _categoryListView(BuildContext context, HomeCubit cubitRead) {
    return SizedBox(
      height: context.screenHeight / 7,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: state.categoryList?.length ?? 0,
              itemBuilder: (context, categoryIndex) {
                return Padding(
                  padding: EdgeInsets.only(right: context.normalValue),
                  child: CategoryCircleAvatar(
                    model: state.categoryList![categoryIndex],
                  ),
                );
              });
        },
      ),
    );
  }

  Widget _textRow(BuildContext context, HomeCubit cubitRead) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              cubitRead.scaffoldKey.currentState!.openDrawer();
            },
            child: CircularBackground(
              child: Icon(
                Icons.dehaze,
                color: Colors.white,
              ),
              color: ColorConstants.instance.oriolesOrange,
            ),
          ),
        ),
        Flexible(
          flex: 4,
          child: LocaleText(
            maxLines: null,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              color: ColorConstants.instance.blackbox,
            ),
            text: LocaleKeys.findBestRecipesForCooking,
          ),
        ),
        Flexible(
          child: Stack(alignment: AlignmentDirectional.topEnd, children: [
            SizedBox(
              height: context.highValue,
              child: InkWell(
                onTap: () {
                  fridgeBottomSheet(context, cubitRead);
                },
                child: ImageSvg(
                  path: ImagePathConstant.fridge.path,
                ),
              ),
            ),
            Padding(
              padding: context.screenHeightIsLessThan5Inch ? EdgeInsets.only(top: 5, right: 5) : EdgeInsets.only(top: 15, right: 6),
              child: CircleAvatar(
                radius: 5,
                backgroundColor: ColorConstants.instance.oriolesOrange,
              ),
            )
          ]),
        ),
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
        color: cubitRead.searchByMeal[index].color!.toColor,
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
                text: cubitRead.searchByMeal[index].nameEN! ?? '',
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
          child: RecipeCircularButton(
              color: ColorConstants.instance.russianViolet,
              text: const LocaleText(
                text: LocaleKeys.addIngredients,
              )),
        ),
      ]),
    );
  }
}
