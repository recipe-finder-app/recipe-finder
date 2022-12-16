import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/feature/home_page/cubit/home_state.dart';
import 'package:recipe_finder/product/model/ingradient_model.dart';
import '../../../core/base/model/base_view_model.dart';
import '../service/home_service.dart';

class HomeCubit extends Cubit<IHomeState> implements IBaseViewModel {
  IHomeService? service;

  HomeCubit() : super(HomeInit());

  List<IngredientModel> searchByMeal = [];
  List<IngredientModel> category = [];
  List<IngredientModel> essentialsItem = [];
  List<IngredientModel> vegateblesItem = [];

  @override
  void init() {
    service = HomeService();
  }

  @override
  BuildContext? context;

  void searchByMealList() {
    searchByMeal = service!.fetchSearchByMealList();
    emit(SearchByMealListLoaded(searchByMeal));
  }

  void categoryList() {
    category = service!.fetchCategoryList();
    emit(CategoryListLoaded(category));
  }

  void essentialHomeList() {
    essentialsItem = service!.fetchEssetialsList();
    emit(EssentialListLoaded(essentialsItem));
  }

  void vegatableHomeList() {
    vegateblesItem = service!.fetchVegatablesList();
    emit(VegatableListLoaded(vegateblesItem));
  }

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
