import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base/model/base_view_model.dart';
import '../../../core/constant/enum/image_path_enum.dart';
import '../../../product/model/ingradient_model.dart';
import '../../../product/model/recipe_model.dart';
import '../model/like_recipe_model.dart';
import '../service/likes_service.dart';
import 'likes_state.dart';

class LikesCubit extends Cubit<ILikesState> implements IBaseViewModel {
  late GlobalKey<FormState> loginFormKey;
  late GlobalKey<FormState> createAccountFormKey;
  late GlobalKey<FormState> forgotPasswordFormKey;
  ILikesService? service;

  late final List<LikeRecipeModel> likeRecipeItems;
  late final List<IngredientModel> myFrizeItems;

  LikesCubit() : super(LikesInit());

  @override
  void init() {
    loginFormKey = GlobalKey<FormState>();
    createAccountFormKey = GlobalKey<FormState>();
    forgotPasswordFormKey = GlobalKey<FormState>();

    service = LikesService();

    likeRecipeItems = [
      LikeRecipeModel(
        imagePath: ImagePath.imageSample1.path,
        title:
            'Cajun spiced Cauliflower Rice with Chicken uzun text deneme uzun text deneme'
            'uzun text deneme',
        missingItems: [
          IngredientModel(
              title: 'egg', imagePath: ImagePath.egg.path, quantity: 5),
          IngredientModel(
              title: 'milk', imagePath: ImagePath.milk.path, quantity: 6),
          IngredientModel(
              title: 'bread', imagePath: ImagePath.bread.path, quantity: 3),
          IngredientModel(
              title: 'salad', imagePath: ImagePath.salad.path, quantity: 2),
          IngredientModel(
              title: 'egg', imagePath: ImagePath.egg.path, quantity: 4),
        ],
        recipeModel: RecipeModel(
            directions: 'asdadasdaddadasdada',
            description: 'şiş kebab yapımı anlatılıyor',
            ingredients: [
              IngredientModel(title: 'et'),
            ]),
      ),
      LikeRecipeModel(
        imagePath: ImagePath.imageSample2.path,
        title: 'Cajun spiced Cauliflower Rice with Chicken',
        missingItems: [
          IngredientModel(
              title: 'milk', imagePath: ImagePath.milk.path, quantity: 5),
          IngredientModel(
              title: 'egg', imagePath: ImagePath.egg.path, quantity: 3),
        ],
        recipeModel: RecipeModel(
            directions: 'asdadasdaddadasdada',
            description: 'vejeteryan yemek',
            ingredients: [
              IngredientModel(title: 'sebze'),
            ]),
      ),
      LikeRecipeModel(
        imagePath: ImagePath.imageSample3.path,
        title: 'Cajun spiced Cauliflower Rice with Chicken',
        missingItems: [
          IngredientModel(title: 'somon'),
          IngredientModel(title: 'bread'),
          IngredientModel(title: 'milk'),
        ],
        recipeModel: RecipeModel(
            directions: 'asdadasdaddadasdada',
            description: 'hamburger yapımı',
            ingredients: [
              IngredientModel(title: 'hamburger köftesi'),
            ]),
      ),
      LikeRecipeModel(
        imagePath: ImagePath.imageSample4.path,
        title: 'Cajun spiced Cauliflower Rice with Chicken',
        recipeModel: RecipeModel(
            directions: 'asdadasdaddadasdada',
            description: 'şiş kebab yapımı anlatılıyor',
            ingredients: [
              IngredientModel(title: 'et'),
            ]),
      ),
      LikeRecipeModel(
        imagePath: ImagePath.imageSample1.path,
        title: 'Cajun spiced Cauliflower Rice with Chicken',
        recipeModel: RecipeModel(
            directions: 'asdadasdaddadasdada',
            description: 'şiş kebab yapımı anlatılıyor',
            ingredients: [
              IngredientModel(title: 'et'),
            ]),
      ),
    ];
    myFrizeItems = [
      IngredientModel(
          title: 'milk', imagePath: ImagePath.milk.path, quantity: 6),
      IngredientModel(
          title: 'bread', imagePath: ImagePath.bread.path, quantity: 3),
      IngredientModel(
          title: 'salad', imagePath: ImagePath.salad.path, quantity: 2),
    ];
  }

  void addItemMyFrize(int cardIndex, IngredientModel itemModelToBeDeleted) {
    likeRecipeItems[cardIndex].missingItems!.remove(itemModelToBeDeleted);
    myFrizeItems.add(itemModelToBeDeleted);

    emit(UpdateIngredientList(myFrizeItems));
    emit(UpdateIngredientList(likeRecipeItems[cardIndex].missingItems!));
    print("------------");
    for (var i in likeRecipeItems[cardIndex].missingItems!) {
      print(i.title);
    }
    print("------------");
    for (var i in myFrizeItems!) {
      print(i.title);
    }
  }

  @override
  BuildContext? context;

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void dispose() {
    likeRecipeItems = [];
  }
}
