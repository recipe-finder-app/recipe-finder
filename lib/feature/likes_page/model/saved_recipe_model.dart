import '../../../core/constant/enum/image_path_enum.dart';

class SavedRecipeModel {
  final String imagePath;
  final String title;

  SavedRecipeModel({required this.imagePath, required this.title});
}

class SavedRecipeItems {
  late final List<SavedRecipeModel> items;

  SavedRecipeItems() {
    items = [
      SavedRecipeModel(
        imagePath: ImagePath.imageSample1.path,
        title:
            'Cajun spiced Cauliflower Rice with Chicken uzun text deneme uzun text deneme'
            'uzun text deneme',
      ),
      SavedRecipeModel(
        imagePath: ImagePath.imageSample2.path,
        title: 'Cajun spiced Cauliflower Rice with Chicken',
      ),
      SavedRecipeModel(
        imagePath: ImagePath.imageSample3.path,
        title: 'Cajun spiced Cauliflower Rice with Chicken',
      ),
      SavedRecipeModel(
        imagePath: ImagePath.imageSample4.path,
        title: 'Cajun spiced Cauliflower Rice with Chicken',
      ),
      SavedRecipeModel(
        imagePath: ImagePath.imageSample1.path,
        title: 'Cajun spiced Cauliflower Rice with Chicken',
      ),
    ];
  }
}
