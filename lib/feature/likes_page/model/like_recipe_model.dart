import '../../../product/model/ingradient_model.dart';
import '../../../product/model/recipe_model.dart';

class LikeRecipeModel {
  final List<IngredientModel>? missingItems;
  final RecipeModel recipeModel;

  LikeRecipeModel({this.missingItems, required this.recipeModel});
}
