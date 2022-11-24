import 'package:recipe_finder/feature/home_page/model/category_model.dart';
import 'package:recipe_finder/feature/home_page/model/essentials_model.dart';
import 'package:recipe_finder/feature/home_page/model/search_by_meal_model.dart';
import 'package:recipe_finder/feature/home_page/model/vegatables_model.dart';
import 'package:recipe_finder/feature/material_search_page/model/product_model.dart';

abstract class IHomeService {
  List<ProductModel> fetchSearchByMealList();
  List<ProductModel> fetchCategoryList();
  List<ProductModel> fetchVegatablesList();
  List<ProductModel> fetchEssetialsList();
}

class HomeService implements IHomeService {
  late final List<ProductModel> searchByMeallist =
      SearchByMealItems().searchByMeals;

  late final List<ProductModel> categorylist = CategoryItems().categorys;
  late final List<ProductModel> essentiallist = EssentialItems().essentialItems;

  late final List<ProductModel> vegatablelist =
      VegatablesItems().vegatableItems;

  List<ProductModel> fetchSearchByMealList() {
    return searchByMeallist;
  }

  List<ProductModel> fetchCategoryList() {
    return categorylist;
  }

  List<ProductModel> fetchEssetialsList() {
    return essentiallist;
  }

  List<ProductModel> fetchVegatablesList() {
    return vegatablelist;
  }
}
