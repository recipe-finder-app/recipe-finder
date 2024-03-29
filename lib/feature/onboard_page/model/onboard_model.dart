import '../../../product/utils/constant/image_path_enum.dart';
import '../../../core/init/language/locale_keys.g.dart';

class OnboardModel {
  String imagePath;
  String title;
  String explanation;

  OnboardModel({
    required this.imagePath,
    required this.title,
    required this.explanation,
  });
}

class OnboardItems {
  late List<OnboardModel> items;

  OnboardItems() {
    items = [
      OnboardModel(
        imagePath: ImagePathConstant.onboardImage1.path,
        title: LocaleKeys.chooseTheItemsInYourCloset,
        explanation:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
      ),
      OnboardModel(
        imagePath: ImagePathConstant.onboardImage2.path,
        title: LocaleKeys.chooseYourSpecialRecipe,
        explanation:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
      ),
      OnboardModel(
        imagePath: ImagePathConstant.onboardImage3.path,
        title: LocaleKeys.startDoing,
        explanation:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
      ),
    ];
  }
}
