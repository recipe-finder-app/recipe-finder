import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/base/model/base_view_model.dart';
import 'package:recipe_finder/feature/finder_page/cubit/finder_state.dart';
import 'package:recipe_finder/feature/finder_page/model/image_model.dart';
import 'package:recipe_finder/feature/finder_page/service/finder_service.dart';
import 'package:swipable_stack/swipable_stack.dart';

class FinderCubit extends Cubit<IFinderState> implements IBaseViewModel {
  IFinderService? service;

  FinderCubit() : super(FinderInit());

  @override
  void init() {
    //controller = SwipableStackController()..addListener(listenController);
    service = FinderService();
  }

  late final SwipableStackController controller;

  List<RecipeModel> draggableItems = [
    const RecipeModel(
        distance: 'Cajun spiced Cauliflower Rice with Chicken Sausage',
        imageAsset: 'asset/png/image.png'),
    const RecipeModel(
        distance: 'Cajun spiced Cauliflower Rice with Chicken Sausage',
        imageAsset: 'asset/png/image1.png'),
    const RecipeModel(
        distance: 'Cajun spiced Cauliflower Rice with Chicken Sausage',
        imageAsset: 'asset/png/image.png'),
    const RecipeModel(
        distance: 'Cajun spiced Cauliflower Rice with Chicken Sausage',
        imageAsset: 'asset/png/image1.png'),
    const RecipeModel(
        distance: 'Cajun spiced Cauliflower Rice with Chicken Sausage',
        imageAsset: 'asset/png/image.png'),
    const RecipeModel(
        distance: 'Cajun spiced Cauliflower Rice with Chicken Sausage',
        imageAsset: 'asset/png/image1.png'),
    const RecipeModel(
        distance: 'Cajun spiced Cauliflower Rice with Chicken Sausage',
        imageAsset: 'asset/png/image.png'),
    const RecipeModel(
        distance: 'Cajun spiced Cauliflower Rice with Chicken Sausage',
        imageAsset: 'asset/png/image1.png'),
    const RecipeModel(
        distance: 'Cajun spiced Cauliflower Rice with Chicken Sausage',
        imageAsset: 'asset/png/image.png'),
    const RecipeModel(
        distance: 'Cajun spiced Cauliflower Rice with Chicken Sausage',
        imageAsset: 'asset/png/image1.png'),
    const RecipeModel(
        distance: 'Cajun spiced Cauliflower Rice with Chicken Sausage',
        imageAsset: 'asset/png/image.png'),
    const RecipeModel(
        distance: 'Cajun spiced Cauliflower Rice with Chicken Sausage',
        imageAsset: 'asset/png/image1.png'),
  ];

 

  // void listenController() {
  //   emit(state);
  // }

  @override
  void dispose() {
    // controller
    //   ..removeListener(listenController)
    //   ..dispose();
  }

  @override
  BuildContext? context;

  @override
  void setContext(BuildContext context) => this.context = context;
}
