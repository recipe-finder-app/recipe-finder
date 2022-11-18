import '../../../product/model/ingradient_model.dart';
import '../../../product/model/recipe_model.dart';

class LikeRecipeModel {
  final String imagePath;
  final String title;
  final List<IngredientModel>? missingItems;
  final RecipeModel recipeModel;

  LikeRecipeModel(
      {required this.imagePath,
      required this.title,
      this.missingItems,
      required this.recipeModel});
}
