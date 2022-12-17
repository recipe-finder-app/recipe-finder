import 'package:recipe_finder/product/model/ingradient_model.dart';

class RecipeModel {
  final List<IngredientModel> ingredients;
  final String title;
  final String imagePath;
  final String? description;
  final String? directions;

  RecipeModel(
      {required this.ingredients,
      required this.title,
      required this.imagePath,
      this.description,
      this.directions});
}
