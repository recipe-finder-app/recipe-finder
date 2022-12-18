import 'package:chewie/chewie.dart';
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
  late ChewieController chewieController;
  RecipeDetailCubit() : super(RecipeDetailInit());

  @override
  void init() {
    service = RecipeDetailService();
    videoPlayerInit();
  }

  void videoPlayerInit() {
    videoPlayerController = VideoPlayerController.network(
        'https://file-examples.com/storage/fe88dacf086398d1c98749c/2017/04/file_example_MP4_640_3MG.mp4')
      ..initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: false,
      aspectRatio: videoPlayerController.value.aspectRatio,
    );
  }

  void clickRunVideoButton() {
    print('calisti');
    if (chewieController.isPlaying) {
      emit(VideoPlaybackState(chewieController.pause()));
    } else {
      emit(VideoPlaybackState(chewieController.play()));
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
