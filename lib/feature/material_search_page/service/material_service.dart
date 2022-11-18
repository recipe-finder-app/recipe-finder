import 'package:recipe_finder/feature/material_search_page/model/material_essential_model.dart';
import 'package:recipe_finder/feature/material_search_page/model/material_vegatable_model.dart';

abstract class IMaterialSearchService {
  List<MaterialEssentialModel> fetchEssentialList();
  List<MaterialVegatablesModel> fetchVegatablesList();
}

class MaterialSearchService implements IMaterialSearchService {
  late final List<MaterialEssentialModel> essentialslist =
      MaterialEssentialItems().essentials;
  late final List<MaterialVegatablesModel> vegatableslist =
      MaterialVegatablesItems().vegatables;

  List<MaterialEssentialModel> fetchEssentialList() {
    return essentialslist;
  }

  List<MaterialVegatablesModel> fetchVegatablesList() {
    return vegatableslist;
  }
}
