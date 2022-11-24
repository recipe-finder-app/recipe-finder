import 'package:recipe_finder/feature/material_search_page/model/material_essential_model.dart';
import 'package:recipe_finder/feature/material_search_page/model/material_vegatable_model.dart';
import 'package:recipe_finder/feature/material_search_page/model/product_model.dart';
import 'package:recipe_finder/product/model/ingradient_model.dart';

abstract class IMaterialSearchService {
  List<ProductModel> fetchEssentialList();
  List<ProductModel> fetchVegatablesList();
}

class MaterialSearchService implements IMaterialSearchService {
  late final List<ProductModel> essentialslist =
      MaterialEssentialItems().essentials;
  late final List<ProductModel> vegatableslist =
      MaterialVegatablesItems().vegatables;

  List<ProductModel> fetchEssentialList() {
    return essentialslist;
  }

  List<ProductModel> fetchVegatablesList() {
    return vegatableslist;
  }
}
