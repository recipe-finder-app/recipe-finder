import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/constant/enum/device_size_enum.dart';
import 'package:recipe_finder/core/init/navigation/navigation_service.dart';
import 'package:recipe_finder/core/widget/text/locale_text.dart';
import 'package:recipe_finder/product/utils/constant/image_path_enum.dart';
import 'package:recipe_finder/core/extension/context_extension.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/product/utils/constant/navigation_constant.dart';

import '../../../core/widget/image_format/image_svg.dart';
import 'bottom_nav_bar_cubit.dart';

typedef IntParameterFunction = void Function(int data);

class RecipeBottomNavigationBar extends StatelessWidget {
  const RecipeBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _RecipeWhiteAppBar(),
      bottomNavigationBar: Stack(
        alignment: AlignmentDirectional.topCenter,
        clipBehavior: Clip.none,
        fit: StackFit.loose,
        children: [
          SizedBox(
            height: context.screenHeight < DeviceSizeEnum.inch_5.size ? 60 : 95,
            child: BlocBuilder<RecipeNavigationBarCubit, int>(
              builder: (context, state) {
                return BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  selectedIconTheme: IconThemeData(color: ColorConstants.instance.russianViolet),
                  unselectedIconTheme: IconThemeData(
                    color: ColorConstants.instance.roboticgods,
                  ),
                  selectedItemColor: ColorConstants.instance.russianViolet,
                  unselectedItemColor: ColorConstants.instance.roboticgods,
                  backgroundColor: ColorConstants.instance.white,
                  iconSize: 24,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  selectedLabelStyle: const TextStyle(
                    fontSize: 13,
                  ),
                  onTap: (index) {
                    context.read<RecipeNavigationBarCubit>().changeCurrentIndex(index);
                  },
                  currentIndex: context.read<RecipeNavigationBarCubit>().selectedPageIndex,
                  items: [
                    BottomNavigationBarItem(
                        label: LocaleKeys.home.locale,
                        icon: ImageSvg(
                          path: state == 0 ? ImagePathConstant.homeBlack.path : ImagePathConstant.home.path,
                          color: context.read<RecipeNavigationBarCubit>().itemColor(0),
                          height: 24,
                        )),
                    BottomNavigationBarItem(
                        label: LocaleKeys.discover.locale,
                        icon: ImageSvg(
                          path: state == 1 ? ImagePathConstant.discoverBlack.path : ImagePathConstant.discover.path,
                          color: context.read<RecipeNavigationBarCubit>().itemColor(1),
                          height: 24,
                        )),
                    BottomNavigationBarItem(
                        label: LocaleKeys.finder.locale,
                        icon: const SizedBox(
                          height: 24,
                          child: Icon(
                            Icons.home,
                            size: 0,
                            color: Colors.transparent,
                          ),
                        )),
                    BottomNavigationBarItem(
                        label: LocaleKeys.likes.locale,
                        icon: ImageSvg(
                          path: state == 3 ? ImagePathConstant.likeBlack.path : ImagePathConstant.like.path,
                          color: context.read<RecipeNavigationBarCubit>().itemColor(3),
                          height: 24,
                        )),
                    BottomNavigationBarItem(
                        label: LocaleKeys.basket.locale,
                        icon: ImageSvg(
                          path: state == 4 ? ImagePathConstant.shoppingBagBlack.path : ImagePathConstant.shoppingBag.path,
                          color: context.read<RecipeNavigationBarCubit>().itemColor(4),
                          height: 24,
                        )),
                  ],
                );
              },
            ),
          ),
          Positioned(
            top: -18,
            child: InkWell(
              onTap: () {
                context.read<RecipeNavigationBarCubit>().clickFinderButton();
              },
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  BlocBuilder<RecipeNavigationBarCubit, int>(
                    builder: (context, state) {
                      return Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: state == 2 ? ColorConstants.instance.russianViolet : ColorConstants.instance.oriolesOrange,
                        ),
                      );
                    },
                  ),
                  SvgPicture.asset(
                    ImagePathConstant.appIconLowSize.path,
                    color: Colors.white,
                    height: 55,
                    fit: BoxFit.fitHeight,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: ()=> context.read<RecipeNavigationBarCubit>().clearCache(),
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: context.read<RecipeNavigationBarCubit>().pageController,
          children: context.read<RecipeNavigationBarCubit>().pageList,
        ),
      ),
    );
  }
}

