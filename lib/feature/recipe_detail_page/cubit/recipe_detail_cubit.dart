import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base/model/base_view_model.dart';
import '../../../core/constant/enum/image_path_enum.dart';
import '../../../product/model/ingradient_model.dart';
import '../service/recipe_detail_service.dart';
import 'recipe_detail_state.dart';

class RecipeDetailCubit extends Cubit<IRecipeDetailState>
    implements IBaseViewModel {
  IRecipeDetailService? service;
  late List<IngredientModel> myFrizeItems;

  RecipeDetailCubit() : super(RecipeDetailInit());

  @override
  void init() {
    service = RecipeDetailService();
    myFrizeItems = [
      IngredientModel(
          title: 'milk', imagePath: ImagePath.milk.path, quantity: 6),
      IngredientModel(
          title: 'bread', imagePath: ImagePath.bread.path, quantity: 3),
      IngredientModel(
          title: 'salad', imagePath: ImagePath.salad.path, quantity: 2),
      IngredientModel(title: 'egg', imagePath: ImagePath.egg.path, quantity: 3),
      IngredientModel(
          title: 'potato', imagePath: ImagePath.potato.path, quantity: 2),
      IngredientModel(
          title: 'chicken', imagePath: ImagePath.chicken.path, quantity: 2),
    ];
  }

  @override
  BuildContext? context;

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
