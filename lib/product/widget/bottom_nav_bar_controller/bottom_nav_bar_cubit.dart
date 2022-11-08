import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../feature/basket_page/view/basket_view.dart';
import '../../../feature/discover_page/view/discover_view.dart';
import '../../../feature/home_page/view/home_view.dart';
import '../../../feature/likes_page/view/likes_view.dart';

class RecipeNavigationBarCubit extends Cubit<int> {
  var pageList = [
    const HomeView(),
    const DiscoverView(),
    const LikesView(),
    const LikesView(),
    const BasketView(),
  ];
  int selectedPageIndex = 0;

  RecipeNavigationBarCubit() : super(0);

  void changePage(int index) {
    selectedPageIndex = index;
    emit(selectedPageIndex);
  }

  void clear() {
    selectedPageIndex = 0;
    emit(selectedPageIndex);
  }
}
