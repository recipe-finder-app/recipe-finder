import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/feature/home_page/cubit/home_state.dart';
import 'package:recipe_finder/feature/home_page/model/category_model.dart';
import 'package:recipe_finder/feature/home_page/model/search_by_meal_model.dart';
import 'package:recipe_finder/feature/material_search_page/model/product_model.dart';

import '../../../core/base/model/base_view_model.dart';

import '../service/home_service.dart';

class HomeCubit extends Cubit<IHomeState> implements IBaseViewModel {
  late GlobalKey<FormState> loginFormKey;
  late GlobalKey<FormState> createAccountFormKey;
  late GlobalKey<FormState> forgotPasswordFormKey;
  IHomeService? service;

  HomeCubit() : super(HomeInit());

  List<ProductModel> searchByMeal = [];
  List<ProductModel> category = [];
  List<ProductModel> essentialsItem = [];
  List<ProductModel> vegateblesItem = [];

  @override
  void init() {
    loginFormKey = GlobalKey<FormState>();
    createAccountFormKey = GlobalKey<FormState>();
    forgotPasswordFormKey = GlobalKey<FormState>();

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

  void login() {
    if (loginFormKey.currentState!.validate()) {}
  }

  void createAccount() {
    if (createAccountFormKey.currentState!.validate()) {}
  }

  void forgotPassword() {
    if (forgotPasswordFormKey.currentState!.validate()) {}
  }
}
