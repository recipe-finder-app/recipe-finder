import 'package:flutter_bloc/flutter_bloc.dart';

import '../basket/view/basket_view.dart';
import '../discover/view/discover_view.dart';
import '../home/view/home_view.dart';
import '../likes/view/basket_view.dart';

class RecipeNavigationBarCubit extends Cubit<int> {
  var pageList = [
    HomeView(),
    DiscoverView(),
    LikesView(),
    LikesView(),
    BasketView(),
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
