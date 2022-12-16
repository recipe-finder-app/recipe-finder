import 'package:recipe_finder/product/model/ingradient_model.dart';

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
  List<IngredientModel>? searchByMealList;
  SearchByMealListLoaded(this.searchByMealList);
}

class CategoryListLoaded extends IHomeState {
  List<IngredientModel>? categoryList;
  CategoryListLoaded(this.categoryList);
}

class EssentialListLoaded extends IHomeState {
  List<IngredientModel>? essentialsList;
  EssentialListLoaded(this.essentialsList);
}

class VegatableListLoaded extends IHomeState {
  List<IngredientModel>? vegatablesList;
  VegatableListLoaded(this.vegatablesList);
}
