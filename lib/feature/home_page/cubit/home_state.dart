import 'package:recipe_finder/feature/material_search_page/model/product_model.dart';

abstract class IHomeState {
  IHomeState();
}

class HomeInit extends IHomeState {
  HomeInit();
}

class OnHomeLoading extends IHomeState {
  late bool isLoading;
  OnHomeLoading(isLoading);
}

class HomeError extends IHomeState {
  String errorMessage;
  HomeError(this.errorMessage);
}

class SearchByMealListLoaded extends IHomeState {
  List<ProductModel>? searchByMealList;
  SearchByMealListLoaded(this.searchByMealList);
}

class CategoryListLoaded extends IHomeState {
  List<ProductModel>? categoryList;
  CategoryListLoaded(this.categoryList);
}

class EssentialListLoaded extends IHomeState {
  List<ProductModel>? essentialsList;
  EssentialListLoaded(this.essentialsList);
}

class VegatableListLoaded extends IHomeState {
  List<ProductModel>? vegatablesList;
  VegatableListLoaded(this.vegatablesList);
}
