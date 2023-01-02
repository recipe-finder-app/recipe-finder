import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../../core/base/model/base_view_model.dart';
import '../../../core/constant/design/color_constant.dart';
import '../service/recipe_detail_service.dart';
import 'recipe_detail_state.dart';

class RecipeDetailCubit extends Cubit<IRecipeDetailState>
    implements IBaseViewModel {
  IRecipeDetailService? service;
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  RecipeDetailCubit() : super(RecipeDetailInit());

  @override
  void init() {
    service = RecipeDetailService();
    videoPlayerInit();
  }

  void videoPlayerInit() {
    videoPlayerController = VideoPlayerController.asset('asset/video/pizza.mp4')
      ..initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      showControlsOnInitialize: true,
      autoPlay: false,
      looping: false,
      aspectRatio: 1.30,
      progressIndicatorDelay: const Duration(seconds: 2),
      customControls: const Padding(
        padding: EdgeInsets.only(bottom: 55, top: 35, right: 15, left: 15),
        child: CupertinoControls(
          backgroundColor: Colors.grey,
          iconColor: Colors.white,
        ),
      ),
    );
    /* Padding(
      padding: EdgeInsets.all(50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  chewieController.toggleFullScreen();
                },
                icon: Icon(
                  Icons.fullscreen,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.volume_up,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    ),*/
    /*const Padding(
    padding: EdgeInsets.only(bottom: 55),
    child: CupertinoControls(
    backgroundColor: Colors.grey,
    iconColor: Colors.white,
    ),
    ),*/
  }

  int selectedCategoryIndex = 0;

  void changeSelectedCategoryIndex(int index) {
    selectedCategoryIndex = index;
    emit(ChangeSelectedCategoryIndex(selectedCategoryIndex));
  }

  Color categoryItemColor(int index) {
    if (index == selectedCategoryIndex) {
      return ColorConstants.instance.oriolesOrange;
    } else {
      return Colors.white;
    }
  }

  Color categoryTextColor(int index) {
    if (index == selectedCategoryIndex) {
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
