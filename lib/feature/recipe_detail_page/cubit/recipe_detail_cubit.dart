import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../../core/base/model/base_view_model.dart';
import '../service/recipe_detail_service.dart';
import 'recipe_detail_state.dart';

class RecipeDetailCubit extends Cubit<IRecipeDetailState>
    implements IBaseViewModel {
  IRecipeDetailService? service;
  late VideoPlayerController videoPlayerController;

  RecipeDetailCubit() : super(RecipeDetailInit());

  @override
  void init() {
    service = RecipeDetailService();
    videoPlayerController = VideoPlayerController.network(
        'https://file-examples.com/storage/fe88dacf086398d1c98749c/2017/04/file_example_MP4_640_3MG.mp4')
      ..initialize().then((value) {});
  }

  void clickRunVideoButton() {
    print('calisti');
    if (videoPlayerController.value.isPlaying) {
      emit(VideoPlaybackState(videoPlayerController.pause()));
    } else {
      emit(VideoPlaybackState(videoPlayerController.play()));
    }
  }

  @override
  BuildContext? context;

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void dispose() {
    videoPlayerController.dispose();
  }
}
