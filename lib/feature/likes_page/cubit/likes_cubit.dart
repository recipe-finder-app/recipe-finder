import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base/model/base_view_model.dart';
import '../../../product/model/ingredient_quantity/ingredient_quantity.dart';
import '../../../product/utils/constant/image_path_enum.dart';
import '../../../product/model/recipe/recipe_model.dart';
import '../service/likes_service.dart';
import 'likes_state.dart';

class LikesCubit extends Cubit<ILikesState> implements IBaseViewModel {
  ILikesService? service;
  bool? missingItemIsDragging;
  bool? myFrizeItemIsDragging;
  late ScrollController scrollController;
  late List<Recipe> recipeList = [
    Recipe(
        ingredients: [
          IngredientQuantity(nameEN: 'Egg', quantity: 4, imagePath: ImagePathConstant.egg.path),
          IngredientQuantity(nameEN: 'Butter', quantity: 1 / 2),
          IngredientQuantity(nameEN: 'Butter', quantity: 1 / 2),
          IngredientQuantity(nameEN: 'Egg', quantity: 4),
          IngredientQuantity(nameEN: 'Butter', quantity: 1 / 2),
          IngredientQuantity(nameEN: 'Butter', quantity: 1 / 2),
        ],
        nameEN: 'Cajun spiced Cauliflower Rice with Chicken uzun text deneme uzun text deneme'
            'uzun text deneme',
        imagePath: ImagePathConstant.imageSample1.path,
        videoPath: 'asset/video/samplevideo.mp4',
        descriptionEN: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
        directionsEN: directionText),
    Recipe(
        imagePath: ImagePathConstant.imageSample2.path,
        videoPath: 'asset/video/samplevideo.mp4',
        nameEN: 'Cajun spiced Cauliflower Rice with Chicken',
        ingredients: [
          IngredientQuantity(nameEN: 'Egg', quantity: 4),
          IngredientQuantity(nameEN: 'Butter', quantity: 1 / 2),
          IngredientQuantity(nameEN: 'Butter', quantity: 1 / 2),
        ],
        descriptionEN: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
        directionsEN: directionText),
    Recipe(
        imagePath: ImagePathConstant.imageSample3.path,
        videoPath: 'asset/video/pizza.mp4',
        nameEN: 'Cajun spiced Cauliflower Rice with Chicken',
        ingredients: [
          IngredientQuantity(nameEN: 'Egg', quantity: 4),
          IngredientQuantity(nameEN: 'Butter', quantity: 1 / 2),
          IngredientQuantity(nameEN: 'Butter', quantity: 1 / 2),
        ],
        descriptionEN: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
        directionsEN: directionText),
    Recipe(
        imagePath: ImagePathConstant.imageSample4.path,
        videoPath: 'asset/video/samplevideo.mp4',
        nameEN: 'Cajun spiced Cauliflower Rice with Chicken',
        ingredients: [
          IngredientQuantity(nameEN: 'Egg', quantity: 4),
          IngredientQuantity(nameEN: 'Butter', quantity: 1 / 2),
          IngredientQuantity(nameEN: 'Butter', quantity: 1 / 2),
        ],
        descriptionEN: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
        directionsEN: directionText),
    Recipe(
        imagePath: ImagePathConstant.imageSample1.path,
        videoPath: 'asset/video/pizza.mp4',
        nameEN: 'Cajun spiced Cauliflower Rice with Chicken',
        ingredients: [
          IngredientQuantity(nameEN: 'Egg', quantity: 4),
          IngredientQuantity(nameEN: 'Butter', quantity: 1 / 2),
          IngredientQuantity(nameEN: 'Butter', quantity: 1 / 2),
        ],
        descriptionEN: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
        directionsEN: directionText),
    Recipe(
        imagePath: ImagePathConstant.imageSample1.path,
        videoPath: 'asset/video/pizza.mp4',
        nameEN: 'Cajun spiced Cauliflower Rice with Chicken',
        ingredients: [
          IngredientQuantity(nameEN: 'Egg', quantity: 4),
          IngredientQuantity(nameEN: 'Butter', quantity: 1 / 2),
          IngredientQuantity(nameEN: 'Butter', quantity: 1 / 2),
        ],
        descriptionEN: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
        directionsEN: directionText),
    Recipe(
        imagePath: ImagePathConstant.imageSample1.path,
        videoPath: 'asset/video/pizza.mp4',
        nameEN: 'Cajun spiced Cauliflower Rice with Chicken uzun text deneme uzun text deneme'
            'uzun text deneme',
        ingredients: [
          IngredientQuantity(nameEN: 'Egg', quantity: 4),
          IngredientQuantity(nameEN: 'Butter', quantity: 1 / 2),
          IngredientQuantity(nameEN: 'Butter', quantity: 1 / 2),
          IngredientQuantity(nameEN: 'Egg', quantity: 4),
          IngredientQuantity(nameEN: 'Butter', quantity: 1 / 2),
          IngredientQuantity(nameEN: 'Butter', quantity: 1 / 2),
        ],
        descriptionEN: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
        directionsEN: directionText),
    Recipe(
        imagePath: ImagePathConstant.imageSample3.path,
        videoPath: 'asset/video/pizza.mp4',
        nameEN: 'Cajun spiced Cauliflower Rice with Chicken',
        ingredients: [
          IngredientQuantity(nameEN: 'Egg', quantity: 4, imagePath: ImagePathConstant.egg.path),
          IngredientQuantity(nameEN: 'Milk', quantity: 1 / 2, imagePath: ImagePathConstant.milk.name),
          IngredientQuantity(nameEN: 'Butter', quantity: 1 / 2, imagePath: ImagePathConstant.salad.path),
        ],
        descriptionEN: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
        directionsEN: directionText),
  ];

