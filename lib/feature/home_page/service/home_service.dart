import 'package:recipe_finder/feature/home_page/model/category_model.dart';
import 'package:recipe_finder/feature/home_page/model/essentials_model.dart';
import 'package:recipe_finder/feature/home_page/model/search_by_meal_model.dart';
import 'package:recipe_finder/feature/home_page/model/vegatables_model.dart';
import 'package:recipe_finder/product/model/ingredient/ingredient_model.dart';
import 'package:vexana/vexana.dart';

import '../../../core/constant/service/service_path.dart';
import '../../../core/init/network/vexana/vexana_manager.dart';
import '../../../product/model/recipe_category/category_of_recipes.dart';

abstract class IHomeService {
  List<IngredientModel> fetchSearchByMealList();
  Future<IResponseModel<CategoryOfRecipesListModel?, INetworkModel<dynamic>?>> fetchCategoryList();
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

  @override
  Future<IResponseModel<CategoryOfRecipesListModel?, INetworkModel<dynamic>?>> fetchCategoryList() {
    final response = VexanaManager.instance.networkManager.send<CategoryOfRecipesListModel, CategoryOfRecipesListModel>(
      ServicePath.recipeCategory,
      parseModel: CategoryOfRecipesListModel(),
      method: RequestType.GET,
    );
    return response;
  }

  List<IngredientModel> fetchEssetialsList() {
    return essentiallist;
  }

  List<IngredientModel> fetchVegatablesList() {
    return vegatablelist;
  }
}
