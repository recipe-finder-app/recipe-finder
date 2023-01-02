import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base/model/base_view_model.dart';
import '../../../core/constant/enum/image_path_enum.dart';
import '../../../product/model/ingradient_model.dart';
import '../../../product/model/recipe_model.dart';
import '../service/likes_service.dart';
import 'likes_state.dart';

class LikesCubit extends Cubit<ILikesState> implements IBaseViewModel {
  ILikesService? service;
  bool? missingItemIsDragging;
  bool? myFrizeItemIsDragging;
  late ScrollController scrollController;
  late List<RecipeModel> recipeList = [
    RecipeModel(
        ingredients: [
          IngredientModel(
              title: 'Egg', quantity: 4, imagePath: ImagePath.egg.path),
          IngredientModel(title: 'Butter', quantity: 1 / 2),
          IngredientModel(title: 'Butter', quantity: 1 / 2),
          IngredientModel(title: 'Egg', quantity: 4),
          IngredientModel(title: 'Butter', quantity: 1 / 2),
          IngredientModel(title: 'Butter', quantity: 1 / 2),
        ],
        title:
            'Cajun spiced Cauliflower Rice with Chicken uzun text deneme uzun text deneme'
            'uzun text deneme',
        imagePath: ImagePath.imageSample1.path,
        videoPath: 'asset/video/samplevideo.mp4',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
        directions: directionText),
    RecipeModel(
        imagePath: ImagePath.imageSample2.path,
        videoPath: 'asset/video/samplevideo.mp4',
        title: 'Cajun spiced Cauliflower Rice with Chicken',
        ingredients: [
          IngredientModel(title: 'Egg', quantity: 4),
          IngredientModel(title: 'Butter', quantity: 1 / 2),
          IngredientModel(title: 'Butter', quantity: 1 / 2),
        ],
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
        directions: directionText),
    RecipeModel(
        imagePath: ImagePath.imageSample3.path,
        videoPath: 'asset/video/pizza.mp4',
        title: 'Cajun spiced Cauliflower Rice with Chicken',
        ingredients: [
          IngredientModel(title: 'Egg', quantity: 4),
          IngredientModel(title: 'Butter', quantity: 1 / 2),
          IngredientModel(title: 'Butter', quantity: 1 / 2),
        ],
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
        directions: directionText),
    RecipeModel(
        imagePath: ImagePath.imageSample4.path,
        videoPath: 'asset/video/samplevideo.mp4',
        title: 'Cajun spiced Cauliflower Rice with Chicken',
        ingredients: [
          IngredientModel(title: 'Egg', quantity: 4),
          IngredientModel(title: 'Butter', quantity: 1 / 2),
          IngredientModel(title: 'Butter', quantity: 1 / 2),
        ],
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
        directions: directionText),
    RecipeModel(
        imagePath: ImagePath.imageSample1.path,
        videoPath: 'asset/video/pizza.mp4',
        title: 'Cajun spiced Cauliflower Rice with Chicken',
        ingredients: [
          IngredientModel(title: 'Egg', quantity: 4),
          IngredientModel(title: 'Butter', quantity: 1 / 2),
          IngredientModel(title: 'Butter', quantity: 1 / 2),
        ],
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
        directions: directionText),
    RecipeModel(
        imagePath: ImagePath.imageSample1.path,
        videoPath: 'asset/video/pizza.mp4',
        title: 'Cajun spiced Cauliflower Rice with Chicken',
        ingredients: [
          IngredientModel(title: 'Egg', quantity: 4),
          IngredientModel(title: 'Butter', quantity: 1 / 2),
          IngredientModel(title: 'Butter', quantity: 1 / 2),
        ],
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
        directions: directionText),
    RecipeModel(
        imagePath: ImagePath.imageSample1.path,
        videoPath: 'asset/video/pizza.mp4',
        title:
            'Cajun spiced Cauliflower Rice with Chicken uzun text deneme uzun text deneme'
            'uzun text deneme',
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
    RecipeModel(
        imagePath: ImagePath.imageSample3.path,
        videoPath: 'asset/video/pizza.mp4',
        title: 'Cajun spiced Cauliflower Rice with Chicken',
        ingredients: [
          IngredientModel(
              title: 'Egg', quantity: 4, imagePath: ImagePath.egg.path),
          IngredientModel(
              title: 'Milk', quantity: 1 / 2, imagePath: ImagePath.milk.name),
          IngredientModel(
              title: 'Butter',
              quantity: 1 / 2,
              imagePath: ImagePath.salad.path),
        ],
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
        directions: directionText),
  ];

  late List<IngredientModel> myFrizeItems;

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

  void deleteItemFromLikedRecipeList(RecipeModel model) {
    recipeList.remove(model);
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