  late List<IngredientQuantity> myFrizeItems;

  String directionText =
      """Whisk egg, ketchup, Worcestershire sauce, salt, brown sugar, onion powder, garlic powder, thyme, and cayenne pepper together in a bowl. Add breadcrumbs and chopped cooked bacon. Crumble in the ground beef. Mix with your fingers until bacon and breadcrumbs are distributed evenly.
  Form mixture into 4 burgers with your wet hands. Cover with plastic wrap and refrigerate until chilled thoroughly, about 3 hours.
  Preheat an outdoor grill for medium-high heat and lightly oil the grate.
  Place burgers on the grate and cook, turing occasionally, until firm and cooked to your desired doneness. 
  Whisk egg, ketchup, Worcestershire sauce, salt, brown sugar, onion powder, garlic powder, thyme, and cayenne pepper together in a bowl. Add breadcrumbs and chopped cooked bacon. Crumble in the ground beef. Mix with your fingers until bacon and breadcrumbs are distributed evenly.
  Form mixture into 4 burgers with your wet hands. Cover with plastic wrap and refrigerate until chilled thoroughly, about 3 hours.
  Preheat an outdoor grill for medium-high heat and lightly oil the grate.
  Place burgers on the grate and cook, turing occasionally, until firm and cooked to your desired doneness.
  Whisk egg, ketchup, Worcestershire sauce, salt, brown sugar, onion powder, garlic powder, thyme, and cayenne pepper together in a bowl. Add breadcrumbs and chopped cooked bacon. Crumble in the ground beef. Mix with your fingers until bacon and breadcrumbs are distributed evenly.
  Form mixture into 4 burgers with your wet hands. Cover with plastic wrap and refrigerate until chilled thoroughly, about 3 hours.
  Preheat an outdoor grill for medium-high heat and lightly oil the grate.
  Place burgers on the grate and cook, turing occasionally, until firm and cooked to your desired doneness.
  Whisk egg, ketchup, Worcestershire sauce, salt, brown sugar, onion powder, garlic powder, thyme, and cayenne pepper together in a bowl. Add breadcrumbs and chopped cooked bacon. Crumble in the ground beef. Mix with your fingers until bacon and breadcrumbs are distributed evenly.
  Form mixture into 4 burgers with your wet hands. Cover with plastic wrap and refrigerate until chilled thoroughly, about 3 hours.
  Preheat an outdoor grill for medium-high heat and lightly oil the grate.
  Place burgers on the grate and cook, turing occasionally, until firm and cooked to your desired doneness.""";

  LikesCubit() : super(LikesInit());
  @override
  void init() {
    service = LikesService();
    scrollController = ScrollController();
    myFrizeItems = [
      IngredientQuantity(nameEN: 'milk', imagePath: ImagePathConstant.milk.path, quantity: 6),
      IngredientQuantity(nameEN: 'bread', imagePath: ImagePathConstant.bread.path, quantity: 3),
      IngredientQuantity(nameEN: 'salad', imagePath: ImagePathConstant.salad.path, quantity: 2),
      IngredientQuantity(nameEN: 'egg', imagePath: ImagePathConstant.egg.path, quantity: 3),
      IngredientQuantity(nameEN: 'potato', imagePath: ImagePathConstant.potato.path, quantity: 2),
      IngredientQuantity(nameEN: 'chicken', imagePath: ImagePathConstant.chicken.path, quantity: 2),
    ];
  }

  void deleteItemFromLikedRecipeList(Recipe model) {
    recipeList.remove(model);
    emit(LikesRecipeItemListLoad(recipeList.toSet().toList()));
  }

  void addItemFromLikedRecipeList(Recipe model) {
    recipeList.insert(0, model);
    emit(LikesRecipeItemListLoad(recipeList.toSet().toList()));
  }

  @override
  BuildContext? context;

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void dispose() {
    recipeList = [];
  }
}
