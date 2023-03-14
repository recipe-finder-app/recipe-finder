import 'package:recipe_finder/product/model/ingredient_category/ingredient_category_model.dart';
import 'package:vexana/vexana.dart';

import '../../../core/constant/enum/service_path_enum.dart';
import '../../../core/init/network/vexana/vexana_manager.dart';

abstract class IMaterialSearchService {
  Future<IResponseModel<IngredientCategoryListModel?, INetworkModel<dynamic>?>> ingredientCategories();
}

class MaterialSearchService implements IMaterialSearchService {
  @override
  Future<IResponseModel<IngredientCategoryListModel?, INetworkModel?>> ingredientCategories() {
    final response = VexanaManager.instance.networkManager.send<IngredientCategoryListModel, IngredientCategoryListModel>(ServicePath.ingredientCategory.path, parseModel: IngredientCategoryListModel(), method: RequestType.GET);
    return response;
  }
}
