import 'package:recipe_finder/feature/home_page/model/category_model.dart';
import 'package:recipe_finder/feature/home_page/model/essentials_model.dart';
import 'package:recipe_finder/feature/home_page/model/search_by_meal_model.dart';
import 'package:recipe_finder/feature/home_page/model/vegatables_model.dart';
import 'package:recipe_finder/product/model/ingredient/ingredient_model.dart';

abstract class IHomeService {
  List<IngredientModel> fetchSearchByMealList();
  List<IngredientModel> fetchCategoryList();
  List<IngredientModel> fetchVegatablesList();
  List<IngredientModel> fetchEssetialsList();
}

class HomeService implements IHomeService {
  late final List<IngredientModel> searchByMeallist = SearchByMealItems().searchByMeals;

  late final List<IngredientModel> categorylist = CategoryItems().categories;
  late final List<IngredientModel> essentiallist = EssentialItems().essentialItems;

  late final List<IngredientModel> vegatablelist = VegatablesItems().vegatableItems;

  List<IngredientModel> fetchSearchByMealList() {
    return searchByMeallist;
  }

  List<IngredientModel> fetchCategoryList() {
    return categorylist;
  }

  List<IngredientModel> fetchEssetialsList() {
    return essentiallist;
  }

  List<IngredientModel> fetchVegatablesList() {
    return vegatablelist;
  }
}
