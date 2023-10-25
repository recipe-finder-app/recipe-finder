import 'package:recipe_finder/feature/home_page/model/category_model.dart';
import 'package:recipe_finder/feature/home_page/model/essentials_model.dart';
import 'package:recipe_finder/feature/home_page/model/search_by_meal_model.dart';
import 'package:recipe_finder/feature/home_page/model/vegatables_model.dart';
import '../../../product/model/ingredient_quantity/ingredient_quantity.dart';
import 'package:vexana/vexana.dart';

import '../../../product/utils/constant/service_path_constant.dart';
import '../../../core/init/network/vexana/vexana_manager.dart';
import '../../../product/model/recipe_category/category_of_recipes.dart';

abstract class IHomeService {
  List<IngredientQuantity> fetchSearchByMealList();
  Future<IResponseModel<CategoryOfRecipesListModel?, INetworkModel<dynamic>?>> fetchCategoryList();
  List<IngredientQuantity> fetchVegatablesList();
  List<IngredientQuantity> fetchEssetialsList();
}

class HomeService implements IHomeService {
  late final List<IngredientQuantity> searchByMeallist = SearchByMealItems().searchByMeals;

  late final List<IngredientQuantity> categorylist = CategoryItems().categories;
  late final List<IngredientQuantity> essentiallist = EssentialItems().essentialItems;

  late final List<IngredientQuantity> vegatablelist = VegatablesItems().vegatableItems;

  List<IngredientQuantity> fetchSearchByMealList() {
    return searchByMeallist;
  }

  @override
  Future<IResponseModel<CategoryOfRecipesListModel?, INetworkModel<dynamic>?>> fetchCategoryList() {
    final response = VexanaManager.instance.networkManager.send<CategoryOfRecipesListModel, CategoryOfRecipesListModel>(
      ServicePathConstant.recipeCategory,
      parseModel: CategoryOfRecipesListModel(),
      method: RequestType.GET,
    );
    return response;
  }

  List<IngredientQuantity> fetchEssetialsList() {
    return essentiallist;
  }

  List<IngredientQuantity> fetchVegatablesList() {
    return vegatablelist;
  }
}
