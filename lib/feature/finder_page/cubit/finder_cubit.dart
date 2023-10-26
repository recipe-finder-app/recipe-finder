import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/base/model/base_view_model.dart';
import 'package:recipe_finder/product/utils/constant/image_path_enum.dart';
import 'package:recipe_finder/feature/finder_page/cubit/finder_state.dart';
import 'package:recipe_finder/feature/finder_page/service/finder_service.dart';
import '../../../product/model/ingredient_quantity/ingredient_quantity.dart';
import 'package:recipe_finder/product/model/recipe/recipe.dart';

class FinderCubit extends Cubit<IFinderState> implements IBaseViewModel {
  IFinderService? service;
  late List<Recipe> recipeList = [
    Recipe(
        ingredients: [
          IngredientQuantity(nameEN: 'Egg', quantity: 4, imageUrl: ImagePathConstant.egg.path),
          IngredientQuantity(nameEN: 'Milk', quantity: 2, imageUrl: ImagePathConstant.milk.path),
          IngredientQuantity(nameEN: 'Salad', quantity: 1 / 2, imageUrl: ImagePathConstant.salad.path),
          IngredientQuantity(nameEN: 'Potato', quantity: 4, imageUrl: ImagePathConstant.potato.path),
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
          IngredientQuantity(nameEN: 'Egg', quantity: 4, imageUrl: ImagePathConstant.egg.path),
          IngredientQuantity(nameEN: 'Milk', quantity: 2, imageUrl: ImagePathConstant.milk.path),
          IngredientQuantity(nameEN: 'Salad', quantity: 2, imageUrl: ImagePathConstant.salad.path),
          IngredientQuantity(nameEN: 'Potato', quantity: 4, imageUrl: ImagePathConstant.potato.path),
        ],
        descriptionEN: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing at dolor eu, et faucibus.',
        directionsEN: directionText),
  ];
  late int recipeListItemCount;
  late int topCardIndex;
  String directionText =
      """Whisk egg, ketchup, Worcestershire sauce, salt, brown sugar, onion powder, garlic powder, thyme, and cayenne pepper together in a bowl. Add breadcrumbs and chopped cooked bacon. Crumble in the ground beef. Mix with your fingers until bacon and breadcrumbs are distributed evenly.
  Form mixture into 4 burgers with your wet hands. Cover with plastic wrap and refrigerate until chilled thoroughly, about 3 hours.
  Preheat an outdoor grill for medium-high heat and lightly oil the grate.
  Place burgers on the grate and cook, turing occasionally, until firm and cooked to your desired doneness. """;

  FinderCubit() : super(FinderInit());

  @override
  void init() {
    service = FinderService();
    recipeListItemCount = recipeList.length ?? 0;
    topCardIndex = 0;
  }

  changeTopCardIndex(int index) {
    topCardIndex = index + 1;
    print(topCardIndex);
    emit(TopCardIndex(topCardIndex));
  }

  void changeRecipeListItemCount() {
    recipeListItemCount -= 1;
    emit(RecipeListItemCountCounter(recipeListItemCount));
  }

  @override
  void dispose() {}
  @override
  BuildContext? context;

  @override
  void setContext(BuildContext context) => this.context = context;
}
