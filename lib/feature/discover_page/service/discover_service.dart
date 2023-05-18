import 'package:recipe_finder/product/model/recipe/recipe_model.dart';
import 'package:recipe_finder/product/model/token/token_model.dart';
import 'package:vexana/vexana.dart';

import '../../../core/constant/enum/hive_enum.dart';
import '../../../core/constant/service/service_path.dart';
import '../../../core/init/cache/hive_manager.dart';
import '../../../core/init/network/vexana/vexana_manager.dart';
import '../../../product/model/recipe_category/category_of_recipes.dart';
import '../../../product/model/user_model.dart';

abstract class IDiscoverService {
  Future<IResponseModel<CategoryOfRecipesListModel?, INetworkModel<dynamic>?>> fetchCategoryList();
  Future<IResponseModel<RecipeListModel?, INetworkModel<dynamic>?>> fetchAllRecipeList(int page, int limit);
}

class DiscoverService implements IDiscoverService {
  @override
  Future<IResponseModel<CategoryOfRecipesListModel?, INetworkModel<dynamic>?>> fetchCategoryList() {
    final response = VexanaManager.instance.networkManager.send<CategoryOfRecipesListModel, CategoryOfRecipesListModel>(
      ServicePath.recipeCategory,
      parseModel: CategoryOfRecipesListModel(),
      method: RequestType.GET,
    );
    return response;
  }

  @override
  Future<IResponseModel<RecipeListModel?, INetworkModel?>> fetchAllRecipeList(int page, int limit) async {
    final IHiveManager<User> hiveManager = HiveManager<User>(HiveBoxEnum.userModel);
    final user = await hiveManager.get(HiveKeyEnum.user);
    final response = VexanaManager.instance.networkManager.send<RecipeListModel, RecipeListModel>(
      ServicePath.getAllRecipes(page, limit),
      parseModel: RecipeListModel(),
      method: RequestType.GET,
      options: Options(headers: TokenModel(token: user?.token).toJson()),
    );
    return response;
  }
}
