import 'package:recipe_finder/feature/material_search_page/model/material_essential_model.dart';
import 'package:recipe_finder/feature/material_search_page/model/material_vegatable_model.dart';

import 'package:recipe_finder/product/model/ingradient_model.dart';

abstract class IMaterialSearchService {
  List<IngredientModel> fetchEssentialList();
  List<IngredientModel> fetchVegatablesList();
}

class MaterialSearchService implements IMaterialSearchService {
  late final List<IngredientModel> essentialslist =
      MaterialEssentialItems().essentials;
  late final List<IngredientModel> vegatableslist =
      MaterialVegatablesItems().vegatables;

  List<IngredientModel> fetchEssentialList() {
    return essentialslist;
  }

  List<IngredientModel> fetchVegatablesList() {
    return vegatableslist;
  }
}
