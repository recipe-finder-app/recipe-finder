import 'package:vexana/vexana.dart';

import '../../../core/constant/service/service_path.dart';
import '../../../core/init/network/vexana/vexana_manager.dart';
import '../../../product/model/ingredient_category/category_of_ingredient_model.dart';
import '../../../product/model/ingredient_category/ingredients_of_category_model.dart';

abstract class IMaterialSearchService {
  Future<IResponseModel<CategoryOfIngredientListModel?, INetworkModel<dynamic>?>> categoryOfIngredient();
  Future<IResponseModel<IngredientsOfCategoryModel?, INetworkModel<dynamic>?>> ingredientsOfCategory(String categoryId);
}

class MaterialSearchService implements IMaterialSearchService {
  @override
  Future<IResponseModel<CategoryOfIngredientListModel?, INetworkModel?>> categoryOfIngredient() {
    final response = VexanaManager.instance.networkManager.send<CategoryOfIngredientListModel, CategoryOfIngredientListModel>(ServicePath.categoryOfIngredient, parseModel: CategoryOfIngredientListModel(), method: RequestType.GET);
    return response;
  }

  Future<IResponseModel<IngredientsOfCategoryModel?, INetworkModel?>> ingredientsOfCategory(String categoryId) {
    final response = VexanaManager.instance.networkManager.send<IngredientsOfCategoryModel, IngredientsOfCategoryModel>(("${ServicePath.ingredientsOfCategory}/$categoryId"), parseModel: IngredientsOfCategoryModel(), method: RequestType.GET);
    return response;
  }
}
