import 'package:recipe_finder/product/model/ingredient/ingredient_model.dart';

class RecipeModel {
  final List<IngredientModel> ingredients;
  final String title;
  final String? imagePath;
  final String? description;
  final String? directions;
  final String? videoPath;

  RecipeModel({required this.ingredients, required this.title, required this.imagePath, this.videoPath, this.description, this.directions});
}
