import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/extension/string_extension.dart';
import 'package:recipe_finder/core/init/language/locale_keys.g.dart';
import 'package:recipe_finder/product/model/error_model.dart';
import 'package:recipe_finder/product/service/common_service.dart';
import 'package:recipe_finder/product/utils/enum/hive_enum.dart';

import '../../../core/base/model/base_view_model.dart';
import '../../../core/init/cache/hive_manager.dart';
import '../../../product/model/ingredient_quantity/ingredient_quantity.dart';
import '../../../product/model/user/user_model.dart';
import '../../../product/utils/constant/image_path_enum.dart';
import '../../../product/model/recipe/recipe.dart';
import '../service/likes_service.dart';
import 'likes_state.dart';

class LikesCubit extends Cubit<LikesState> implements IBaseViewModel {
  ILikesService? service;
  ICommonService? commonService;
  bool? missingItemIsDragging;
  bool? myFrizeItemIsDragging;


  LikesCubit() : super(const LikesState(isLoading: false,likedRecipeList: []),);
  @override
  Future<void> init() async {
    service = LikesService();
    commonService = CommonService();
    await fetchlikedRecipeList();
    
  }

  Future<void> removeItemFromLikedRecipeList(String recipeId) async {
      try{
     IHiveManager<UserModel> hiveManager = HiveManager<UserModel>(HiveBoxEnum.userModel);
      final user = await hiveManager.get(HiveKeyEnum.user);
      if(user?.id!=null){
   await commonService!.removeItemFromLikedRecipes(user!.id!, recipeId);
    final recipeList = state.likedRecipeList ?? [];
      recipeList.removeWhere((element) => element.id==recipeId);
      emit(state.copyWith(likedRecipeList: recipeList.toSet().toList())); 
      }
     
      }
       catch(e) {
     emit(state.copyWith(error:BaseError(message: LocaleKeys.anErrorOccured.locale)));
    }
   
  }


  Future<List<Recipe>> fetchlikedRecipeList() async {
    try{
      changeIsLoadingState();
    IHiveManager<UserModel> hiveManager = HiveManager<UserModel>(HiveBoxEnum.userModel);
 final user = await hiveManager.get(HiveKeyEnum.user);
 if(user?.id!=null){
     final recipeList = await commonService!.fetchLikedRecipes(user!.id!);
     emit(state.copyWith(likedRecipeList: recipeList));
     return recipeList;
 }
 else {
  return [];
 }
    }
    catch(e) {
     emit(state.copyWith(error:BaseError(message: LocaleKeys.anErrorOccured.locale)));
     return [];
    }
    finally {
      changeIsLoadingState();
    }
  }
  void changeIsLoadingState() {

    emit(state.copyWith(isLoading: !state.isLoading!));
  }
  @override
  BuildContext? context;

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void dispose() {
  
  }
}
