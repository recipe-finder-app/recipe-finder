import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/product/utils/constant/image_path_enum.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/core/widget/alert_dialog/alert_dialog_error.dart';
import 'package:recipe_finder/feature/home_page/cubit/home_state.dart';
import '../../../product/model/ingredient_quantity/ingredient_quantity.dart';

import '../../../core/base/model/base_view_model.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../service/home_service.dart';

class HomeCubit extends Cubit<HomeState> implements IBaseViewModel {
  late final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  IHomeService? service;
  late TextEditingController searchTextController;
  HomeCubit() : super(const HomeState(isLoading: false));

  List<IngredientQuantity> searchByMeal = [];
  List<IngredientQuantity> category = [];
  List<IngredientQuantity> essentialsItem = [];
  List<IngredientQuantity> vegateblesItem = [];

  List<IngredientQuantity> myFrizeItems = [
    IngredientQuantity(nameEN: 'milk', imageUrl: ImagePathConstant.milk.path, quantity: 6),
    IngredientQuantity(nameEN: 'bread', imageUrl: ImagePathConstant.bread.path, quantity: 3),
    IngredientQuantity(nameEN: 'salad', imageUrl: ImagePathConstant.salad.path, quantity: 2),
    IngredientQuantity(nameEN: 'egg', imageUrl: ImagePathConstant.egg.path, quantity: 3),
    IngredientQuantity(nameEN: 'potato', imageUrl: ImagePathConstant.potato.path, quantity: 2),
    IngredientQuantity(nameEN: 'chicken', imageUrl: ImagePathConstant.chicken.path, quantity: 2),
  ];

  @override
  Future<void> init() async {
    service = HomeService();
    searchTextController = TextEditingController();
 

  }

  @override
  BuildContext? context;

  void searchByMealList() {
    searchByMeal = service!.fetchSearchByMealList();
    // emit(SearchByMealListLoaded(searchByMeal));
  }

  void changeIsLoadingState() {
    print("loading state ${state.isLoading}");
    emit(state.copyWith(isLoading: !state.isLoading!));
    print("loading state ${state.isLoading}");
  }

  Future<void> fetchCategoryList() async {
    try {
      changeIsLoadingState();
      final response = await service!.fetchCategoryList();
      if (response.data?.success == true) {
        emit(state.copyWith(categoryList: response.data?.recipeCategoryList));
        /*response.data?.recipeCategoryList?.forEach((element) {
          print(element.categoryName);
        });*/
      }
      return;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      showDialog(
          context: context!,
          builder: (context) {
            return AlertDialogError(text: LocaleKeys.anErrorOccured.locale);
          });
    } finally {
      changeIsLoadingState();
    }
  }

  void essentialHomeList() {
    essentialsItem = service!.fetchEssetialsList();
    // emit(EssentialListLoaded(essentialsItem));
  }

  void vegatableHomeList() {
    vegateblesItem = service!.fetchVegatablesList();
    //emit(VegatableListLoaded(vegateblesItem));
  }

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
