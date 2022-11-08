import 'package:flutter/material.dart';
import 'package:recipe_finder/product/component/image_format/image_svg.dart';
import 'package:recipe_finder/core/constant/design/color_constant.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';

typedef IntParameterFunction = void Function(int data);

class RecipeBottomNavigationBar extends StatelessWidget {
  final IntParameterFunction onTab;
  final int currentIndex;
  const RecipeBottomNavigationBar(
      {Key? key, required this.onTab, required this.currentIndex})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      clipBehavior: Clip.none,
      fit: StackFit.loose,
      children: [
        BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedIconTheme: const IconThemeData(color: Colors.black),
          unselectedIconTheme: const IconThemeData(color: Colors.grey),
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          iconSize: 24,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(
            fontSize: 13,
          ),
          // selectedFontSize: 10,
          onTap: (index) {
            onTab(index);
          },
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
                label: 'Home',
                icon: ImageSvg(
                  path: ImagePath.home.path,
                  height: 24,
                )),
            BottomNavigationBarItem(
                label: 'Discover',
                icon: ImageSvg(
                  path: ImagePath.discover.path,
                  height: 24,
                )),
            const BottomNavigationBarItem(
                label: 'Finder',
                icon: SizedBox(
                  height: 24,
                  child: Icon(
                    Icons.home,
                    size: 0,
                  ),
                )),
            BottomNavigationBarItem(
                label: 'Likes',
                icon: ImageSvg(
                  path: ImagePath.like.path,
                  height: 24,
                )),
            BottomNavigationBarItem(
                label: 'Basket',
                icon: ImageSvg(
                  path: ImagePath.basket.path,
                  height: 24,
                )),
          ],
        ),
        Positioned(
          top: -30,
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorConstants.instance.oriolesOrange,
            ),
            child: ImageSvg(
              path: ImagePath.search.path,
              height: 24,
            ),
          ),
        ),
      ],
    );
  }
}