class _RecipeWhiteAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _RecipeWhiteAppBar();

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: context.normalValue),
          child: InkWell(
            borderRadius: context.radiusAllCircularMin,
            onTap: () {
              context.read<RecipeNavigationBarCubit>().clearCache();
              NavigationService.instance.navigateToPageClear(path: NavigationConstant.LOGIN);              
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.doorOpen,color: ColorConstants.instance.oriolesOrange,),
                const LocaleText(text: LocaleKeys.logout,fontSize: 8,maxLines: 2,),
              ],
            ),
          ),
        ),
        actions: [         
          Padding(
            padding: EdgeInsets.only(right: context.normalValue),
            child: InkWell(
              borderRadius: context.radiusAllCircularMin,         
              onTap: (){
                 NavigationService.instance.navigateToPage(path: NavigationConstant.ONBOARD);

              },
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.help_outline,color: ColorConstants.instance.oriolesOrange,size: 35,),
                   
                   // const LocaleText(text: LocaleKeys.logout,fontSize: 8,maxLines: 2,),
                  ],
                ),
            ),
          ),
        ],
      ),
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(40);
}
/*
class RecipeBottomNavigationBar extends StatelessWidget {
  const RecipeBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<RecipeNavigationBarCubit>(
      init: (cubitRead) {
        cubitRead.clear();
      },
      onPageBuilder: (BuildContext context, cubitRead, cubitWatch) => Scaffold(
        bottomNavigationBar: Stack(
          alignment: AlignmentDirectional.topCenter,
          clipBehavior: Clip.none,
          fit: StackFit.loose,
          children: [
            SizedBox(
              height: context.screenHeight < DeviceSizeEnum.inch_5.size ? 60 : 95,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedIconTheme: IconThemeData(color: ColorConstants.instance.russianViolet),
                unselectedIconTheme: IconThemeData(
                  color: ColorConstants.instance.roboticgods,
                ),
                selectedItemColor: ColorConstants.instance.russianViolet,
                unselectedItemColor: ColorConstants.instance.roboticgods,
                backgroundColor: ColorConstants.instance.white,
                iconSize: 24,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedLabelStyle: const TextStyle(
                  fontSize: 13,
                ),
                onTap: (index) {
                  cubitRead.changeCurrentIndex(index);
                },
                currentIndex: cubitRead.selectedPageIndex,
                items: [
                  BottomNavigationBarItem(
                      label: LocaleKeys.home.locale,
                      icon: ImageSvg(
                        path: cubitRead.selectedPageIndex == 0 ? ImagePath.homeBlack.path : ImagePath.home.path,
                        color: cubitRead.itemColor(0),
                        height: 24,
                      )),
                  BottomNavigationBarItem(
                      label: LocaleKeys.discover.locale,
                      icon: ImageSvg(
                        path: cubitRead.selectedPageIndex == 1 ? ImagePath.discoverBlack.path : ImagePath.discover.path,
                        color: cubitRead.itemColor(1),
                        height: 24,
                      )),
                  BottomNavigationBarItem(
                      label: LocaleKeys.finder.locale,
                      icon: const SizedBox(
                        height: 24,
                        child: Icon(
                          Icons.home,
                          size: 0,
                          color: Colors.transparent,
                        ),
                      )),
                  BottomNavigationBarItem(
                      label: LocaleKeys.likes.locale,
                      icon: ImageSvg(
                        path: cubitRead.selectedPageIndex == 3 ? ImagePath.likeBlack.path : ImagePath.like.path,
                        color: cubitRead.itemColor(3),
                        height: 24,
                      )),
                  BottomNavigationBarItem(
                      label: LocaleKeys.basket.locale,
                      icon: ImageSvg(
                        path: cubitRead.selectedPageIndex == 4 ? ImagePath.shoppingBagBlack.path : ImagePath.shoppingBag.path,
                        color: cubitRead.itemColor(4),
                        height: 24,
                      )),
                ],
              ),
            ),
            Positioned(
              top: -18,
              child: InkWell(
                onTap: () {
                  cubitRead.clickFinderButton();
                },
                child: Tooltip(
                  message: LocaleKeys.finder.locale,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: cubitRead.selectedPageIndex == 2 ? ColorConstants.instance.russianViolet : ColorConstants.instance.oriolesOrange,
                        ),
                      ),
                      SvgPicture.asset(
                        ImagePath.appIconLowSize.path,
                        color: Colors.white,
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: cubitRead.pageController,
          children: cubitRead.pageList,
        ),
      ),
    );
  }
}
*/
//EdgeInsets bottomNavBarLabelPadding() => EdgeInsets.only(bottom: 8);
