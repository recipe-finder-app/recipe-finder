import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/base/model/base_view_model.dart';
import 'package:recipe_finder/core/constant/enum/image_path_enum.dart';
import 'package:recipe_finder/feature/basket_page/cubit/basket_state.dart';
import 'package:recipe_finder/feature/basket_page/service/basket_service.dart';
import 'package:recipe_finder/feature/likes_page/model/like_recipe_model.dart';
import 'package:recipe_finder/product/model/ingradient_model.dart';
import 'package:recipe_finder/product/model/recipe_model.dart';

class BasketCubit extends Cubit<IBasketState> implements IBaseViewModel {
  IBasketService? service;
  RecipeModel? selectCardModel;

  late List<RecipeModel> basketRecipeItems = [
    RecipeModel(
      imagePath: 'asset/png/foot2.png',
      title: 'Deneme Text 1',
      ingredients: [
        IngredientModel(
            title: 'egg', imagePath: ImagePath.egg.path, quantity: 5),
        IngredientModel(
            title: 'milk', imagePath: ImagePath.milk.path, quantity: 6),
        IngredientModel(
            title: 'bread', imagePath: ImagePath.bread.path, quantity: 3),
        IngredientModel(
            title: 'salad', imagePath: ImagePath.salad.path, quantity: 2),
        IngredientModel(
            title: 'chicken', imagePath: ImagePath.chicken.path, quantity: 4),
      ],
    ),
    RecipeModel(
      imagePath: 'asset/png/foot1.png',
      title: 'Deneme Text 2',
      ingredients: [
        IngredientModel(title: 'Egg', quantity: 4),
        IngredientModel(title: 'Butter', quantity: 1 / 2),
        IngredientModel(title: 'Butter', quantity: 1 / 2),
        IngredientModel(title: 'Egg', quantity: 4),
        IngredientModel(title: 'Butter', quantity: 1 / 2),
        IngredientModel(title: 'Butter', quantity: 1 / 2),
      ],
    ),
    RecipeModel(
      imagePath: 'asset/png/foot2.png',
      title: 'Deneme Text 3',
      ingredients: [
        IngredientModel(
            title: 'Egg', imagePath: ImagePath.egg.path, quantity: 4),
        IngredientModel(title: 'Butter', quantity: 1 / 2),
        IngredientModel(title: 'Butter', quantity: 1 / 2),
      ],
    ),
  ];

  BasketCubit() : super(BasketsInit());
  late List<IngredientModel> myFinderFrizeItems;

  @override
  void init() {
    service = BasketService();
    myFinderFrizeItems = [
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

  void deleteItemFromBasketRecipeList(RecipeModel model) {
    basketRecipeItems.remove(model);
    emit(BasketRecipeItemListLoad(basketRecipeItems.toSet().toList()));
  }

  void changeSelectedCardModel(RecipeModel model) {
     selectCardModel = model;
      emit(ChangeSelectedCardModel(selectCardModel!));
  }

  @override
  void dispose() {}
  @override
  BuildContext? context;

  @override
  void setContext(BuildContext context) => this.context = context;
}
