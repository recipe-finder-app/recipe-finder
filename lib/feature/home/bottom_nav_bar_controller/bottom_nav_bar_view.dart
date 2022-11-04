import 'package:flutter/material.dart';
import 'package:recipe_finder/core/component/widget/bottom_navigation_bar/recipe_bottom_navigation_bar.dart';

import '../../../core/base/view/base_view.dart';
import 'bottom_nav_bar_cubit.dart';

class RecipeNavigationBarController extends StatelessWidget {
  const RecipeNavigationBarController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<RecipeNavigationBarCubit>(
      init: (cubitRead) {
        cubitRead.clear();
      },
      onPageBuilder: (BuildContext context, cubitRead, cubitWatch) => Scaffold(
        bottomNavigationBar: RecipeBottomNavigationBar(
          currentIndex: cubitRead.selectedPageIndex,
          onTab: (int pageIndex) {
            cubitRead.changePage(pageIndex);
          },
        ),
        body: cubitRead.pageList[cubitRead.selectedPageIndex],
      ),
    );
  }
}
