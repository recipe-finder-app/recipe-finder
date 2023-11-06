import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/product/model/ingredient_quantity/ingredient_quantity.dart';
import 'package:recipe_finder/product/service/common_service.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

import '../../../core/base/model/base_view_model.dart';
import '../../../core/constant/design/color_constant.dart';
import '../../../core/init/cache/hive_manager.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../../product/model/recipe/recipe.dart';
import '../../../product/model/user/user_model.dart';
import '../../../product/utils/enum/hive_enum.dart';
import '../../likes_page/cubit/likes_cubit.dart';
import '../service/recipe_detail_service.dart';
import 'recipe_detail_state.dart';

class RecipeDetailCubit extends Cubit<IRecipeDetailState> implements IBaseViewModel {
  IRecipeDetailService? service;
  late ICommonService commonService;
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  RecipeDetailCubit() : super(RecipeDetailInit());

  @override
  void init() {
    service = RecipeDetailService();
    commonService = CommonService();
    videoPlayerInit();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      showControlsOnInitialize: true,
      autoPlay: false,
      looping: false,
      aspectRatio: 1.30,
      progressIndicatorDelay: const Duration(seconds: 2),
      customControls:Padding(
        padding:const EdgeInsets.only(bottom: 45, top: 35, right: 15, left: 15),
        child: CupertinoControls(
          backgroundColor: ColorConstants.instance.russianViolet,
          iconColor: Colors.white,
        ),
      ),
    );
    selectedTabBarIndex = 0;
    selectedPreviousTabBarIndex = 0;
  }
  
  Future<List<IngredientQuantity>?> fetchFrizeIngredientList() async{
    try{
       final IHiveManager<UserModel> hiveManager = HiveManager<UserModel>(HiveBoxEnum.userModel);
       final user = await hiveManager.get(HiveKeyEnum.user);
       if(user?.id!=null){
    final ingredientList = await commonService.fetchAllFrizeItemList(user!.id!);
    print(ingredientList);
    return ingredientList;
       }
       else{
        return [];
       }
    }
    catch (e) {

    }
    return null;
  }
  void share(Recipe recipeModel) {
    String ingredientsText = '';
    for (var ingredient in recipeModel.ingredients!) {
      ingredientsText = '$ingredientsText\n ${ingredient.quantity} ${ingredient.nameEN}';
    }

    String message = '${LocaleKeys.ingredients.locale}\n'
        '$ingredientsText\n\n'
        '${LocaleKeys.description}\n\n'
        '${recipeModel.descriptionEN}\n\n'
        '${LocaleKeys.directions}\n\n'
        '${recipeModel.directionsEN}\n\n';
    Share.share(message);
  }

  bool isSavedRecipeContainThisRecipe(Recipe recipeModel) {
    bool result = context!.read<LikesCubit>().recipeList.contains(recipeModel);
    return result;
  }

  void videoPlayerInit() {
    videoPlayerController = VideoPlayerController.asset('asset/video/pizza.mp4')..initialize();
  }

  late int selectedTabBarIndex;
  late int selectedPreviousTabBarIndex;

  void changeSelectedTabBarIndex(int index) {
    selectedTabBarIndex = index;
    emit(ChangeSelectedTabBarIndex(selectedTabBarIndex));
  }

  void changePreviousSelectedTabBarIndex(int index) {
    selectedPreviousTabBarIndex = index;
    emit(ChangePreviousClickedTabBarIndex(selectedPreviousTabBarIndex));
  }

  Color categoryItemColor(int index) {
    if (index == selectedTabBarIndex) {
      return ColorConstants.instance.oriolesOrange;
    } else {
      return Colors.white;
    }
  }

  Color categoryTextColor(int index) {
    if (index == selectedTabBarIndex) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  @override
  BuildContext? context;

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
  }
}
