import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base/model/base_view_model.dart';
import '../../../core/constant/enum/image_path_enum.dart';
import '../../../product/model/ingradient_model.dart';
import '../../../product/model/recipe_model.dart';
import '../model/like_recipe_model.dart';
import '../service/likes_service.dart';
import 'likes_state.dart';

class LikesCubit extends Cubit<ILikesState> implements IBaseViewModel {
  ILikesService? service;

  late List<LikeRecipeModel> likeRecipeItems;
  late List<IngredientModel> myFrizeItems;
  bool missingItemListTargetState = false;
  bool myFrizeListTargetState = false;

  String directionText =
      """Whisk egg, ketchup, Worcestershire sauce, salt, brown sugar, onion powder, garlic powder, thyme, and cayenne pepper together in a bowl. Add breadcrumbs and chopped cooked bacon. Crumble in the ground beef. Mix with your fingers until bacon and breadcrumbs are distributed evenly.
  Form mixture into 4 burgers with your wet hands. Cover with plastic wrap and refrigerate until chilled thoroughly, about 3 hours.
  Preheat an outdoor grill for medium-high heat and lightly oil the grate.
  Place burgers on the grate and cook, turing occasionally, until firm and cooked to your desired doneness. """;

  LikesCubit() : super(LikesInit());
  @override
  void init() {
    service = LikesService();

    likeRecipeItems = [
      LikeRecipeModel(
        imagePath: ImagePath.imageSample1.path,
        title:
            'Cajun spiced Cauliflower Rice with Chicken uzun text deneme uzun text deneme'
            'uzun text deneme',
        missingItems: [
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
        recipeModel: RecipeModel(
            ingredients: [
              IngredientModel(title: 'Egg', quantity: 4),
              IngredientModel(title: 'Butter', quantity: 1 / 2),
              IngredientModel(title: 'Butter', quantity: 1 / 2),
              IngredientModel(title: 'Egg', quantity: 4),
              IngredientModel(title: 'Butter', quantity: 1 / 2),
              IngredientModel(title: 'Butter', quantity: 1 / 2),
            ],
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
            directions: directionText),
      ),
      LikeRecipeModel(
        imagePath: ImagePath.imageSample2.path,
        title: 'Cajun spiced Cauliflower Rice with Chicken',
        missingItems: [
          IngredientModel(
              title: 'milk', imagePath: ImagePath.milk.path, quantity: 5),
          IngredientModel(
              title: 'egg', imagePath: ImagePath.egg.path, quantity: 3),
        ],
        recipeModel: RecipeModel(
            ingredients: [
              IngredientModel(title: 'Egg', quantity: 4),
              IngredientModel(title: 'Butter', quantity: 1 / 2),
              IngredientModel(title: 'Butter', quantity: 1 / 2),
            ],
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
            directions: directionText),
      ),
      LikeRecipeModel(
        imagePath: ImagePath.imageSample3.path,
        title: 'Cajun spiced Cauliflower Rice with Chicken',
        missingItems: [
          IngredientModel(title: 'somon'),
          IngredientModel(title: 'bread'),
          IngredientModel(title: 'milk'),
        ],
        recipeModel: RecipeModel(
            ingredients: [
              IngredientModel(title: 'Egg', quantity: 4),
              IngredientModel(title: 'Butter', quantity: 1 / 2),
              IngredientModel(title: 'Butter', quantity: 1 / 2),
            ],
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
            directions: directionText),
      ),
      LikeRecipeModel(
        imagePath: ImagePath.imageSample4.path,
        title: 'Cajun spiced Cauliflower Rice with Chicken',
        recipeModel: RecipeModel(
            ingredients: [
              IngredientModel(title: 'Egg', quantity: 4),
              IngredientModel(title: 'Butter', quantity: 1 / 2),
              IngredientModel(title: 'Butter', quantity: 1 / 2),
            ],
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
            directions: directionText),
      ),
      LikeRecipeModel(
        imagePath: ImagePath.imageSample1.path,
        title: 'Cajun spiced Cauliflower Rice with Chicken',
        recipeModel: RecipeModel(
            ingredients: [
              IngredientModel(title: 'Egg', quantity: 4),
              IngredientModel(title: 'Butter', quantity: 1 / 2),
              IngredientModel(title: 'Butter', quantity: 1 / 2),
            ],
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
            directions: directionText),
      ),
    ];

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
    changeMissingItemListTargetState(false);
    changeMyFrizeListTargetState(false);
  }

  void changeMissingItemListTargetState(bool state) {
    missingItemListTargetState = state;
    emit(MissingItemListTargetState(missingItemListTargetState));
    print('missingItemListTargetState $missingItemListTargetState');
  }

  void changeMyFrizeListTargetState(bool state) {
    myFrizeListTargetState = state;
    emit(MyFrizeItemTargetState(myFrizeListTargetState));
    print('myFrizeItemTargetState $myFrizeListTargetState');
  }

  void addItemToMissingList(
      int cardIndex, IngredientModel itemModelToBeDeleted) {
    likeRecipeItems[cardIndex].missingItems!.add(itemModelToBeDeleted);

    emit(MissingItemListLoad(
        likeRecipeItems[cardIndex].missingItems!.toSet().toList()!));
  }

  void removeMissingItem(int cardIndex, int missingItemIndex) {
    likeRecipeItems[cardIndex].missingItems!.removeAt(missingItemIndex);

    emit(MissingItemListLoad(
        likeRecipeItems[cardIndex].missingItems!.toSet().toList()!));
  }

  void addItemToMyFrizeList(IngredientModel itemModelToBeDeleted) {
    myFrizeItems.add(itemModelToBeDeleted);

    emit(MyFrizeListLoad(myFrizeItems.toSet().toList()));
  }

  void removeMyFrizeItem(int myFrizeItemIndex) {
    myFrizeItems.removeAt(myFrizeItemIndex);

    emit(MyFrizeListLoad(myFrizeItems.toSet().toList()!));
  }

  void missingItemLoad(int cardIndex) {
    emit(MissingItemListLoad(
        likeRecipeItems[cardIndex].missingItems!.toSet().toList()));
  }

  @override
  BuildContext? context;

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void dispose() {
    likeRecipeItems = [];
  }
}
