import 'package:recipe_finder/product/model/ingradient_model.dart';

class RecipeModel {
  final List<IngredientModel> ingredients;
  final String description;
  final String directions;

  RecipeModel(
      {required this.ingredients,
      required this.description,
      required this.directions});
}
